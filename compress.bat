@ECHO OFF

REM ---- VSTUPNÍ PROMĚNNÉ ----
set ModulesLocation=test\python39-32\lib\site-packages
set Modules=pyparsing,yaml.py,x.py
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

REM ---- CYKLUS ----
for %%M in (%Modules%) do (
md %ModulesLocation%\%%M 
xcopy /s /e %ModulesLocation%\%%M %MyPyzTemp%\%%M 
)

REM nefunguje automatické určování typu souboru

::if NOT %M1:~-2,3% == py (
::md %%M 

::) else (
::xcopy %ModulesLocation%\%%M %MyPyzTemp%)
REM -------------------------------------------

echo #pycache
REM ---- smaže __pycache__ ----
cd %MyLocation%\%MyPyzTemp%
dir /b __pycache__ /s > %MyLocation%\%MyDataTemp%
cd ..
echo %MyDataTemp%
for /f %%A in (%MyDataTemp%) do (rmdir /s /q %%A)
::del %MyDataTemp%
REM -------------------------------------------

echo #komprese
REM ---- smaže starý zip (pyz) a komprimuje----
cd %MyLocation%
if EXIST %PyzName% (del /s /q %PyzName%)
for /D %%d in (%MyPyzTemp%) do "C:\Program Files\7-Zip\7z.exe" a -tzip "%PyzName%" ".\%%d\*"
REM -------------------------------------------


REM ---- smaže adresář pro komprimaci ----
cd %MyLocation%
rmdir /s /q %MyPyzTemp%
REM -------------------------------------------

REM ---- Čekám na kliknutí a pak ukončím ----
pause
REM -------------------------------------------