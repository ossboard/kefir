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

	echo ------------------------------------------------------------------------
	echo.
	echo                   ����஢���� ���� �� �६����� �����                   
	echo.
	echo ------------------------------------------------------------------------


if exist "%temp%\sdfiles\" (RD /s /q "%temp%\sdfiles\")
if not exist "%temp%\sdfiles\" (mkdir %temp%\sdfiles\)
xcopy "%~dp0kefir\*" "%sd%:\" /H /Y /C /R /S /E
xcopy "%wd%\payload.bin" "%sd%:\" /H /Y /C /R

del "%sd%:\hekate_ctcaer_*.bin"

if exist "E:\Switch\addons\themes" (xcopy "E:\Switch\addons\themes\*" "%sd%:\themes" /H /Y /C /R /S /E /I)
if exist "E:\Switch\addons\atmosphere" (xcopy "E:\Switch\addons\atmosphere\*" "%sd%:\atmosphere" /H /Y /C /R /S /E /I)
if exist "E:\Switch\TinGen-main\index.tfl" (xcopy "E:\Switch\TinGen-main\index.tfl" "%sd%:\" /H /Y /C /R /S /E /I)

reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\usbstor\11ECA7E0 /v MaximumTransferLength /t REG_DWORD /d 00100000 /f
if exist "%sd%:\TinGen" (RD /s /q "%sd%:\TinGen")



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