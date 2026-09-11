; ═══════════════════════════════════════════════════════════════════════
;  Cypher — Android app installer
;
;  One script, compiled once per app by installer/build-installers.js:
;
;    ISCC /DAppName="Cypher Music" /DAppSlug=CypherMusic /DAppVersion=2.121
;         /DAppId={{GUID} /DApkFile="..\dist\CypherMusic-2.121.apk"
;         /DIconFile="assets\cypher-music.ico" cypher-app.iss
;
;  What the wizard does, in order:
;    1. asks whether to install on a phone, or only keep the APK here
;    2. if installing: lists the devices adb can see, with a rescan button
;    3. copies the APK and adb onto this PC
;    4. pushes the APK with `adb install -r`
;
;  `-r` keeps the app's existing data, because every Cypher release is
;  signed with the same key. Nothing needs administrator rights: it
;  installs per-user and only talks to the phone over adb.
; ═══════════════════════════════════════════════════════════════════════

#ifndef AppName
  #error Compile with /DAppName /DAppSlug /DAppVersion /DAppId /DApkFile
#endif
#ifndef Publisher
  #define Publisher "Kencypher"
#endif
#ifndef AppUrl
  #define AppUrl "https://kencypher.netlify.app"
#endif
#define ApkName ExtractFileName(ApkFile)

[Setup]
AppId={#AppId}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher={#Publisher}
AppPublisherURL={#AppUrl}
AppSupportURL={#AppUrl}
DefaultDirName={autopf}\Cypher\{#AppSlug}
DefaultGroupName=Cypher
DisableProgramGroupPage=yes
UninstallDisplayName={#AppName} {#AppVersion}
OutputDir=..\dist
OutputBaseFilename={#AppSlug}-Setup-{#AppVersion}
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
WizardSizePercent=110
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
VersionInfoVersion={#AppVersion}
VersionInfoCompany={#Publisher}
VersionInfoDescription={#AppName} installer
#ifdef IconFile
SetupIconFile={#IconFile}
UninstallDisplayIcon={app}\{#AppSlug}.ico
#endif

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "{#ApkFile}";             DestDir: "{app}"; Flags: ignoreversion
Source: "tools\adb.exe";          DestDir: "{app}\tools"; Flags: ignoreversion
Source: "tools\AdbWinApi.dll";    DestDir: "{app}\tools"; Flags: ignoreversion
Source: "tools\AdbWinUsbApi.dll"; DestDir: "{app}\tools"; Flags: ignoreversion
#ifdef IconFile
Source: "{#IconFile}";            DestDir: "{app}"; DestName: "{#AppSlug}.ico"; Flags: ignoreversion
#endif
#ifdef ReadmeFile
Source: "{#ReadmeFile}";          DestDir: "{app}"; DestName: "How to install.txt"; Flags: ignoreversion isreadme
#endif

[Icons]
Name: "{group}\{#AppName} - install to phone"; Filename: "{app}\tools\adb.exe"; \
      Parameters: "install -r ""{app}\{#ApkName}"""; WorkingDir: "{app}"; \
      Comment: "Push {#AppName} to a connected phone"
Name: "{group}\{#AppName} - APK folder"; Filename: "{app}"
Name: "{group}\{#AppName} on the web"; Filename: "{#AppUrl}"

[Run]
Filename: "{app}"; Description: "Open the folder holding the APK"; \
          Flags: shellexec postinstall skipifsilent unchecked

[UninstallRun]
Filename: "{app}\tools\adb.exe"; Parameters: "kill-server"; Flags: runhidden; RunOnceId: "adbkill"

[Code]
var
  ModePage: TInputOptionWizardPage;
  DevicePage: TWizardPage;
  DeviceList: TNewCheckListBox;
  RescanButton: TNewButton;
  DeviceHint: TNewStaticText;
  InstallResult: String;

const
  MODE_PHONE = 0;
  MODE_SAVE  = 1;

{ Run adb and hand back what it printed, line by line. cmd /c does the
  redirection, because Exec cannot capture output on its own. }
function RunAdb(const Exe, Args: String; var Lines: TArrayOfString): Boolean;
var
  TmpOut: String;
  Code: Integer;
begin
  SetArrayLength(Lines, 0);
  TmpOut := ExpandConstant('{tmp}\adb-out.txt');
  DeleteFile(TmpOut);
  Result := Exec(ExpandConstant('{cmd}'),
                 '/C ""' + Exe + '" ' + Args + '" > "' + TmpOut + '" 2>&1',
                 '', SW_HIDE, ewWaitUntilTerminated, Code);
  if Result then
    Result := LoadStringsFromFile(TmpOut, Lines);
  DeleteFile(TmpOut);
end;

function JoinLines(const Lines: TArrayOfString): String;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to GetArrayLength(Lines) - 1 do
    Result := Result + Lines[i] + #13#10;
end;

// adb must exist before {app} is populated, so keep a copy under {tmp}.
function StagedAdb: String;
var
  Dir: String;
begin
  Dir := ExpandConstant('{tmp}\adbtool');
  Result := Dir + '\adb.exe';
  if not FileExists(Result) then
  begin
    ForceDirectories(Dir);
    ExtractTemporaryFile('adb.exe');
    ExtractTemporaryFile('AdbWinApi.dll');
    ExtractTemporaryFile('AdbWinUsbApi.dll');
    FileCopy(ExpandConstant('{tmp}\adb.exe'), Result, False);
    FileCopy(ExpandConstant('{tmp}\AdbWinApi.dll'), Dir + '\AdbWinApi.dll', False);
    FileCopy(ExpandConstant('{tmp}\AdbWinUsbApi.dll'), Dir + '\AdbWinUsbApi.dll', False);
  end;
end;

procedure ScanDevices;
var
  Lines: TArrayOfString;
  Line, Serial, State: String;
  i, Tab, Found: Integer;
begin
  DeviceList.Items.Clear;
  Found := 0;
  DeviceHint.Caption := 'Looking for a phone...';
  WizardForm.Refresh;

  RunAdb(StagedAdb, 'start-server', Lines);
  if RunAdb(StagedAdb, 'devices', Lines) then
  begin
    for i := 0 to GetArrayLength(Lines) - 1 do
    begin
      Line := Trim(Lines[i]);
      if Line = '' then Continue;
      if Pos('List of devices', Line) = 1 then Continue;
      if Pos('daemon', Line) > 0 then Continue;

      Tab := Pos(#9, Line);
      if Tab = 0 then Continue;
      Serial := Trim(Copy(Line, 1, Tab - 1));
      State := Trim(Copy(Line, Tab + 1, Length(Line)));

      if CompareText(State, 'device') = 0 then
      begin
        DeviceList.AddRadioButton(Serial, '', 0, Found = 0, True, nil);
        Found := Found + 1;
      end
      else if CompareText(State, 'unauthorized') = 0 then
        DeviceList.AddRadioButton(Serial + '   (not authorised - tap Allow on the phone)',
                                  '', 0, False, False, nil);
    end;
  end;

  if Found = 0 then
    DeviceHint.Caption :=
      'No phone found.' + #13#10 +
      'Connect it by USB with USB debugging turned on, or pair it first using' + #13#10 +
      'wireless debugging, then press Scan again. You can also go back and' + #13#10 +
      'choose to just save the APK.'
  else if Found = 1 then
    DeviceHint.Caption := 'One phone found. Press Next to install.'
  else
    DeviceHint.Caption := 'Choose the phone to install on, then press Next.';
end;

procedure RescanClick(Sender: TObject);
begin
  ScanDevices;
end;

procedure InitializeWizard;
begin
  ModePage := CreateInputOptionPage(wpSelectDir,
    'Install {#AppName}',
    'What would you like to do?',
    'This installer can put {#AppName} straight onto your phone, or simply keep the APK on this PC so you can move it across yourself.',
    True, False);
  ModePage.Add('Install it on my phone now');
  ModePage.Add('Just save the APK to this PC');
  ModePage.SelectedValueIndex := MODE_PHONE;

  DevicePage := CreateCustomPage(ModePage.ID, 'Choose your phone',
    'These are the devices adb can currently see.');

  DeviceList := TNewCheckListBox.Create(WizardForm);
  DeviceList.Parent := DevicePage.Surface;
  DeviceList.Left := 0;
  DeviceList.Top := 0;
  DeviceList.Width := DevicePage.SurfaceWidth;
  DeviceList.Height := ScaleY(96);
  DeviceList.BorderStyle := bsSingle;
  DeviceList.Flat := True;

  RescanButton := TNewButton.Create(WizardForm);
  RescanButton.Parent := DevicePage.Surface;
  RescanButton.Top := DeviceList.Top + DeviceList.Height + ScaleY(8);
  RescanButton.Left := 0;
  RescanButton.Width := ScaleX(96);
  RescanButton.Height := ScaleY(25);
  RescanButton.Caption := 'Scan again';
  RescanButton.OnClick := @RescanClick;

  DeviceHint := TNewStaticText.Create(WizardForm);
  DeviceHint.Parent := DevicePage.Surface;
  DeviceHint.Top := RescanButton.Top + RescanButton.Height + ScaleY(12);
  DeviceHint.Left := 0;
  DeviceHint.Width := DevicePage.SurfaceWidth;
  DeviceHint.AutoSize := False;
  DeviceHint.WordWrap := True;
  DeviceHint.Height := ScaleY(64);
  DeviceHint.Caption := '';
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := (PageID = DevicePage.ID) and (ModePage.SelectedValueIndex <> MODE_PHONE);
end;

function SelectedSerial: String;
var
  i, Marker: Integer;
begin
  Result := '';
  for i := 0 to DeviceList.Items.Count - 1 do
    if DeviceList.Checked[i] then
    begin
      Result := DeviceList.ItemCaption[i];
      Marker := Pos('   (', Result);
      if Marker > 0 then
        Result := Trim(Copy(Result, 1, Marker - 1));
      Exit;
    end;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = DevicePage.ID then
    ScanDevices
  else if (CurPageID = wpFinished) and (InstallResult <> '') then
    WizardForm.FinishedLabel.Caption := InstallResult;
end;

function UpdateReadyMemo(Space, NewLine, MemoUserInfo, MemoDirInfo, MemoTypeInfo,
  MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
begin
  Result := MemoDirInfo + NewLine + NewLine;
  if ModePage.SelectedValueIndex = MODE_PHONE then
    Result := Result + 'Then install on the phone:' + NewLine + Space + SelectedSerial
  else
    Result := Result + 'The APK will only be saved to this PC.';
end;

// Once the files are in {app}, push the APK if a phone was chosen.
procedure CurStepChanged(CurStep: TSetupStep);
var
  Lines: TArrayOfString;
  AdbOut, Serial: String;
begin
  if CurStep <> ssPostInstall then Exit;
  InstallResult := '';

  if ModePage.SelectedValueIndex <> MODE_PHONE then
  begin
    InstallResult := 'The APK was saved to:' + #13#10 + ExpandConstant('{app}') + #13#10 + #13#10 +
                     'Copy it to your phone and open it there to install.';
    Exit;
  end;

  Serial := SelectedSerial;
  if Serial = '' then
  begin
    InstallResult := 'No phone was selected, so the APK was only saved to this PC.';
    Exit;
  end;

  WizardForm.StatusLabel.Caption := 'Installing {#AppName} on ' + Serial + '...';
  WizardForm.Refresh;

  RunAdb(ExpandConstant('{app}\tools\adb.exe'),
         '-s ' + Serial + ' install -r "' + ExpandConstant('{app}\{#ApkName}') + '"', Lines);
  AdbOut := JoinLines(Lines);

  if Pos('Success', AdbOut) > 0 then
    InstallResult := '{#AppName} {#AppVersion} was installed on ' + Serial + '.' + #13#10 + #13#10 +
                     'Your existing data was kept.'
  else if Pos('INSTALL_FAILED_UPDATE_INCOMPATIBLE', AdbOut) > 0 then
    InstallResult := 'The phone already has a copy signed with a different key.' + #13#10 +
                     'Uninstall {#AppName} on the phone, then run this setup again.'
  else if Pos('INSTALL_FAILED_VERSION_DOWNGRADE', AdbOut) > 0 then
    InstallResult := 'The phone already has a newer version of {#AppName}.'
  else
    InstallResult := 'The install did not finish. The APK is here:' + #13#10 +
                     ExpandConstant('{app}') + #13#10 + #13#10 +
                     'adb reported:' + #13#10 + Trim(AdbOut);
end;
