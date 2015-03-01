@echo off

echo detect sublime version
for %%d in (
	"%ProgramFiles%\Sublime Text 3",
	"%ProgramFiles(x86)%\Sublime Text 3",
	"%ProgramFiles%\Sublime Text 2",
	"%ProgramFiles(x86)%\Sublime Text 2"
) do (
	if exist %%d (
		set _xx=%%d
		goto :success
	)
)

:end
echo can't find
goto :finish

:success

echo starting set env file.

echo @set "PATH=%%PATH%%;%_xx:~1,-1%" > C:\env.bat

cd %_xx%

:: in sublime_text 3 has subl.exe
:: so dno't need doskey
if not exist subl.exe (
	echo @doskey subl=sublime_text.exe $* >> C:\env.bat
)
:: save registry
@reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v "AutoRun" /t REG_SZ /d "C:\env.bat" /f
echo done!!

goto :finish

:finish