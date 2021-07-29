@ECHO OFF

REM ---- VSTUPNÍ PROMĚNNÉ ----
set ModulesLocation=test\python39-32\lib\site-packages
set Modules=pyparsing,yaml,x
set Adons=a
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
cls
echo #kopirovani knihoven
REM ---- CYKLUS ----
for %%M in (%Modules%) do (
	set x=%ModulesLocation%\%%M
	if EXIST %ModulesLocation%\%%M.py (
		xcopy /q /s /e %ModulesLocation%\%%M.py %MyPyzTemp% 
	) else if EXIST %ModulesLocation%\%%M (
		md %MyPyzTemp%\%%M
		xcopy /q /s /e %ModulesLocation%\%%M %MyPyzTemp%\%%M 
	)
)
REM -------------------------------------------

echo #mazani pycache
REM ---- smaže __pycache__ ----
cd %MyPyzTemp%
dir /b __pycache__ /s > %MyDataTemp%
for /f %%A in (%MyDataTemp%) do (rmdir /s /q %%A)
del /q %MyDataTemp%
REM -------------------------------------------

echo #komprese
REM ---- smaže starý zip (pyz) a komprimuje----
cd %MyLocation%
if EXIST %PyzName% (del /q /s  %PyzName%)
for /D %%d in (%MyPyzTemp%) do "C:\Program Files\7-Zip\7z.exe" a -tzip "%PyzName%" ".\%%d\*"
REM -------------------------------------------

echo #cisteni
REM ---- smaže adresář pro komprimaci ----
cd %MyLocation%
rmdir /q /s  %MyPyzTemp%
REM -------------------------------------------

REM ---- Čekám na kliknutí a pak ukončím ----
pause
REM -------------------------------------------