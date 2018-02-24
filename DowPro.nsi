;DoWpro installer script
;Using NSIS Modern User Interface

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  ;Name and file
  Name "DoWpro"
  OutFile "DoWproInstaller.exe"
  
  !define MUI_ICON ".\Resources\Soulstorm.ico"
  !define MUI_UNICON ".\Resources\Soulstorm.ico"
  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_RIGHT
  !define MUI_HEADERIMAGE_BITMAP ".\Resources\HeaderImage.bmp"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\Steam\steamapps\common\Dawn of War Soulstorm"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKLM "SOFTWARE\THQ\Dawn of War - Soulstorm" "installlocation"

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !define MUI_WELCOMEFINISHPAGE_BITMAP ".\Resources\WelcomeScreenImage.bmp"
  !define MUI_WELCOMEPAGE_TITLE "Welcome to the DoWpro <version> Full Installer Setup Wizard"
  !define MUI_WELCOMEPAGE_TEXT "This installer will install the DoWpro/SSpro mod for Dawn of War: Soulstorm.$\r$\n$\r$\nThanks to:$\r$\nMedes and Fires Over Kronus Closer to Codex team for some truly amazing models.$\r$\nListoric, Psy and Matrix for maps.$\r$\nDoW Dawn of Skirmish AI Mod Team and especially Sire Thudmeizer, LarkinVB and Arkhan the Black for the excellent AI.$\r$\nThe entire DoWpro team.$\r$\nThe DoW community for playing and supporting DoWpro!$\r$\n$\r$\ngl hf ^_^"
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_COMPONENTS
    !insertmacro MUI_PAGE_COMPONENTS
  
  !insertmacro MUI_PAGE_INSTFILES
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...
  
  ;Store installation folder
  WriteRegStr HKCU "Software\DowProInstaller" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecDummy ${LANG_ENGLISH} "A test section."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  Delete "$INSTDIR\Uninstall.exe"

  RMDir "$INSTDIR"

  DeleteRegKey /ifempty HKCU "Software\DowProInstaller"

SectionEnd