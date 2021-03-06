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
  !define MUI_WELCOMEPAGE_TITLE $(DESC_WelcomePageTitle)
  !define MUI_WELCOMEPAGE_TITLE_3LINES
  !define MUI_WELCOMEPAGE_TEXT $(DESC_WelcomePageText)
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_COMPONENTS
  
  !insertmacro MUI_PAGE_INSTFILES
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  
;--------------------------------
;Languages
 
  !define MUI_LANGDLL_ALLLANGUAGES
  
  !insertmacro MUI_LANGUAGE "English"
  !insertmacro MUI_LANGUAGE "French"
  !insertmacro MUI_LANGUAGE "Russian"

;--------------------------------
;Installer Sections
Section "!$(DESC_SectionMainFilesTitle)" SectionMainFiles ;Always selected
  SectionIn RO
  
  SetOutPath "$INSTDIR"
  
  RMDir /r "$INSTDIR\DoWpro"

  File /r ".\Content\MainFiles\*.*"
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\UninstallDoWpro.exe"

SectionEnd

Section /o "$(DESC_SectionManualsTitle)" SectionManuals

  SetOutPath "$INSTDIR\DoWpro\Manuals"
  
  File /r ".\Content\Manuals\*.*"
  
  SetOutPath "$INSTDIR\DoWpro"
  
  File ".\Resources\dowpro_red.ico"
  
  CreateShortcut "$DESKTOP\DoWpro manuals.lnk" "$INSTDIR\DoWpro\Manuals\" "" "$INSTDIR\DoWpro\dowpro_red.ico"

SectionEnd

Section "$(DESC_SectionHotkeysVanillaTitle)" SectionHotkeysVanilla

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

Section /o "$(DESC_SectionHotkeysAzertyTitle)" SectionHotkeysAzerty

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

Section /o "$(DESC_SectionHotkeysQwertyTitle)" SectionHotkeysQwerty

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

Section /o "$(DESC_SectionHotkeysGermanTitle)" SectionHotkeysGerman

 FindFirst $0 $1 "$INSTDIR\Profiles\*.*"
 loop:
	StrCmp $1 "" done
	StrCmp $1 "." skip
	StrCmp $1 ".." skip
	SetOutPath "$INSTDIR\Profiles\$1\DoWpro"
	File ".\Content\Hotkeys_German\KEYDEFAULTS.LUA"
	
	FindNext $0 $1
	Goto loop
 skip:
	FindNext $0 $1
    Goto loop
 done:
 FindClose $0

SectionEnd

Section /o "$(DESC_SectionHotkeysLeftHandedTitle)" SectionHotkeysLeftHanded

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

;--------------------------------
; Languages files

!ifdef LANG_FRENCH
	!include ".\Languages\lang_fr.nsh"
!endif
!ifdef LANG_ENGLISH
	!include ".\Languages\lang_en.nsh"
!endif
!ifdef LANG_RUSSIAN
	!include ".\Languages\lang_ru.nsh"
!endif

;--------------------------------
;Descriptions

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionMainFiles} $(DESC_SectionMainFiles)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionHotkeysVanilla} $(DESC_SectionHotkeysVanilla)
	!insertmacro MUI_DESCRIPTION_TEXT ${SectionHotkeysAzerty} $(DESC_SectionHotkeysAzerty)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionHotkeysQwerty} $(DESC_SectionHotkeysQwerty)
	!insertmacro MUI_DESCRIPTION_TEXT ${SectionHotkeysGerman} $(DESC_SectionHotkeysGerman)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionHotkeysLeftHanded} $(DESC_SectionHotkeysLeftHanded)
	!insertmacro MUI_DESCRIPTION_TEXT ${SectionManuals} $(DESC_SectionManuals)
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
	!insertmacro RadioButton ${SectionHotkeysGerman}
	!insertmacro RadioButton ${SectionHotkeysLeftHanded}
  !insertmacro EndRadioButtons

FunctionEnd
  
;--------------------------------
;Uninstaller Section

Section Uninstall

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