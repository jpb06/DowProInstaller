;DoWpro installer script
;Using NSIS Modern User Interface

;--------------------------------
;Include Modern UI

  !include "Sections.nsh"
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
  !define MUI_WELCOMEPAGE_TEXT "This installer will install the DoWpro mod for Dawn of War: Soulstorm.$\r$\n$\r$\nThanks to:$\r$\nMedes and Fires Over Kronus Closer to Codex team for some truly amazing models.$\r$\nListoric, Psy and Matrix for maps.$\r$\nDoW Dawn of Skirmish AI Mod Team and especially Sire Thudmeizer, LarkinVB and Arkhan the Black for the excellent AI.$\r$\nThe entire DoWpro team.$\r$\nThe DoW community for playing and supporting DoWpro!$\r$\n$\r$\ngl hf ^_^"
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_COMPONENTS
  
  !insertmacro MUI_PAGE_INSTFILES
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "!Main files" ;hidden
  SectionIn RO
  
  SetOutPath "$INSTDIR"
  
  RMDir /r "$INSTDIR\DoWpro"

  File /r ".\Content\MainFiles\*.*"
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\UninstallDoWpro.exe"

SectionEnd

Section "Vanilla Soulstorm Hotkeys" SectionHotkeysVanilla

 FindFirst $0 $1 "$INSTDIR\Profiles\*.*"
 loop:
	StrCmp $1 "" done
	StrCmp $1 "." skip
	StrCmp $1 ".." skip
	SetOutPath "$INSTDIR\Profiles\$1\DoWpro"
	File ".\Content\Hotkeys_Vanilla\KEYDEFAULTS.LUA"
	
	FindNext $0 $1
	Goto loop
 skip:
	FindNext $0 $1
    Goto loop
 done:
 FindClose $0
 
SectionEnd

Section /o "AZERTY Hotkeys" SectionHotkeysAzerty

 FindFirst $0 $1 "$INSTDIR\Profiles\*.*"
 loop:
	StrCmp $1 "" done
	StrCmp $1 "." skip
	StrCmp $1 ".." skip
	SetOutPath "$INSTDIR\Profiles\$1\DoWpro"
	File ".\Content\Hotkeys_AZERTY\KEYDEFAULTS.LUA"
	
	FindNext $0 $1
	Goto loop
 skip:
	FindNext $0 $1
    Goto loop
 done:
 FindClose $0

SectionEnd

Section /o "QWERTY Hotkeys" SectionHotkeysQwerty

 FindFirst $0 $1 "$INSTDIR\Profiles\*.*"
 loop:
	StrCmp $1 "" done
	StrCmp $1 "." skip
	StrCmp $1 ".." skip
	SetOutPath "$INSTDIR\Profiles\$1\DoWpro"
	File ".\Content\Hotkeys_QWERTY\KEYDEFAULTS.LUA"
	
	FindNext $0 $1
	Goto loop
 skip:
	FindNext $0 $1
    Goto loop
 done:
 FindClose $0

SectionEnd

Section /o "Left-Handed Hotkeys" SectionHotkeysLeftHanded

 FindFirst $0 $1 "$INSTDIR\Profiles\*.*"
 loop:
	StrCmp $1 "" done
	StrCmp $1 "." skip
	StrCmp $1 ".." skip
	SetOutPath "$INSTDIR\Profiles\$1\DoWpro"
	File ".\Content\Hotkeys_LeftHanded\KEYDEFAULTS.LUA"
	
	FindNext $0 $1
	Goto loop
 skip:
	FindNext $0 $1
    Goto loop
 done:
 FindClose $0

SectionEnd

Section /o "Stronghold Assaults Minimod" SectionStrongholdMiniMod

 SetOutPath "$INSTDIR"
 RMDir /r "$INSTDIR\DoWproSP"
 File /r ".\Content\StrongHoldMiniMod\*.*"

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SectionHotkeysVanilla ${LANG_ENGLISH} "Installs the Vanilla Soulstorm hotkeys adapted to the mod."
  LangString DESC_SectionHotkeysAzerty ${LANG_ENGLISH} "Installs the AZERTY hotkeys adapted to the mod."
  LangString DESC_SectionHotkeysQwerty ${LANG_ENGLISH} "Installs the QWERT hotkeys adapted to the mod."
  LangString DESC_SectionHotkeysLeftHanded ${LANG_ENGLISH} "Installs the left-handed hotkeys to the mod."
  LangString DESC_SectionStrongholdMiniMod ${LANG_ENGLISH} "Installs the Stronghold Assaults minimod in your main Soulstorm folder. NOTE: AFTER INSTALLING IT, GO TO THE GAME MANAGER AND ACTIVATE IT."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionHotkeysVanilla} $(DESC_SectionHotkeysVanilla)
	!insertmacro MUI_DESCRIPTION_TEXT ${SectionHotkeysAzerty} $(DESC_SectionHotkeysAzerty)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionHotkeysQwerty} $(DESC_SectionHotkeysQwerty)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionHotkeysLeftHanded} $(DESC_SectionHotkeysLeftHanded)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionStrongholdMiniMod} $(DESC_SectionStrongholdMiniMod)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END
  
;--------------------------------
; Functions

; $1 stores the status of the hotkeys group 
Function .onInit

  StrCpy $1 ${SectionHotkeysVanilla} ; Vanilla hotkeys are selected by default

FunctionEnd

Function .onSelChange

  !insertmacro StartRadioButtons $1
    !insertmacro RadioButton ${SectionHotkeysVanilla}
    !insertmacro RadioButton ${SectionHotkeysAzerty}
    !insertmacro RadioButton ${SectionHotkeysQwerty}
	!insertmacro RadioButton ${SectionHotkeysLeftHanded}
  !insertmacro EndRadioButtons

FunctionEnd
  
;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ; Cleaning profiles
  FindFirst $0 $1 "$INSTDIR\Profiles\*.*"
  loop:
	StrCmp $1 "" done
	StrCmp $1 "." skip
	StrCmp $1 ".." skip
	Delete "$INSTDIR\Profiles\$1\DoWpro\KEYDEFAULTS.LUA"
		
	FindNext $0 $1
	Goto loop
  skip:
	FindNext $0 $1
	Goto loop
  done:
  FindClose $0
  
  ; Cleaning files at Soulstorm root
  Delete "$INSTDIR\DoWpro.module"
  Delete "$INSTDIR\DowproSP.module"

  Delete "$INSTDIR\UninstallDoWpro.exe"
  RMDir /r "$INSTDIR\DoWpro"
  RMDir /r "$INSTDIR\DoWproSP"

SectionEnd
