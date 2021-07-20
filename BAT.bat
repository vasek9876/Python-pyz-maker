@ECHO OFF

::----------------------------------------------------------------------------



:: folder_location
set A=test1
:: modules (folder/file.py)
set A1=A
set A2=x.py



::-----------------------------------------------------------------------------
::internal
set B=test2\package
::delete __pycache__
cd %A%
dir /b __pycache__ /s > %temp%\files
for /f %%a in (%temp%\files) do (echo rmdir /s /q %%a)
del %temp%\files

::vytvoří adresář pro ukládání
cd ..
md test2
md test2\%A1%
md test2\%A2%

::kopíruje
if NOT %A1:~-2,3% == py (xcopy /e/s %A%\%A1% %B%\%A1%)
::else (copy %A%\%A1% %B%\%A1:~0,-3%.py)
::if NOT %A2:~-2,3% == py (xcopy /e/s %A%\%A2% %B%\%A2%)
if %A2:~-2,3% == py (xcopy %A% %B%)


if EXIST package.zip rmdir /s /q package.zip
::"balí a uklízí"
for /D %%d in (%B%) do "C:\Program Files\7-Zip\7z.exe" a -tzip "package.zip" ".\%%d\*"
rmdir /s /q test2

echo -----------------------------------------------------------------
echo Done!
pause