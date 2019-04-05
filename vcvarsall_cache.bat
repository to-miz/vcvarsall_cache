@echo off
setlocal enabledelayedexpansion

set "OLD_INCLUDE=%INCLUDE%"
set "OLD_LIB=%LIB%"
set "OLD_LIBPATH=%LIBPATH%"
set "OLD_PATH=%PATH%"

@echo @echo off
call :make %1 x86
call :make %1 x64
goto :eof

:make
if "%~1" == "" goto :eof

set "INCLUDE="
set "LIB="
set "LIBPATH="
set "NEW_PATH="

call %1 %2 > nul 2> nul
for %%A in ("%PATH:;=";"%") do (
	set matching=0
	for %%B in ("%OLD_PATH:;=";"%") do (
		if %%A == %%B (
			set matching=1
		)
	)
	if !matching! == 0 ( call set "NEW_PATH=%%~A;%%NEW_PATH%%" )
)

(
 	@echo if "%%1" == "" goto :%2end
 	@echo if /i NOT "%%1" == "%2" goto :%2end
	@echo set "INCLUDE=%INCLUDE%;%%INCLUDE%%"
	@echo set "LIB=%LIB%;%%LIB%%"
	@echo set "LIBPATH=%LIBPATH%;%%LIBPATH%%"
	@echo set "PATH=%NEW_PATH%;%%PATH%%"
	@echo :%2end
)

set "INCLUDE=%OLD_INCLUDE%"
set "LIB=%OLD_LIB%"
set "LIBPATH=%OLD_LIBPATH%"
set "PATH=%OLD_PATH%"