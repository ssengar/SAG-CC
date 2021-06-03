@echo off
setlocal

rem #############################################
rem #
rem # Batch Script to Install Command Central
rem # 
rem #############################################

rem Read CCE and CICD setup related values from a properties file 
FOR /F "eol=# tokens=1,2 delims==" %%G IN (setup.properties) DO (set %%G=%%H)  

SET src_dir=%src_dir%
SET target_dir=%target_dir%
IF NOT EXIST %src_dir% MKDIR %src_dir%
git clone --recursive -b release/105oct2019 https://github.com/SoftwareAG/sagdevops-cc-server
IF NOT EXIST %target_dir% MKDIR %target_dir%
git clone 

IF NOT EXIST %target_dir% MKDIR %target_dir%
cd %cicdhome_dir%
echo "============== Start at %start_datetime% ==================" >> %log_file%
echo.
echo Clone the sagdevops-cc-server GIT repo
IF %errorlevel% NEQ 0 (
	echo Non-zero exit code %errorlevel% was returned. Exit the process.
	rem endlocal	
	EXIT /B %errorlevel%
)
cd %cicdhome_dir%\sagdevops-cc-server

echo Bootstrap CCE
rem ant boot -Daccept.license=true -Dcc.cli.home=%cc_cli_home% -Dinstall.dir=%sagcce_installdir% >> %log_file%
ant boot -Daccept.license=true >> %log_file%
IF %errorlevel% NEQ 0 (
	echo Non-zero exit code %errorlevel% was returned. Exit the process.
	rem endlocal	
	EXIT /B %errorlevel%
)
echo ant up test 
ant up test >> %log_file%

rem Exit from main script
EXIT /B %errorlevel%