Unicode true

!include "MUI2.nsh"

!ifndef APP_BINARY
  !error "Informe o caminho do executável compilado com /DAPP_BINARY=..."
!endif
!ifndef SETUP_OUTPUT
  !define SETUP_OUTPUT "..\artifacts\Auditor Fiscal BITMAX Setup 2.6.16.exe"
!endif

!define APP_NAME "Auditor Fiscal BITMAX"
!define APP_EXE "AuditorFiscalBitmax.exe"
!define APP_VERSION "2.6.16"
!define APP_UNINSTALL_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\AuditorFiscalBitmax"
!define APP_SETTINGS_KEY "Software\BITMAX\AuditorFiscalBitmax"

Name "${APP_NAME} ${APP_VERSION}"
OutFile "${SETUP_OUTPUT}"
InstallDir "$LOCALAPPDATA\Programs\Auditor Fiscal BITMAX"
InstallDirRegKey HKCU "${APP_SETTINGS_KEY}" "InstallDir"
RequestExecutionLevel user
SetCompressor /SOLID lzma
ShowInstDetails show
ShowUninstDetails show

VIProductVersion "2.6.16.0"
VIAddVersionKey "FileVersion" "2.6.16.0"
VIAddVersionKey "ProductName" "${APP_NAME}"
VIAddVersionKey "ProductVersion" "${APP_VERSION}"
VIAddVersionKey "FileDescription" "Instalador do ${APP_NAME}"
VIAddVersionKey "CompanyName" "BITMAX"
VIAddVersionKey "LegalCopyright" "BITMAX"

!define MUI_ABORTWARNING
!define MUI_ICON "bitmax_circulo.ico"
!define MUI_UNICON "bitmax_circulo.ico"
!define MUI_FINISHPAGE_RUN "$INSTDIR\${APP_EXE}"
!define MUI_FINISHPAGE_RUN_TEXT "Abrir o Auditor Fiscal BITMAX"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\REQUISITOS-PVA-PGE.html"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Ver os requisitos e os links oficiais do PVA/PGE"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "PortugueseBR"

Section "Aplicativo" SEC_APP
  SectionIn RO
  SetShellVarContext current
  SetOutPath "$INSTDIR"
  File /oname=${APP_EXE} "${APP_BINARY}"
  File "REQUISITOS-PVA-PGE.html"

  CreateDirectory "$SMPROGRAMS\${APP_NAME}"
  CreateShortcut "$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}"
  CreateShortcut "$SMPROGRAMS\${APP_NAME}\Requisitos do PVA-PGE.lnk" "$INSTDIR\REQUISITOS-PVA-PGE.html"
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  WriteRegStr HKCU "${APP_SETTINGS_KEY}" "InstallDir" "$INSTDIR"
  WriteRegStr HKCU "${APP_UNINSTALL_KEY}" "DisplayName" "${APP_NAME} ${APP_VERSION}"
  WriteRegStr HKCU "${APP_UNINSTALL_KEY}" "DisplayVersion" "${APP_VERSION}"
  WriteRegStr HKCU "${APP_UNINSTALL_KEY}" "Publisher" "BITMAX"
  WriteRegStr HKCU "${APP_UNINSTALL_KEY}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKCU "${APP_UNINSTALL_KEY}" "DisplayIcon" "$INSTDIR\${APP_EXE}"
  WriteRegStr HKCU "${APP_UNINSTALL_KEY}" "UninstallString" '"$INSTDIR\Uninstall.exe"'
  WriteRegDWORD HKCU "${APP_UNINSTALL_KEY}" "NoModify" 1
  WriteRegDWORD HKCU "${APP_UNINSTALL_KEY}" "NoRepair" 1
SectionEnd

Section /o "Criar atalho na Área de Trabalho" SEC_DESKTOP
  SetShellVarContext current
  CreateShortcut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}"
SectionEnd

Section "Uninstall"
  SetShellVarContext current
  Delete "$DESKTOP\${APP_NAME}.lnk"
  Delete "$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk"
  Delete "$SMPROGRAMS\${APP_NAME}\Requisitos do PVA-PGE.lnk"
  RMDir "$SMPROGRAMS\${APP_NAME}"

  Delete "$INSTDIR\${APP_EXE}"
  Delete "$INSTDIR\REQUISITOS-PVA-PGE.html"
  Delete "$INSTDIR\Uninstall.exe"
  RMDir "$INSTDIR"

  DeleteRegKey HKCU "${APP_UNINSTALL_KEY}"
  DeleteRegKey HKCU "${APP_SETTINGS_KEY}"
SectionEnd
