@echo off
setlocal

for /f "usebackq tokens=*" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -find Common7\Tools\VsDevCmd.bat`) do (
  call "%%i" -arch=x64
  goto :found
)
echo vswhere or VS BuildTools not found.
exit /b 1

:found
cl /nologo /std:c++20 /EHsc /LD ^
  /DUNICODE /D_UNICODE /utf-8 /wd4828 ^
  /I sdk ^
  src\MyAssetManager.cpp ^
  user32.lib gdi32.lib comctl32.lib shell32.lib ^
  /Fe:MyAssetManager.dll


REM 出力拡張子を .aux2 に合わせる
if exist MyAssetManager.aux2 del /q MyAssetManager.aux2
rename MyAssetManager.dll MyAssetManager.aux2

echo Build OK
endlocal
