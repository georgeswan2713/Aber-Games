@echo off
setlocal

	set NODE_DIR=C:\Users\georg\NodejsProject
	set PUBLIC_DIR=%NODE_DIR%/public
	set ROUTES_DIR=%NODE_DIR%/routes 
	
    echo Build in progress ...
    set JS_DIR=%PUBLIC_DIR%/js
	set IMAGES_DIR=%PUBLIC_DIR%/images

	
    if not exist "%NODE_DIR%" mkdir "%NODE_DIR%"
    if not exist "%PUBLIC_DIR%" mkdir "%PUBLIC_DIR%"
    if not exist "%ROUTES_DIR%" mkdir "%ROUTES_DIR%"
    
    if not exist "%IMAGES_DIR%" mkdir "%IMAGES_DIR%"

	REM Copy all the TEMP/js files to the public folder
	REM powershell Copy-Item -Path "*.js" -Destination %JS_DIR% -Force
	powershell Copy-Item -Path "index.html" -Destination %NODE_DIR%/public/ -Force
	powershell Copy-Item -Path "images/*.jpg" -Destination %IMAGES_DIR% -Force
	REM powershell Copy-Item -Path "favicon.ico" -Destination %IMAGES_DIR% -Force
	REM powershell Copy-Item -Path "puzzles.txt" -Destination %NODE_DIR% -Force
	REM powershell Copy-Item -Path "routes/Puzzles.js" -Destination %ROUTES_DIR% -Force

	echo Build complete! Bundled JS files into node/public folder.
	
endlocal