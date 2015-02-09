@echo off

echo detect sublime version
if exist "%ProgramFiles%\Sublime Text 3\sublime_text.exe" (
	rem x64 sublime 3
	echo @echo off > C:\env.bat
	echo set "PATH=%%PATH%%;%%ProgramFiles%%\Sublime Text 3\" >> C:\env.bat
) else (
	if exist "%ProgramFiles(x86)%\Sublime Text 3\sublime_text.exe" (
		rem x86 sublime 3
		echo @echo off > C:\env.bat
		echo set "PATH=%%PATH%%;%%ProgramFiles(x86)%%\Sublime Text 3\;" >> C:\env.bat
	) else ( 
		echo sublime not installed
		goto :END
	)
)

echo doskey subl=sublime_text.exe $* >> C:\env.bat
:: save registry
@reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v "AutoRun" /t REG_SZ /d "C:\env.bat" /f
echo success!!
:END
@pause