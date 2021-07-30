@ECHO OFF
REM ---- COLORS ----
SETLOCAL EnableExtensions DisableDelayedExpansion
for /F %%a in ('echo prompt $E ^| cmd') do (set "ESC=%%a")
REM -------------------------------------------

REM ---- 7 ZIP kontorla ----
SETLOCAL EnableDelayedExpansion

if NOT EXIST "C:\Program Files\7-Zip\7z.exe" (
	echo !ESC![31mYou need 7zip!ESC![0m    
) else (
	echo !ESC![32m7zip ok!ESC![0m
)
REM -------------------------------------------

REM ---- VSTUPNÍ PROMĚNNÉ ----
set ModulesLocation=test\python39-32\lib\site-packages
set Modules=pyparsing,yaml,x,compress
set PyzName=package.zip
REM -------------------------------------------

REM ---- LOKÁLNÍ PROMĚNNÉ ----
set MyLocation=%CD%
set MyPyzTemp=TempPyz
set MyDataTemp=TempData.dat
REM -------------------------------------------

REM ---- vytvoří adresář pro komprimaci ----
cd %MyLocation%
md %MyPyzTemp%
REM -------------------------------------------

echo !ESC![34m#kopirovani knihoven !ESC![35m
REM ---- CYKLUS ----
for %%M in (%Modules%) do (
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
	)
)
REM -------------------------------------------

echo !ESC![34m#mazani pycache !ESC![0m  
REM ---- smaže __pycache__ ----
cd %MyPyzTemp%
dir /b __pycache__ /s > %MyDataTemp%
for /f %%A in (%MyDataTemp%) do (rmdir /s /q %%A)
del /q %MyDataTemp%
REM -------------------------------------------

echo !ESC![34m#komprese !ESC![30m 
REM ---- smaže starý zip (pyz) a komprimuje----
cd %MyLocation%
if EXIST %PyzName% (del /q /s  %PyzName%)
for /D %%d in (%MyPyzTemp%) do "C:\Program Files\7-Zip\7z.exe" a -tzip "%PyzName%" ".\%%d\*"
REM -------------------------------------------

echo !ESC![34m#cisteni !ESC![30m  
REM ---- smaže adresář pro komprimaci ----
cd %MyLocation%
rmdir /q /s  %MyPyzTemp%
ENDLOCAL
REM -------------------------------------------

REM ---- Čekám na kliknutí a pak ukončím ----
pause
REM -------------------------------------------
