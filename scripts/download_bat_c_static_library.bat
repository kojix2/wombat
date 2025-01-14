@echo off

:: Set the destination directory
set DEST_DIR=%~dp0\..\src\ext
if not exist %DEST_DIR% mkdir %DEST_DIR%

:: Set the download URL
set URL=https://github.com/kojix2/bat-c/releases/latest/download

:: Set the file names to download
set ZIP_FILE=bat_c_windows.zip
set TARGET_FILE=bat_c.lib

:: Download the file
echo Downloading %ZIP_FILE% from %URL%...
powershell -Command "Invoke-WebRequest -Uri %URL%/%ZIP_FILE% -OutFile %ZIP_FILE%"

:: Extract the ZIP file
echo Extracting %TARGET_FILE%...
powershell -Command "Expand-Archive -Path %ZIP_FILE% -DestinationPath ."

:: Move the target file to the destination directory
move /Y %TARGET_FILE% %DEST_DIR%

:: Remove the downloaded ZIP file
echo Cleaning up...
del %ZIP_FILE%

echo Done! %TARGET_FILE% has been saved in %DEST_DIR%.
pause
