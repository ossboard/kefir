@echo off
chcp 866 >nul 2>&1

COLOR 0F

set wd=%temp%\sdfiles
set clear=0
set cfw=ATMO
set cfwname=Atmosphere
set lang=0
set theme_flag=0
set theme=0
set caffeine=0
set dbi=0
set tesla=0
set tesla_flag=1
set modchip=1

:disclaimer
cls
ECHO ======================================================================
ECHO                            READ CAREFULLY!                            
ECHO ======================================================================
ECHO.
ECHO    �� ������������� �訡��, �롥�� ����� ��⠭���� � �����
ECHO    �᫨ �� ᮡ�ࠥ��� �ᯮ�짮���� Caffeine, �⬥��� �� � �����
ECHO    �᫨ �� ᮡ�ࠥ��� �ᯮ�짮���� sys-con, �⬥��� �� � �����
ECHO.
ECHO    ������ �, �⮡� ������� � ��樨 ����
ECHO    ������ F, ��⥬ Enter, �᫨ �� ������������ � ����ᠭ�� 
ECHO.
ECHO ----------------------------------------------------------------------
ECHO.   
ECHO    Choose clean install on options if any errors on launch CFW
ECHO    Choose Caffeine in an options if you use it
ECHO    Choose sys-con in an options if you use it
ECHO.
ECHO    Press F and Enter if you ready to proceed
ECHO    Press O for options.
ECHO.       
ECHO ======================================================================

set st=
set /p st=

for %%A in ("O" "o" "�" "�" "J" "j" "�" "�" "0") do if "%st%"==%%A (GOTO OPTIONS)
for %%A in ("F" "f" "�" "�") do if "%st%"==%%A (GOTO START)
for %%A in ("F" "f" "�" "�") do if "%st%" neq %%A (GOTO disclaimer)

cls

:START
goto newcard

:OPTIONS
COLOR 0E

cls
ECHO ------------------------------------------------------------------
ECHO               ======          Options          =====              
ECHO ------------------------------------------------------------------
ECHO ------------------------------------------------------------------
ECHO           ======         Select Language          =====           
ECHO           ======          �롥�� ��           =====
ECHO ------------------------------------------------------------------
ECHO.
ECHO         1.  ���᪨�
ECHO         2.  English
ECHO.
ECHO ==================================================================
ECHO                                                         Q.  Quit

set /p lang=:

cls
ECHO --------------------------------------------------------------------
ECHO               ======          Options          =====              
ECHO --------------------------------------------------------------------
if %lang%==1 (
	ECHO --------------------------------------------------------------------
	ECHO       ======     ����� ��⥬���� �� �� ���⠢��     =====
	ECHO --------------------------------------------------------------------
	ECHO.
	ECHO         1.  1.0.0
	ECHO         2.  ��㣠�
	ECHO.
	ECHO ====================================================================
	ECHO                                                          Q.  ��室
) else (
	ECHO --------------------------------------------------------------------
	ECHO                   =====  Select FW version =====                    
	ECHO --------------------------------------------------------------------
	ECHO.
	ECHO         1.  1.0.0
	ECHO         2.  Other
	ECHO.
	ECHO ====================================================================
	ECHO                                                          Q.  Quit
)
set st=
set /p st=:

for %%A in ("1") do if "%st%"==%%A (set tesla_flag=0)
for %%A in ("2") do if "%st%"==%%A (set tesla_flag=1)
for %%A in ("Q" "q" "�" "�") do if "%st%"==%%A (GOTO END)

:caffeine
cls
ECHO --------------------------------------------------------------------
ECHO               ======          Options          =====              
ECHO --------------------------------------------------------------------
if %lang%==1 (
	ECHO --------------------------------------------------------------------
	ECHO               ======     �롥�� �ᯫ���     =====                
	ECHO --------------------------------------------------------------------
	ECHO.
	ECHO         1.  Fusee-Gelee
	ECHO         2.  Caffeine
	ECHO         3.  ���������� ���᮫�
	ECHO.
	ECHO ====================================================================
	ECHO                                                          Q.  ��室
) else (
	ECHO --------------------------------------------------------------------
	ECHO                     =====  Choose explout =====                     
	ECHO --------------------------------------------------------------------
	ECHO.
	ECHO         1.  Fusee-Gelee
	ECHO         2.  Caffeine
	ECHO         3.  Modchip
	ECHO.
	ECHO ====================================================================
	ECHO                                                          Q.  Quit
)
set st=
set /p st=:

for %%A in ("1") do if "%st%"==%%A (
	set caffeine=0
	set modchip=0
	)
for %%A in ("2") do if "%st%"==%%A (
	set caffeine=1
	set modchip=0
	)
for %%A in ("Q" "q" "�" "�") do if "%st%"==%%A (GOTO END)

:opt
cls
ECHO --------------------------------------------------------------------
ECHO               ======          Options          =====              
ECHO --------------------------------------------------------------------
if %lang%==1 (
	ECHO --------------------------------------------------------------------
	ECHO                  ======     ��� ��⠭����     =====                 
	ECHO --------------------------------------------------------------------
	ECHO.
	ECHO         1.  ���筠�
	ECHO         2.  �����
	ECHO.
	ECHO --------------------------------------------------------------------
	ECHO  �ᯮ���� ����� ��⠭����, �᫨ �� ����᪥ ��⥬� �� ����砥�
	ECHO  �訡��. �� ��⮩ ��⠭���� �� 䠩�� � ����� �� ���� �����, 
	ECHO  �஬� ����� "Nintendo", ���� ��६�饭� �  ����� "backup"! �᫨ �
	ECHO  ����� "backup" ��� ��祣� �������, 㤠��� �� ������
	ECHO --------------------------------------------------------------------
	ECHO.
	ECHO ====================================================================
	ECHO                                                          Q.  ��室
) else (
	ECHO -------------------------------------------------
	ECHO          =====  Installation type =====          
	ECHO -------------------------------------------------
	ECHO.
	ECHO         1.  General
	ECHO         2.  Clean
	ECHO.
	ECHO ==================================================
	ECHO                                          Q.  Quit
)

set /p clear=:

:newcard
COLOR 0F
cls
if %lang%==1 (
	echo �롥�� ���� ����� ����� �� ᬮ��஢�����
) else (
	echo Choose mounted SD card letter
)

for /f "tokens=3-6 delims=: " %%a in ('WMIC LOGICALDISK GET FreeSpace^,Name^,Size^,filesystem^,description ^|FINDSTR /I "Removable" ^|findstr /i "exfat fat32"') do (@echo wsh.echo "Disk letter: %%c;" ^& " free: " ^& FormatNumber^(cdbl^(%%b^)/1024/1024/1024, 2^)^& " GB;"^& " size: " ^& FormatNumber^(cdbl^(%%d^)/1024/1024/1024, 2^)^& " GB;" ^& " FS: %%a" > %temp%\tmp.vbs & @if not "%%c"=="" @echo( & @cscript //nologo %temp%\tmp.vbs & del %temp%\tmp.vbs)
echo.
if %lang%==1 (
	set /P sd="������ �㪢� �� ���ன ᬮ��஢��� ���� �����: "
) else (
	set /P sd="Enter SD card letter: "
)

if not exist "%sd%:\" (
	if %lang%==1 (
		set word=    �� ����� %sd%:/ ���� ����� �� �������  
	) else (
		set word=        There is no SD card in %sd%-drive         
	)
	goto WRONGSD
) else (
	if not exist "%sd%:\*" (goto WRONGSD)
)
if exist "%sd%:\_backup" (goto chckbkp)
goto main

:chckbkp
cls
if %lang%==0 (
	ECHO --------------------------------------------------------------
	ECHO  Old backup folder was founded. Remove it? 
	ECHO  If you has any important files there, copy them right now!
	ECHO ---------------------------------------------------------------
	ECHO  ������� ���� ����� � �������, ᮧ������, ����⭮, �� 
	ECHO  ��⠭���� �����. ������������ �� 㤠����. �᫨ ⠬ ��⠫��� 
	ECHO  ����� 䠩��, ��७��� �� ��אַ ᥩ��!
	ECHO ---------------------------------------------------------------
	ECHO.
	ECHO         1.  Remove backup folder - recommended
	ECHO             ������� ����� backup - ४���������
	ECHO.
	ECHO         2.  Save backup folder
	ECHO             ��⠢��� ����� backup
	ECHO.
	ECHO ===============================================================
	ECHO                                                      Q.  Quit
) else (goto chckbkp1)
set st=
set /p st=:

for %%A in ("1") do if "%st%"==%%A (goto rembkp)
for %%A in ("2") do if "%st%"==%%A (goto main)
for %%A in ("Q" "q" "�" "�") do if "%st%"==%%A (GOTO END)
goto main

:chckbkp1
if %lang%==1 (
	ECHO --------------------------------------------------------------
	ECHO  ������� ���� ����� � �������, ᮧ������, ����⭮, �� 
	ECHO  ��⠭���� �����. ������������ �� 㤠����. �᫨ ⠬ ��⠫��� 
	ECHO  ����� 䠩��, ��७��� �� ��אַ ᥩ��!
	ECHO --------------------------------------------------------------
	ECHO.
	ECHO         1.  ������� ����� backup - ४���������
	ECHO         2.  ��⠢��� ����� backup
	ECHO.
	ECHO.
	ECHO ==============================================================
	ECHO                                             Q.  ��室
) else (
	ECHO --------------------------------------------------------------
	ECHO  Old backup folder was founded. Remove it? 
	ECHO  If you have any important files there, copy them right now!
	ECHO --------------------------------------------------------------
	ECHO.
	ECHO         1.  Remove backup folder - recommended
	ECHO         2.  Save backup folder
	ECHO.
	ECHO.
	ECHO ==============================================================
	ECHO                                             Q.  Quit
)

set st=
set /p st=:

for %%A in ("1") do if "%st%"==%%A (goto rembkp)
for %%A in ("2") do if "%st%"==%%A (goto main)
for %%A in ("Q" "q" "�" "�") do if "%st%"==%%A (GOTO END)
goto main

:main
COLOR 0F

if not exist "%sd%:\" (goto WRONGSD)

if %tesla_flag%==2 (
   if exist "%sd%:\atmosphere\contents\420000000007E51A" (set tesla=1) else (set tesla=0)
) else (
   set tesla=%tesla_flag%
)

cls
if %lang%==1 (
	echo ------------------------------------------------------------------------
	echo.
	echo                        �������� ���ॢ�� 䠩���                       
	echo.
	echo ------------------------------------------------------------------------
) else (
	echo ------------------------------------------------------------------------
	echo.
	echo                      Removing outdated files on sd                      
	echo.
	echo ------------------------------------------------------------------------
)

if exist "%sd%:\base" (RD /s /q  "%sd%:\base")
if exist "%sd%:\atmo" (RD /s /q  "%sd%:\atmo")
if exist "%sd%:\misc" (RD /s /q  "%sd%:\misc")
if exist "%sd%:\bootloader\ini\RajNX.ini" (del "%sd%:\bootloader\ini\RajNX.ini")
if exist "%sd%:\bootloader\ini\ReiNX.ini" (del "%sd%:\bootloader\ini\ReiNX.ini")
if exist "%sd%:\bootloader\payloads\rajnx_ipl.bin" (del "%sd%:\bootloader\payloads\rajnx_ipl.bin")
if exist "%sd%:\bootloader\payloads\ReiNX.bin" (del "%sd%:\bootloader\payloads\ReiNX.bin")
if exist "%sd%:\ReiNX\titles\010000000000100D" (RD /s /q "%sd%:\ReiNX\titles\010000000000100D")
if exist "%sd%:\rajnx_ipl.ini" (del "%sd%:\rajnx_ipl.ini")
if exist "%sd%:\bootlogo.bmp" (del "%sd%:\bootlogo.bmp")

if %clear%==2 (
	if not exist "%sd%:\_backup" (mkdir %sd%:\_backup\)
	FOR /d %%A IN (%sd%:\*) DO (
		rem IF "%%A" NEQ "%sd%:\Nintendo" IF "%%A" NEQ "%sd%:\_backup" (move /Y %%A %sd%:\_backup)
		IF "%%A" NEQ "%sd%:\Nintendo" IF "%%A" NEQ "%sd%:\_backup" IF "%%A" NEQ "%sd%:\sxos\emunand" IF "%%A" NEQ "%sd%:\emuMMC" IF "%%A" NEQ "%sd%:\emummc" (
			echo %%A
			move /Y %%A %sd%:\_backup
			)

	)
	FOR %%A IN (%sd%:\*) DO (
		rem IF "%%A" NEQ "%sd%:\Nintendo" IF "%%A" NEQ "%sd%:\_backup" (move /Y %%A %sd%:\_backup)
		IF "%%A" NEQ "%sd%:\_backup" (
			echo %%A
			move /Y %%A %sd%:\_backup
			)
	)

	 if exist "%sd%:\_backup\sxos\emunand" (mkdir %sd%:\sxos\emunand)
	 if exist "%sd%:\_backup\sxos\emunand" (move /Y  %sd%:\_backup\sxos\emunand\* %sd%:\sxos\emunand)
	
	move /Y %sd%:\*.* %sd%:\_backup"
	
)

echo                                   DONE                                  
echo ------------------------------------------------------------------------
echo.

if %lang%==1 (
	echo ------------------------------------------------------------------------
	echo.
	echo                       �������� 䠩��� ��ண� ����                      
	echo.
	echo ------------------------------------------------------------------------
	echo.
) else (
	echo ------------------------------------------------------------------------
	echo.
	echo                          Remove old pack files                          
	echo.
	echo ------------------------------------------------------------------------
	echo.
)

if exist "%sd%:\atmosphere\exefs_patches" (RD /s /q "%sd%:\atmosphere\exefs_patches")
if exist "%sd%:\atmosphere\kip_patches" (RD /s /q "%sd%:\atmosphere\kip_patches")
if exist "%sd%:\atmosphere\hekate_kips" (RD /s /q "%sd%:\atmosphere\hekate_kips")
if exist "%sd%:\bootloader\debug" (RD /s /q "%sd%:\bootloader\debug")
if exist "%sd%:\modules" (RD /s /q "%sd%:\modules")

if exist "%sd%:\atmosphere\titles" (rename %sd%:\atmosphere\titles contents)
if exist "%sd%:\atmosphere\title" (rename %sd%:\atmosphere\title contents)
if exist "%sd%:\atmosphere\content" (rename %sd%:\atmosphere\content contents)

if exist "%sd%:\atmosphere\contents\0100000000000032" (RD /s /q "%sd%:\atmosphere\contents\0100000000000032")
if exist "%sd%:\atmosphere\contents\0100000000000034" (RD /s /q "%sd%:\atmosphere\contents\0100000000000034")
if exist "%sd%:\atmosphere\contents\0100000000000037" (RD /s /q "%sd%:\atmosphere\contents\0100000000000037")
if exist "%sd%:\atmosphere\contents\0100000000000036" (RD /s /q "%sd%:\atmosphere\contents\0100000000000036")
if exist "%sd%:\atmosphere\contents\010000000000002b" (RD /s /q "%sd%:\atmosphere\contents\010000000000002b")
if exist "%sd%:\atmosphere\contents\010000000000000D" (RD /s /q "%sd%:\atmosphere\contents\010000000000000D")
if exist "%sd%:\atmosphere\contents\010000000000100D" (RD /s /q "%sd%:\atmosphere\contents\010000000000100D")
if exist "%sd%:\atmosphere\contents\4200000000000010" (RD /s /q "%sd%:\atmosphere\contents\4200000000000010")
if exist "%sd%:\atmosphere\contents\0100000000000008" (RD /s /q "%sd%:\atmosphere\contents\0100000000000008")
if exist "%sd%:\atmosphere\contents\690000000000000D" (RD /s /q "%sd%:\atmosphere\contents\690000000000000D")
if exist "%sd%:\atmosphere\contents\420000000000000E" (RD /s /q "%sd%:\atmosphere\contents\420000000000000E")
if exist "%sd%:\atmosphere\contents\010000000000100B" (RD /s /q "%sd%:\atmosphere\contents\010000000000100B")
if exist "%sd%:\atmosphere\contents\01FF415446660000" (RD /s /q "%sd%:\atmosphere\contents\01FF415446660000")
if exist "%sd%:\atmosphere\contents\0100000000000352" (RD /s /q "%sd%:\atmosphere\contents\0100000000000352")
if exist "%sd%:\atmosphere\contents\00FF747765616BFF" (RD /s /q "%sd%:\atmosphere\contents\00FF747765616BFF")
if exist "%sd%:\atmosphere\contents\00FF0012656180FF" (RD /s /q "%sd%:\atmosphere\contents\00FF0012656180FF")
if exist "%sd%:\atmosphere\contents\0100000000001013" (RD /s /q "%sd%:\atmosphere\contents\0100000000001013")
if exist "%sd%:\atmosphere\contents\010000000007E51A" (RD /s /q "%sd%:\atmosphere\contents\010000000007E51A")
if exist "%sd%:\atmosphere\contents\420000000007E51A" (RD /s /q "%sd%:\atmosphere\contents\420000000007E51A")
if exist "%sd%:\atmosphere\contents\0100000000001000" (RD /s /q "%sd%:\atmosphere\contents\0100000000001000")
if exist "%sd%:\atmosphere\contents\010000000000100C" (RD /s /q "%sd%:\atmosphere\contents\010000000000100C")
if exist "%sd%:\atmosphere\contents\0000000000534C56" (RD /s /q "%sd%:\atmosphere\contents\0000000000534C56")
if exist "%sd%:\atmosphere\contents\010000000000bd00" (RD /s /q "%sd%:\atmosphere\contents\010000000000bd00")
if exist "%sd%:\atmosphere\stratosphere.romfs" (del "%sd%:\atmosphere\stratosphere.romfs")

if exist "%sd%:\atmosphere\fusee-secondary_atmo.bin" (del "%sd%:\atmosphere\fusee-secondary_atmo.bin")
if exist "%sd%:\atmosphere\hbl_atmo.nsp" (del "%sd%:\atmosphere\hbl_atmo.nsp")
if exist "%sd%:\atmosphere\fusee-secondary.bin.sig" (del "%sd%:\atmosphere\fusee-secondary.bin.sig")
if exist "%sd%:\atmosphere\hbl.nsp.sig" (del "%sd%:\atmosphere\hbl.nsp.sig")
if exist "%sd%:\atmosphere\hbl.json" (del "%sd%:\atmosphere\hbl.json")
if exist "%sd%:\atmosphere\BCT.ini" (del "%sd%:\atmosphere\BCT.ini")
if exist "%sd%:\atmosphere\system_settings.ini" (del "%sd%:\atmosphere\system_settings.ini")
if exist "%sd%:\atmosphere\loader.ini" (del "%sd%:\atmosphere\system_settings.ini")
if exist "%sd%:\atmosphere\kips" (RD /s /q  "%sd%:\atmosphere\kips")
if exist "%sd%:\atmosphere\erpt_reports" (RD /s /q  "%sd%:\atmosphere\erpt_reports")
if exist "%sd%:\atmosphere\flags\hbl_cal_read.flag" (del "%sd%:\atmosphere\flags\hbl_cal_read.flag")
if exist "%sd%:\atmosphere\exosphere.bin" (del "%sd%:\atmosphere\exosphere.bin")
if exist "%sd%:\atmosphere\hbl.nsp" (del "%sd%:\atmosphere\hbl.nsp")
if exist "%sd%:\atmosphere\loader.ini" (del "%sd%:\atmosphere\loader.ini")
if exist "%sd%:\atmosphere\reboot_payload.bin" (del "%sd%:\atmosphere\reboot_payload.bin")
if exist "%sd%:\atmosphere\BCT.ini" (del "%sd%:\atmosphere\BCT.ini")
if exist "%sd%:\sxos\bootloader" (RD /s /q  "%sd%:\sxos\bootloader")
if exist "%sd%:\sxos\switch" (RD /s /q  "%sd%:\sxos\switch")
if exist "%sd%:\sxos\exefs_patches" (RD /s /q  "%sd%:\sxos\exefs_patches")
if exist "%sd%:\sept" (RD /s /q  "%sd%:\sept")
if exist "%sd%:\sxos\boot.dat" (del "%sd%:\sxos\boot.dat")
if exist "%sd%:\games\tinfoil*.*" (del "%sd%:\games\tinfoil*.*")
if exist "%sd%:\sxos\sxos" (
	xcopy %sd%:\sxos\sxos\* %sd%:\sxos\ /Y /S /E /H /R /D
)
if exist "%sd%:\atmosphere\fusee-secondary.bin" (del "%sd%:\atmosphere\fusee-secondary.bin")
if exist "%sd%:\bootloader\payloads\fusee-primary-payload.bin" (del "%sd%:\bootloader\payloads\fusee-primary-payload.bin")
if exist "%sd%:\bootloader\payloads\Lockpick_RCM.bin" (del "%sd%:\bootloader\payloads\Lockpick_RCM.bin")
if exist "%sd%:\bootloader\payloads\biskeydump.bin" (del "%sd%:\bootloader\payloads\biskeydump.bin")
if exist "%sd%:\bootloader\payloads\fusee-payload.bin" (del "%sd%:\bootloader\payloads\fusee-payload.bin")
if exist "%sd%:\bootloader\payloads\fusee-primary.bin" (del "%sd%:\bootloader\payloads\fusee-primary.bin")
if exist "%sd%:\bootloader\payloads\sxos.bin" (del "%sd%:\bootloader\payloads\sxos.bin")
if exist "%sd%:\bootloader\payloads\rajnx_ipl.bin" (del "%sd%:\bootloader\payloads\rajnx_ipl.bin")
if exist "%sd%:\fusee-secondary.bin" (del "%sd%:\fusee-secondary.bin")
if exist "%sd%:\atmosphere\fusee-secondary.bin" (del "%sd%:\atmosphere\fusee-secondary.bin")
if exist "%sd%:\bootloader\ini\Atmosphere.ini" (del "%sd%:\bootloader\ini\Atmosphere.ini")
if exist "%sd%:\bootloader\ini\atmosphere.ini" (del "%sd%:\bootloader\ini\atmosphere.ini")
if exist "%sd%:\bootloader\ini\sxos.ini" (del "%sd%:\bootloader\ini\sxos.ini")
if exist "%sd%:\bootloader\ini\hekate_keys.ini" (del "%sd%:\bootloader\ini\hekate_keys.ini")
if exist "%sd%:\bootloader\ini\RajNX.ini" (del "%sd%:\bootloader\ini\RajNX.ini")

if exist "%sd%:\license-request.dat" (del "%sd%:\license-request.dat")
if exist "%sd%:\boot.dat" (del "%sd%:\boot.dat")
if exist "%sd%:\hekate*.bin" (del "%sd%:\hekate*.bin")
if exist "%sd%:\hbmenu.nro" (del "%sd%:\hbmenu.nro")
if exist "%sd%:\keys.dat" (del "%sd%:\keys.dat")
if exist "%sd%:\BCT.ini" (del "%sd%:\BCT.ini")
if exist "%sd%:\startup.te" (del "%sd%:\startup.te")
if exist "%sd%:\hekate_ipl.ini" (del "%sd%:\hekate_ipl.ini")

if exist "%sd%:\bootloader\hekate_ipl.ini" (del "%sd%:\bootloader\hekate_ipl.ini")
if exist "%sd%:\bootloader\update.bin" (del "%sd%:\bootloader\update.bin")
if exist "%sd%:\bootloader\update.bin.sig" (del "%sd%:\bootloader\update.bin.sig")
if exist "%sd%:\bootloader\patches_template.ini" (del "%sd%:\bootloader\patches_template.ini")
if exist "%sd%:\bootloader\patches.ini" (del "%sd%:\bootloader\patches.ini")
if exist "%sd%:\bootloader\bootlogo.bmp" (del "%sd%:\bootloader\bootlogo.bmp")
if exist "%sd%:\bootloader\res\icon_payload.bmp" (del "%sd%:\bootloader\res\icon_payload.bmp")
if exist "%sd%:\bootloader\res\icon_switch.bmp" (del "%sd%:\bootloader\res\icon_switch.bmp")
if exist "%sd%:\bootloader\payloads\rajnx_ipl.bin" (del "%sd%:\bootloader\payloads\rajnx_ipl.bin")

if exist "%sd%:\sxos\titles\00FF0012656180FF" (RD /s /q "%sd%:\sxos\titles\00FF0012656180FF")

if exist "%sd%:\switch\lithium" (RD /s /q "%sd%:\switch\lithium")
if exist "%sd%:\switch\tinfoil" (RD /s /q "%sd%:\switch\tinfoil")
if exist "%sd%:\switch\KosmosToolbox" (RD /s /q "%sd%:\switch\KosmosToolbox")
if exist "%sd%:\switch\KosmosUpdater" (RD /s /q "%sd%:\switch\KosmosUpdater")
if exist "%sd%:\switch\mercury" (RD /s /q "%sd%:\switch\mercury")
rem if exist "%sd%:\switch\EdiZon.nro" (del "%sd%:\switch\EdiZon.nro")
if exist "%sd%:\switch\tinfoil\tinfoil.nro" (del "%sd%:\switch\tinfoil\tinfoil.nro")
if exist "%sd%:\switch\tinfoil\keys.txt" (del "%sd%:\switch\tinfoil\keys.txt")
if exist "%sd%:\switch\checkpoint.nro" (del "%sd%:\switch\checkpoint.nro")
if exist "%sd%:\switch\checkpoint\checkpoint.nro" (del "%sd%:\switch\checkpoint\checkpoint.nro")
if exist "%sd%:\switch\pplay.nro" (del "%sd%:\switch\pplay.nro")
if exist "%sd%:\switch\NX-SHELL.nro" (del "%sd%:\switch\NX-SHELL.nro")
if exist "%sd%:\switch\reboot_to_payload.nro" (del "%sd%:\switch\reboot_to_payload.nro")
if exist "%sd%:\switch\NxThemesInstaller.nro" (del "%sd%:\switch\NxThemesInstaller.nro")
if exist "%sd%:\switch\NxThemesInstaller\NxThemesInstaller.nro" (del "%sd%:\switch\NxThemesInstaller\NxThemesInstaller.nro")
if exist "%sd%:\switch\sx.nro" (del "%sd%:\switch\sx.nro")
if exist "%sd%:\switch\n1dus.nro" (del "%sd%:\switch\n1dus.nro")
if exist "%sd%:\switch\ChoiDujourNX.nro" (del "%sd%:\switch\ChoiDujourNX.nro")
if exist "%sd%:\switch\ChoiDujourNX\ChoiDujourNX.nro" (del "%sd%:\switch\ChoiDujourNX\ChoiDujourNX.nro")
if exist "%sd%:\switch\kefirupdater\kefirupdater.nro" (del "%sd%:\switch\kefirupdater\kefirupdater.nro")
if exist "%sd%:\switch\kefirupdater\kefir-updater.nro" (del "%sd%:\switch\kefirupdater\kefir-updater.nro")
if exist "%sd%:\switch\kefirupdater.nro" (del "%sd%:\switch\kefirupdater\kefirupdater.nro")
if exist "%sd%:\switch\kefir-updater.nro" (del "%sd%:\switch\kefirupdater\kefir-updater.nro")
if exist "%sd%:\switch\daybreak.nro" (del "%sd%:\switch\daybreak.nro")
if exist "%sd%:\switch\daybreak\daybreak.nro" (del "%sd%:\switch\daybreak\daybreak.nro")
if exist "%sd%:\switch\kefirupdater\cheats.zip" (del "%sd%:\switch\kefirupdater\cheats.zip")
if exist "%sd%:\switch\kefirupdater\kefir.zip" (del "%sd%:\switch\kefirupdater\kefir.zip")
if exist "%sd%:\switch\kefirupdater\firmware.zip" (del "%sd%:\switch\kefirupdater\firmware.zip")

if exist "%sd%:\switch\LinkUser" (RD /s /q "%sd%:\switch\LinkUser\")
if exist "%sd%:\switch\dbi.nro" (del "%sd%:\switch\dbi.nro")
if exist "%sd%:\switch\.DBI.nro.star" (del "%sd%:\switch\.DBI.nro.star")
if exist "%sd%:\switch\dbi\dbi.nro" (del "%sd%:\switch\dbi\dbi.nro")
rem if exist "%sd%:\switch\dbi\dbi.config" (copy "%sd%:\switch\dbi\dbi.config" "%sd%:\switch\dbi\dbi.config.bak")
if exist "%sd%:\switch\dbi\dbi.config" (del "%sd%:\switch\dbi\dbi.config")
if exist "%sd%:\switch\nxmtp.nro" (del "%sd%:\switch\nxmtp.nro")
if exist "%sd%:\switch\nxmtp" (RD /s /q "%sd%:\switch\nxmtp\")
if exist "%sd%:\switch\NX-Activity-Log.nro" (del "%sd%:\switch\NX-Activity-Log.nro")
if exist "%sd%:\switch\switch-cheats-updater" (RD /s /q "%sd%:\switch\switch-cheats-updater\")
if exist "%sd%:\switch\FreshHay" (RD /s /q "%sd%:\switch\FreshHay\")
if exist "%sd%:\switch\nx-ntpc" (RD /s /q "%sd%:\switch\nx-ntpc\")
if exist "%sd%:\switch\sx\locations.conf" (del "%sd%:\switch\sx\locations.conf")
if exist "%sd%:\switch\sx\sx.nro" (del "%sd%:\switch\sx\sx.nro")
if exist "%sd%:\switch\sx.nro" (del "%sd%:\switch\sx.nro")
if exist "%sd%:\switch\incognito.nro" (del "%sd%:\switch\incognito.nro")
if exist "%sd%:\switch\incognito" (RD /s /q "%sd%:\switch\incognito")
if exist "%sd%:\switch\ultimate_updater.nro" (del "%sd%:\switch\ultimate_updater.nro")
if exist "%sd%:\switch\zerotwoxci.nro" (del "%sd%:\switch\zerotwoxci.nro")
if exist "%sd%:\switch\dOPUS.nro" (del "%sd%:\switch\dOPUS.nro")
if exist "%sd%:\switch\tinfoil.nro" (del "%sd%:\switch\tinfoil.nro")
if exist "%sd%:\switch\tinfoil_batch.nro" (del "%sd%:\switch\tinfoil_batch.nro")
if exist "%sd%:\switch\tinfoil_duckbill.nro" (del "%sd%:\switch\tinfoil_duckbill.nro")
if exist "%sd%:\switch\tinfoil_usb-fix.nro" (del "%sd%:\switch\tinfoil_usb-fix.nro")
if exist "%sd%:\switch\ldnmitm_config.nro" (del "%sd%:\switch\ldnmitm_config.nro")
if exist "%sd%:\switch\ldnmitm_config" (RD /s /q "%sd%:\switch\ldnmitm_config")
if exist "%sd%:\pegascape" (RD /s /q "%sd%:\pegascape")
if exist "%sd%:\switch\fakenews-injector.nro" (del "%sd%:\switch\fakenews-injector.nro")
if exist "%sd%:\switch\gag-order.nro" (del "%sd%:\switch\gag-order.nro")
if exist "%sd%:\games\hbgShop*.nsp" (del "%sd%:\games\hbgShop_forwarder_classic.nsp")
if exist "%sd%:\games\Tinfoil*.nsp" (del "%sd%:\games\hbgShop_forwarder_dark_v3.nsp")
if exist "%sd%:\switch\fakenews-injector" (RD /s /q "%sd%:\switch\fakenews-injector")
if exist "%sd%:\sxos\sx" (RD /s /q "%sd%:\sxos\sx")
if exist "%sd%:\switch\tinfoil" (RD /s /q "%sd%:\switch\tinfoil")
if exist "%sd%:\switch\.overlays\emuiibo.ovl" (del "%sd%:\switch\.overlays\emuiibo.ovl")

if exist "%sd%:\exosphere.ini" (del "%sd%:\exosphere.ini")

:install_pack

if %lang%==1 (
	echo.
	echo                   ����஢���� ���� �� �६����� �����                   
	echo.
	echo ------------------------------------------------------------------------
) else (
	echo ------------------------------------------------------------------------
	echo.
	echo                    Copy pack files to temp directory                    
	echo.
	echo ------------------------------------------------------------------------
)

if exist "%temp%\sdfiles\" (RD /s /q "%temp%\sdfiles\")
if not exist "%temp%\sdfiles\" (mkdir %temp%\sdfiles\)
xcopy "%~dp0*" "%temp%\sdfiles\" /H /Y /C /R /S /E >nul 2>&1

echo                                   DONE                                  
echo ------------------------------------------------------------------------
echo.
if %lang%==1 (
	echo ------------------------------------------------------------------------
	echo.
	echo                      ��⠭���� ���� �� ����� �����                     
	echo.
	echo ------------------------------------------------------------------------
) else (
	echo ------------------------------------------------------------------------
	echo.
	echo                          Installing pack files                          
	echo.
	echo ------------------------------------------------------------------------
)

if exist "%sd%:\sdfiles.zip" (del "%sd%:\sdfiles.zip")

if exist "%sd%:\tinfoil\ticket" (RD /s /q "%sd%:\tinfoil\ticket")
if exist "%sd%:\tinfoil\extracted" (RD /s /q "%sd%:\tinfoil\extracted")
if exist "%sd%:\tinfoil" (
	move /Y %sd%:\tinfoil\nsp\* %sd%:\games
	move /Y %sd%:\tinfoil\xci %sd%:\games
	RD /s /q "%sd%:\tinfoil"
)

if exist "%sd%:\sxos\emunand" (
	if not exist "%sd%:\sxos_" (mkdir %sd%:\sxos_\emunand)
	move /Y %sd%:\sxos\emunand\* %sd%:\sxos_\emunand
	if exist "%sd%:\sxos" (RD /s /q "%sd%:\sxos")
	if not exist "%sd%:\sxos\" (mkdir %sd%:\sxos\emunand)
	if exist "%sd%:\sxos_\emunand" (move /Y %sd%:\sxos_\emunand\* %sd%:\sxos\emunand)
	if exist "%sd%:\sxos_" (RD /s /q "%sd%:\sxos_")
) else (if exist "%sd%:\sxos" (RD /s /q "%sd%:\sxos"))

echo                                   DONE                                  
echo ------------------------------------------------------------------------
echo.
if %lang%==1 (
	echo ------------------------------------------------------------------------
	echo.
	echo                             ��⠭���� Kefir                             
	echo.
	echo ------------------------------------------------------------------------
	echo.
) else (
	echo ------------------------------------------------------------------------
	echo.
	echo                            Installing Kefir                             
	echo.
	echo ------------------------------------------------------------------------
	echo.
)

if exist "E:\Switch\addons\themes" (xcopy "E:\Switch\addons\themes\*" "%sd%:\themes" /H /Y /C /R /S /E /I)
if exist "E:\Switch\TinGen-main\index.tfl" (xcopy "E:\Switch\TinGen-main\index.tfl" "%sd%:\" /H /Y /C /R /S /E /I)

goto cfw_%cfw%

rem ------------------------------------------------------------------------
rem .
rem                                    ATMO
rem .
rem  ------------------------------------------------------------------------


:cfw_ATMO

xcopy "%wd%\*" "%sd%:\" /H /Y /C /R /S /E
xcopy "%wd%\payload.bin" "%sd%:\" /H /Y /C /R

xcopy "%wd%\*" "%sd%:\" /H /Y /C /R /S /E

if exist "%sd%:\sept\payload_*.bin" (del "%sd%:\sept\payload_*.bin")

if exist "%sd%:\bootloader\payloads\sxos.bin" (del "%sd%:\bootloader\payloads\sxos.bin")
if exist "%sd%:\bootloader\hekate_ipl_mariko.ini" (del "%sd%:\bootloader\hekate_ipl_mariko.ini")

if exist "%sd%:\bootloader\payloads\rajnx_ipl.bin" (del "%sd%:\bootloader\payloads\rajnx_ipl.bin")
if exist "%sd%:\switch\sx.nro" (del "%sd%:\switch\sx.nro")
if exist "%sd%:\bootloader\ini\sxos.ini" (del "%sd%:\bootloader\ini\sxos.ini")
if exist "%sd%:\sxos\titles" (move /Y %sd%:\sxos\titles\* %sd%:\atmosphere\contents\)
if exist "%sd%:\sxos\games" (move /Y %sd%:\sxos\games\* %sd%:\games)
if exist "%sd%:\atmosphere\contents\00FF0012656180FF" (RD /s /q "%sd%:\atmosphere\contents\00FF0012656180FF")

if exist "%sd%:\switch\ChoiDujourNX" (RD /s /q "%sd%:\switch\ChoiDujourNX")

if exist "%sd%:\switch\sx" (RD /s /q "%sd%:\switch\sx")
if exist "%sd%:\switch\themes" (RD /s /q "%sd%:\switch\themes")
if exist "%sd%:\switch\Lockpick" (RD /s /q "%sd%:\switch\Lockpick")
if exist "%sd%:\switch\Incognito" (RD /s /q "%sd%:\switch\Incognito")
if exist "%sd%:\titles" (move /Y "%wd%\titles\*" "%sd%:\atmosphere\contents")
if exist "%sd%:\titles" (RD /s /q "%sd%:\titles")

if %modchip%==0 (del "%sd%:\boot.dat")
if %modchip%==0 (del "%sd%:\boot.ini")

goto caffeine

rem ------------------------------------------------------------------------
rem .
rem                                    Caffeine
rem .
rem  ------------------------------------------------------------------------

:caffeine
if %caffeine%==1 (goto cfw_DONE)

if exist "%sd%:\switch\fakenews-injector" (RD /s /q "%sd%:\switch\fakenews-injector")
if exist "%sd%:\pegascape" (RD /s /q "%sd%:\pegascape")

:cfw_DONE

if %tesla%==0 (
	if exist "%sd%:\atmosphere\contents\420000000007E51A" (RD /s /q "%sd%:\atmosphere\contents\420000000007E51A")
	if exist "%sd%:\atmosphere\contents\690000000000000D" (RD /s /q "%sd%:\atmosphere\contents\420000000007E51A")
	if exist "%sd%:\atmosphere\contents\0100000000000352" (RD /s /q "%sd%:\atmosphere\contents\420000000007E51A")
	if exist "%sd%:\switch\.overlays" (RD /s /q "%sd%:\atmosphere\contents\420000000007E51A")
	)

if exist "%sd%:\bootloader\hekate_ipl_*.ini" (del "%sd%:\bootloader\hekate_ipl_*.ini")
if exist "%sd%:\sept\payload_*.bin" (del "%sd%:\sept\payload_*.bin")

echo                                   DONE                                  
echo ------------------------------------------------------------------------
echo.

if %lang%==1 (
	echo ------------------------------------------------------------------------
	echo.
	echo                    ��⠭���� ��ਡ�⮢ 䠩��� � �����                   
	echo.
	echo ------------------------------------------------------------------------
	echo.
) else (
	echo ------------------------------------------------------------------------
	echo.
	echo                              Fix atributes                              
	echo.
	echo ------------------------------------------------------------------------
	echo.
)

if exist "%sd%:\atmosphere" (
	attrib -A /S /D %sd%:\atmosphere\*
	attrib -A %sd%:\atmosphere)
if exist "%sd%:\atmosphere\contents" (
	attrib -A /S /D %sd%:\atmosphere\contents*
	attrib -A %sd%:\atmosphere\contents)
if exist "%sd%:\sept" (
	attrib -A /S /D %sd%:\sept\*
	attrib -A %sd%:\sept)
if exist "%sd%:\bootloader" (
	attrib -A /S /D %sd%:\bootloader\*
	attrib -A %sd%:\bootloader)
if exist "%sd%:\config" (
	attrib -A /S /D %sd%:\config\*
	attrib -A %sd%:\config)
if exist "%sd%:\switch" (
	attrib -A /S /D %sd%:\switch\*
	attrib -A %sd%:\switch)
if exist "%sd%:\tinfoil" (
	attrib -A /S /D %sd%:\tinfoil\*
	attrib -A %sd%:\tinfoil)
if exist "%sd%:\games" (
	attrib -A /S /D %sd%:\games\*
	attrib -A %sd%:\games)
if exist "%sd%:\themes" (
	attrib -A /S /D %sd%:\themes\*
	attrib -A %sd%:\themes)
if exist "%sd%:\_backup" (
	attrib -A /S /D %sd%:\_backup\*
	attrib -A %sd%:\_backup)
if exist "%sd%:\hbmenu.nro" (attrib -A %sd%:\hbmenu.nro)
if exist "%sd%:\keys.dat" (attrib -A %sd%:\keys.dat)
if exist "%sd%:\boot.dat" (attrib -A %sd%:\boot.dat)
if exist "%sd%:\payload.bin" (attrib -A %sd%:\payload.bin)
if exist "%sd%:\sxos" (
	attrib -A /S /D %sd%:\sxos\*
	attrib -A %sd%:\sxos)
if exist "%sd%:\sxos" (
	attrib -A /S /D %sd%:\pegascape\*
	attrib -A %sd%:\pegascape)
if exist "%sd%:\switch\fakenews-injector" (
	attrib -A /S /D %sd%:\switch\fakenews-injector\*
	attrib -A %sd%:\switch\fakenews-injector)

cd %sd:\%

if exist .DS_STORE del /s /q /f /a .DS_STORE
if exist ._.* del /s /q /f /a ._.*

reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\usbstor\11ECA7E0 /v MaximumTransferLength /t REG_DWORD /d 00100000 /f
if exist "%sd%:\TinGen" (RD /s /q "%sd%:\TinGen")

rem if exist "%sd%:\switch\dbi\dbi.config.bak" (
rem 	del "%sd%:\switch\dbi\dbi.config"
rem 	copy "%sd%:\switch\dbi\dbi.config.bak" "%sd%:\switch\dbi\dbi.config"
rem 	del "%sd%:\switch\dbi\dbi.config.bak"
rem 	)

if exist "%sd%:\install.bat" (del "%sd%:\install.bat")

echo                                   DONE                                  
echo ------------------------------------------------------------------------
echo.

cls
COLOR 0A
echo.
if %lang%==1 (
	echo ========================================================================
	echo.
	echo             ��� ��⮢�! ��⠢�� ����� ����� � ���⠢��!              
	echo.
	echo ========================================================================
	echo ========================================================================
	echo.
	echo              �᫨ �� ����᪥ ���⠢�� �� ����� �訡��,               
	echo       �த����� ��⠭���� ���� �� ࠧ, ��ࠢ ����� ��⠭����!       
	echo.
	echo ========================================================================
	echo ========================================================================
	echo.
) else (
	echo ========================================================================
	echo.
	echo                  DONE! Insert you SD into the console!                  
	echo.
	echo ========================================================================
	echo ========================================================================
	echo.
	echo               If you got an error after lauching console,               
	echo          install pack one more time but choose clean install!           
	echo.
	echo ========================================================================
	echo ========================================================================
	echo.
)

goto end

:WRONGSD
cls
COLOR C


	ECHO ----------------------------------------------------------
	ECHO ======            Choosed SD letter is: %sd%:/            =====
	ECHO ======               ��࠭�� ���: %sd%:/               =====
	ECHO.
	ECHO ======     �� ����� %sd%:/ ���� ����� �� �������     =====
	ECHO ======       There is no SD card in drive %sd%:/        =====
	ECHO ----------------------------------------------------------
	ECHO.
	ECHO          ��������, �� 㪠���� �ࠢ����� �㪢� ��᪠
	ECHO. 
	ECHO            1.  The card letter is correct
	ECHO                �㪢� ��᪠ 㪠���� ��୮
	ECHO.
	ECHO            2.  Choose another card letter
	ECHO                ����� ����� �㪢� ��᪠
	ECHO.
	ECHO ==========================================================
	ECHO                                              Q.  ��室
	ECHO.

set st=
set /p st=:

for %%A in ("Y" "y" "1" "�" "�") do if "%st%"==%%A (GOTO main)
for %%A in ("N" "n" "2" "�" "�") do if "%st%"==%%A (GOTO newcard)
for %%A in ("Q" "q" "�" "�") do if "%st%"==%%A (GOTO END)

:rembkp
if %lang%==1 (
	echo ------------------------------------------------------------------------
	echo.
	echo                         �������� ����� _backup                          
	echo                                �������!                                
	echo.
	echo ------------------------------------------------------------------------
) else (
	echo ------------------------------------------------------------------------
	echo.
	echo                         Removing _backup folder                         
	echo                              Please wait!                               
	echo.
	echo ------------------------------------------------------------------------
)

RD /s /q "%sd%:\_backup"
goto main

:END
if %lang%==1 (
	echo. 
	echo ������ ���� ������� ��� ��室�
) else (
	echo. 
	echo Press any button for exit
)

RD /s /q "%wd%
pause>nul 2>&1
exit

	echo                          �������� ����� _backup                         
	echo                                �������!                                
	echo.
	echo ------------------------------------------------------------------------
) else (
	echo ------------------------------------------------------------------------
	echo.
	echo                         Removing _backup folder                         
	echo                              Please wait!                               
	echo.
	echo ------------------------------------------------------------------------
)

RD /s /q "%sd%:\_backup"
goto main

:END
if %lang%==1 (
	echo. 
	echo     ������ ���� ������� ��� ��室�
) else (
	echo. 
	echo     Press any button for exit
)

RD /s /q "%wd%
pause>nul 2>&1
exit