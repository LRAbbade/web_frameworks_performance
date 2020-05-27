@setlocal ENABLEDELAYEDEXPANSION
@echo OFF

@REM
@REM Batch script to launch Java app jooby
@REM
@REM Description: Jooby Command Line Interface
@REM
@REM Auto generated via Stork Launcher v3.0.0 made by Fizzed, Inc.
@REM   Web: http://fizzed.com
@REM   Twitter: http://twitter.com/fizzed_inc
@REM   Github: https://github.com/fizzed/stork
@REM

@REM
@REM working directory setup
@REM

set INITIAL_WORKING_DIR=%CD%

SET SCRIPTPATH=%~dp0
SET SCRIPTPATH=%SCRIPTPATH:~0,-1%
set APP_HOME_REL=%SCRIPTPATH%\..
@REM echo app_home_relative %APP_HOME_REL%

@REM
@REM constants
@REM

@REM set to 1 if you want to see more info about what the script is doing
if "%LAUNCHER_DEBUG%"=="" set LAUNCHER_DEBUG=0

set NAME=jooby
set TYPE=CONSOLE
set MAIN_CLASS=io.jooby.cli.Cli
if "%MIN_JAVA_VERSION%"=="" set MIN_JAVA_VERSION=1.8
if "%WORKING_DIR_MODE%"=="" set WORKING_DIR_MODE=RETAIN
if "%INCLUDE_JAVA_XRS%"=="" set INCLUDE_JAVA_XRS=1

@REM echo temporarily change working directory to get good abs path for home
pushd %APP_HOME_REL%
set APP_HOME=!CD!

if %WORKING_DIR_MODE%==RETAIN (
    popd
)

@REM
@REM settings
@REM

if "%LOG_DIR%"=="" set LOG_DIR=log
if "%RUN_DIR%"=="" set RUN_DIR=run
if "%BIN_DIR%"=="" set BIN_DIR=bin
if "%LIB_DIR%"=="" set LIB_DIR=lib
if "%APP_ARGS%"=="" set APP_ARGS=
if "%EXTRA_APP_ARGS%"=="" set EXTRA_APP_ARGS=
if "%JAVA_ARGS%"=="" set JAVA_ARGS=
if "%EXTRA_JAVA_ARGS%"=="" set EXTRA_JAVA_ARGS=

@REM setup remaining directories
set APP_BIN_DIR=%APP_HOME%\%BIN_DIR%
set APP_LOG_DIR=%APP_HOME%\%LOG_DIR%
set APP_LIB_DIR=%APP_HOME%\%LIB_DIR%
set APP_RUN_DIR=%APP_HOME%\%RUN_DIR%

if "%LAUNCHER_DEBUG%"=="1" (
    echo ^[LAUNCHER^] working_dir: %CD%
    echo ^[LAUNCHER^] app_home: %APP_HOME%
    echo ^[LAUNCHER^] app_bin: %APP_BIN_DIR%
    echo ^[LAUNCHER^] app_log: %APP_LOG_DIR%
    echo ^[LAUNCHER^] app_lib: %APP_LIB_DIR%
    echo ^[LAUNCHER^] app_run: %APP_RUN_DIR%
)

set bit64=n
if /I %Processor_Architecture%==AMD64 set bit64=y
if /I "%PROCESSOR_ARCHITEW6432%"=="AMD64" set bit64=y
@REM echo bit64: %bit64%

@REM CONSOLE or DAEMON (so we can pass it thru as a system property)
set RUN_TYPE=%TYPE%

@REM
@REM for testing this independently (in your shell)
@REM   echo off
@REM   setlocal ENABLEDELAYEDEXPANSION
@REM   set MIN_JAVA_VERSION=1.8
@REM   JAVA_SEARCH_DEBUG=1
@REM

if NOT "%JAVA_EXE%"=="" (
    set java_bin_accepted=%JAVA_EXE%
    goto :AcceptableJavaBinFound
)

set target_java_ver_num=0
call :ExtractJavaMajorVersionNum "%MIN_JAVA_VERSION%" target_java_ver_num
if "%target_java_ver_num%"=="0" (
    echo Unable to extract major version from "%MIN_JAVA_VERSION%"
    Exit /B 1
)

call :JavaSearchDebug "target_java_ver_num: %target_java_ver_num%"

@REM
@REM is java or jre in JAVA_HOME acceptable?
@REM
call :JavaSearchDebug "Searching JAVA_HOME env var..."
if NOT "%JAVA_HOME%"=="" (
    call :IsJavaBinVersionAcceptable "!JAVA_HOME!\jre\bin\java" !target_java_ver_num! java_bin_accepted
    if NOT "!java_bin_accepted!" == "" goto :AcceptableJavaBinFound

    call :IsJavaBinVersionAcceptable "!JAVA_HOME!\bin\java" !target_java_ver_num! java_bin_accepted
    if NOT "!java_bin_accepted!" == "" goto :AcceptableJavaBinFound
)


@REM
@REM is java in the current path?
@REM
call :JavaSearchDebug "Searching PATH..."
for %%X in (java.exe) do (set JAVA_IN_PATH=%%~$PATH:X)
IF DEFINED JAVA_IN_PATH (
    call :IsJavaBinVersionAcceptable !JAVA_IN_PATH! !target_java_ver_num! java_bin_accepted
    if NOT "!java_bin_accepted!" == "" goto :AcceptableJavaBinFound
)


@REM
@REM query registry for java runtime environment
@REM no keys will log to stderr so we redirect to nul
@REM

set reg_best_java_bin=


call :JavaSearchDebug "Searching registry for JDK 9+ entries..."

@REM always sorted most recent first
set reg_java_bin=
for /f "tokens=2*" %%i in ('reg query "HKLM\Software\JavaSoft\JDK" /s 2^>nul ^| find "JavaHome"') do if not defined reg_java_bin (
    set reg_java_bin=%%j\bin\java
)

call :IsJavaBinVersionAcceptable "!reg_java_bin!" !target_java_ver_num! java_bin_accepted
if NOT "!java_bin_accepted!" == "" set reg_best_java_bin=!java_bin_accepted!

if NOT "%reg_best_java_bin%"=="" (
    set java_bin_accepted=!reg_best_java_bin!
    goto :AcceptableJavaBinFound
)


call :JavaSearchDebug "Searching registry for JDK 8 or less entries..."

@REM always sorted most recent first
set reg_java_bin=
for /f "tokens=2*" %%i in ('reg query "HKLM\Software\JavaSoft\Java Development Kit" /s 2^>nul ^| find "JavaHome"') do if not defined reg_java_bin (
    set reg_java_bin=%%j\bin\java
)

call :IsJavaBinVersionAcceptable "!reg_java_bin!" !target_java_ver_num! java_bin_accepted
if NOT "!java_bin_accepted!" == "" set reg_best_java_bin=!java_bin_accepted!

if NOT "%reg_best_java_bin%"=="" (
    set java_bin_accepted=!reg_best_java_bin!
    goto :AcceptableJavaBinFound
)


call :JavaSearchDebug "Searching registry for JRE 9+ entries..."

@REM always sorted most recent first
set reg_java_bin=
for /f "tokens=2*" %%i in ('reg query "HKLM\Software\JavaSoft\JRE" /s 2^>nul ^| find "JavaHome"') do if not defined reg_java_bin (
    set reg_java_bin=%%j\bin\java
)

call :IsJavaBinVersionAcceptable "!reg_java_bin!" !target_java_ver_num! java_bin_accepted
if NOT "!java_bin_accepted!" == "" set reg_best_java_bin=!java_bin_accepted!

if NOT "%reg_best_java_bin%"=="" (
    set java_bin_accepted=!reg_best_java_bin!
    goto :AcceptableJavaBinFound
)


call :JavaSearchDebug "Searching registry for JRE 8 or less entries..."

@REM always sorted most recent first
set reg_java_bin=
for /f "tokens=2*" %%i in ('reg query "HKLM\Software\JavaSoft\Java Runtime Environment" /s 2^>nul ^| find "JavaHome"') do if not defined reg_java_bin (
    set reg_java_bin=%%j\bin\java
)

call :IsJavaBinVersionAcceptable "!reg_java_bin!" !target_java_ver_num! java_bin_accepted
if NOT "!java_bin_accepted!" == "" set reg_best_java_bin=!java_bin_accepted!

if NOT "%reg_best_java_bin%"=="" (
    set java_bin_accepted=!reg_best_java_bin!
    goto :AcceptableJavaBinFound
)


:NoAcceptableJavaBinFound
@REM if we get here then the search above failed
call :JavaSearchDebug "No acceptable java found"
@ECHO Unable to find Java runtime on system with version ^>^= %MIN_JAVA_VERSION%
@ECHO Please visit http://java.com to install an acceptable Java Runtime
@ECHO For debugging how this script searches for the JRE:
@ECHO   SET LAUNCHER_DEBUG=1
@ECHO and then run the command again
EXIT /B 1

:AcceptableJavaBinFound
call :JavaSearchDebug "Acceptable java bin found: %java_bin_accepted%"
goto :JavaSearchEnd


@REM 1.7 -> returns 7 in param 2 or 0 if not found
:ExtractJavaMajorVersionNum
setlocal
SET full_ver=%~1
for /f "delims=. tokens=1-2" %%v in ("%full_ver%") do (
    @REM @echo Major: %%v
    @REM @echo Minor: %%w
    if %%v gtr 1 (
        set maj_ver_num=%%v
    ) else (
        set maj_ver_num=%%w
    )
)
if "%maj_ver_num%"=="" (
    set maj_ver_num=0
)
( endlocal
    set "%2=%maj_ver_num%"
)
GOTO:EOF


@REM java_exe -> returns major version like 7 in param 2
:GetJavaBinMajorVersionNum
setlocal
SET java_bin=%~1

@REM echo getting ver for: %java_bin%

for /f "tokens=3" %%g in ('cmd /c "%java_bin%" -version 2^>^&1 ^| findstr /i "version"') do (
    REM @echo Output: %%g
    set JAVAVER=%%g
)
SET java_version=
if NOT "%JAVAVER%"=="" (
    set JAVAVER=%JAVAVER:"=%
    @REM @echo Output: %JAVAVER%
    for /f "delims=. tokens=1-3" %%v in (%JAVAVER%) do (
        @REM @echo Major: %%v
        @REM @echo Minor: %%w
        @REM @echo Build: %%x
        if %%v gtr 1 (
            @REM @echo was greater than 1
            set java_version=%%v
        ) else (
            @REM @echo was equal to 1
            set java_version=%%w
        )
    )
)
( endlocal
    @REM @echo java_version: %java_version%
    set "%2=%java_version%"
    set "%3=%JAVAVER%"
)
GOTO :EOF


@REM call :IsJavaBinVersionAcceptable java_bin target_java_ver_num java_bin_if_accepted
:IsJavaBinVersionAcceptable
setlocal
SET java_bin=%~1
SET target_java_ver_num=%~2
call :JavaSearchDebug "java_bin: %java_bin%"
call :GetJavaBinMajorVersionNum "%java_bin%" java_bin_ver_num java_full_ver
if "%java_bin_ver_num%"=="" (
    set java_bin_ver_num=0
)
if %java_bin_ver_num% geq %target_java_ver_num% (
    set java_bin_if_accepted=!java_bin!
    call :JavaSearchDebug " version: !java_full_ver! ^(meets minimum 1.!target_java_ver_num!^)"
) else (
    set java_bin_if_accepted=
    call :JavaSearchDebug " version: !java_full_ver! ^(^less than 1.!target_java_ver_num! though^)"
)
)
( endlocal
    set "%3=%java_bin_if_accepted%"
)
GOTO :EOF


@REM Strip quotes and extra backslash from string
:StripQuotesAndBackslash
setlocal
set o=%~1
SET n=%~1
SET n=%n:\\=\%
SET n=%n:"=%
( endlocal
    IF NOT "%n%"=="" set "%2=%n%" ELSE set "%2=%o%"
)
GOTO :EOF


:JavaSearchDebug
setlocal
SET v=%~1
if "%LAUNCHER_DEBUG%"=="1" (
    echo ^[JAVA_SEARCH^] !v!
)
GOTO :EOF

:JavaSearchEnd

@REM Bug with Java7 <= build 8 on wildcard classpath expansion
@REM easy solution is to append a semi-colon at end onto classpath
@REM http://stackoverflow.com/questions/9195073/broken-wildcard-expansion-for-java7-commandline-on-windows7
set APP_CLASSPATH=%APP_LIB_DIR%\*;

if "%LAUNCHER_DEBUG%"=="1" (
    echo ^[LAUNCHER^] java_classpath: %APP_CLASSPATH%
    echo ^[LAUNCHER^] java_bin: %java_bin_accepted%
)

@REM append extra app and java args?

if NOT "%EXTRA_JAVA_ARGS%"=="" (
  set JAVA_ARGS=%JAVA_ARGS% %EXTRA_JAVA_ARGS%
)

if NOT "%EXTRA_APP_ARGS%"=="" (
  set APP_ARGS=%APP_ARGS% %EXTRA_APP_ARGS%
)

@REM
@REM Process arguments into either app or java system property
@REM With recursion used the various labels help prevent multiple executions
@REM 
call :ProcessArgs %*
goto :ProcessedArgs

:ProcessArgs
for /F "tokens=1*" %%a in ("%*") do (
  set arg=%%a

  @REM quoted?
  IF !arg:~0^,1!!arg:~-1! equ "" (
    IF "!arg:~1,3!"=="-D" (
      set JAVA_ARGS=%JAVA_ARGS% !arg!
    ) ELSE (
      set APP_ARGS=%APP_ARGS% !arg!
    )
  ) ELSE (
    IF "!arg:~0,2!"=="-D" (
      set JAVA_ARGS=%JAVA_ARGS% !arg!
    ) ELSE (
      set APP_ARGS=%APP_ARGS% !arg!
    )
  )
  
  if NOT x%%b==x call :ProcessArgs %%b
)
goto :eof
:ProcessedArgs

@REM
@REM prepend -Xrs flag?
@REM
if "%INCLUDE_JAVA_XRS%"=="1" (
  set JAVA_ARGS=-Xrs %JAVA_ARGS%
)

if "%LAUNCHER_DEBUG%"=="1" (
@ECHO ON
)

"%java_bin_accepted%" -Dlauncher.name=%NAME% -Dlauncher.type=%RUN_TYPE% "-Dlauncher.app.dir=%APP_HOME%"m -cp "%APP_CLASSPATH%" %JAVA_ARGS% %MAIN_CLASS% %APP_ARGS%

@ECHO OFF

if %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%
:endLabel
goto :eof

:errorlabel
setlocal
SET error_code=%~1
IF "%error_code%" NEQ "" EXIT /B %error_code
Exit /B %ERRORLEVEL%
goto :eof
