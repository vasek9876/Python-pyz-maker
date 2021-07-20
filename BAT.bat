
::----------------------------------------------------------------------------


:: folder_location
set A=test\python39-32\lib\site-packages
:: modules (folder/file.py)
set A1=pyparsing
set A2=yaml.py


::-----------------------------------------------------------------------------

:: vnitřní nastavení
@ECHO OFF
set MY=%CD%
set B=package

:: vytvoří adresář pro ukládání
cd %MY%
md %B%

:: kopíruje

:: 1. sobor/složka
if NOT %A1:~-2,3% == py (
md %B%\%A1%
xcopy %A%\%A1% %B%\%A1% /s /e
)
else (
xcopy %A%\%A1% %B%
)

:: 2. sobor/složka
if NOT %A2:~-2,3% == py (
md %B%\%A2%
xcopy %A%\%A2% %B%\%A2% /s /e
)
else (
xcopy %A%\%A2% %B%
)

:: smaže __pycache__
cd %MY%\%B%
dir /b __pycache__ /s > %temp%\files
for /f %%a in (%temp%\files) do (rmdir /s /q %%a)
del %temp%\files

:: komprimuje
cd %MY%
for /D %%d in (%B%) do "C:\Program Files\7-Zip\7z.exe" a -tzip "package.zip" ".\%%d\*"

:: maže kopírované soubory a složky
rmdir /s /q %B%

echo -----------------------------------------------------------------
echo Done!
pause