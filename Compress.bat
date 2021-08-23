@ECHO OFF

REM ---- COLORS ----
SETLOCAL EnableExtensions EnableDelayedExpansion
for /F %%a in ('echo prompt $E ^| cmd') do (set "ESC=%%a")
REM -------------------------------------------

REM ----#0 kontorla 7 ZIP---- 
if NOT EXIST "C:\Program Files\7-Zip\7z.exe" (
	echo !ESC![31mYou need 7zip!ESC![0m
	echo !ESC![33mLink to download https://www.7-zip.org/%CD%!ESC![0m
	start "" https://www.7-zip.org
	pause
	exit
) else (
	echo !ESC![32m7zip ok!ESC![0m)
REM -------------------------------------------

REM ----#1 kontorla existence složky s moduly----
if NOT EXIST "Modules.dat" (
	echo !ESC![31mNo file named Modules.dat!ESC![0m
	echo !ESC![33mPlease create file Modules.dat and write there your modules!ESC![0m
	pause
	exit
) else (
	echo !ESC![32mModules.dat ok!ESC![0m)
REM -------------------------------------------
	
REM ---- VSTUPNÍ PROMĚNNÉ ----
set ModulesLocation=test\python39-32\lib\site-packages
set Modules=Modules.dat
set PyzName=Package.pyz
REM -------------------------------------------

REM ---- LOKÁLNÍ PROMĚNNÉ ----
set MyLocation=%CD%
set MyPyzTemp=TempPyz
set MyDataTemp=TempData.dat
set /a ErrorLevel = 0
REM -------------------------------------------

REM ----#2 kontorla umístění pythonu---- 
cd %ModulesLocation%
cd ..
cd ..
if NOT EXIST "%CD%\python.exe" (
	echo !ESC![31mThe path to python lib is incorrect!ESC![0m
	echo !ESC![33mYour path %CD%!ESC![0m
	pause
	exit
) else (
	echo !ESC![32mPython ok!ESC![0m)
REM -------------------------------------------

REM ---- vytvoří adresář pro komprimaci ----
cd %MyLocation%
md %MyPyzTemp%
REM -------------------------------------------

REM ---- CYKLUS ---- # ošetřit proti nenalezení modulu
for /f  %%N in (%Modules%) do (for %%M in (%%N) do (
	if EXIST %%M (
		md %MyPyzTemp%\%%M
		xcopy /q /s /e %%M %MyPyzTemp%\%%M
	) else if EXIST %%M.py (
		xcopy /q %%M.py %MyPyzTemp%\
	) else if EXIST %%M.bat (
		xcopy /q %%M.bat %MyPyzTemp%
	) else if EXIST %%M.txt (
		xcopy /q %%M.txt %MyPyzTemp%
	) else if EXIST %%M.dat (
		xcopy /q %%M.dat %MyPyzTemp%
	) else if EXIST %ModulesLocation%\%%M.py (
		xcopy /q %ModulesLocation%\%%M.py %MyPyzTemp% 
	) else if EXIST %ModulesLocation%\%%M (
		md %MyPyzTemp%\%%M
		xcopy /q /s /e %ModulesLocation%\%%M %MyPyzTemp%\%%M
	
	REM ----#4 chybný název---- 
	) else (
		echo The module name is incorrect or is not exist
		echo %%M
		set /a ErrorLevel = 1
)))
if %ErrorLevel%==1 (echo !ESC![31mError in modules!ESC![0m
set /a ErrorLevel = 0
pause)
REM -------------------------------------------

REM ---- smaže __pycache__ ----
cd %MyPyzTemp%
dir /b __pycache__ /s > %MyDataTemp%
set /a count = 1
for /f %%A in (%MyDataTemp%) do (
	rmdir /s /q %%A 
	set /a count += 1
)
del /q %MyDataTemp%
REM -------------------------------------------

REM ----#5 počet smazaných pycache----
echo !ESC![32m__pycache__ ok (%count%)!ESC![30m

REM ----#6 kontorla existence komprimované složky----
if NOT EXIST "%MyLocation%\%MyPyzTemp%" (
	echo !ESC![31mInternal error -1!ESC![0m
	echo !ESC![33mContact the software distributor!ESC![0m
	pause
	exit
)
REM -------------------------------------------

REM ---- smaže starý zip (pyz) a komprimuje----
cd %MyLocation%
if EXIST %PyzName% (del /q /s  %PyzName%)
for /D %%d in (%MyPyzTemp%) do "C:\Program Files\7-Zip\7z.exe" a -tzip "%PyzName%" ".\%%d\*"
REM -------------------------------------------

REM ----#7 kontorla existence pyz souboru----
if NOT EXIST "%MyLocation%\%PyzName%" (
	echo !ESC![31mInternal error -2!ESC![0m
	echo !ESC![33mContact the software distributor!ESC![0m
	pause
	exit
)
REM -------------------------------------------

REM ---- smaže adresář pro komprimaci ----
cd %MyLocation%
rmdir /q /s  %MyPyzTemp%
REM -------------------------------------------

::pause