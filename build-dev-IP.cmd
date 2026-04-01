
@echo off
setlocal

	set DIST_DIR=C:\users\georg\eclipse-workspace\Production\dist
	set TEMP_DIR=C:\users\georg\eclipse-workspace\Production\temp
	
	set NODE_DIR=C:\Users\georg\NodejsProject\swan-games
	set PUBLIC_DIR=%NODE_DIR%/public
	set ROUTES_DIR=%NODE_DIR%/routes
	
	set JS_DIR=%PUBLIC_DIR%/js
	set IMAGES_DIR=%PUBLIC_DIR%/images
	
	echo Build in progress ...
    if not exist "%DIST_DIR%" mkdir "%DIST_DIR%"
    if not exist "%TEMP_DIR%" mkdir "%TEMP_DIR%"
    
    if not exist "%PUBLIC_DIR%" mkdir "%PUBLIC_DIR%"
    if not exist "%ROUTES_DIR%" mkdir "%ROUTES_DIR%"
    
    if not exist "%JS_DIR%" mkdir "%JS_DIR%"
    if not exist "%IMAGES_DIR%" mkdir "%IMAGES_DIR%"
		
	REM Get current year
	for /f %%i in ('powershell -command "Get-Date -Format yyyy"') do set YEAR=%%i

	REM Replace {{year}} in JS files and save to temp folder
	for %%f in (.\*.js) do (
   	 	powershell -command "(Get-Content %%f) -replace '{{year}}', '%YEAR%' | Set-Content %TEMP_DIR%\%%~nxf"
	)

	REM Create entry.js with imports using PowerShell (excludes entry.js itself)
	REM powershell -command "@(Get-ChildItem -Path 'C:\users\georg\eclipse-workspace\Production\temp\*.js' | Where-Object { $_.Name -ne 'entry.js' } | ForEach-Object {\"import './$($_.Name)';\"}) | Set-Content 'C:\users\georg\eclipse-workspace\Production\temp\entry.js' -Encoding UTF8"

	REM Bundle and minify using esbuild
	REM call esbuild %TEMP_DIR%\entry.js --bundle --minify --format=cjs --legal-comments=inline --tree-shaking=false --outfile=%DIST_DIR%\app.bundle.min.js

	REM mangle the code more
	call terser %DIST_DIR%\app.bundle.min.js --compress --mangle --output %DIST_DIR%\app.bundle.supermin.js

	REM Minify HTML
	call html-minifier-terser .\index.html --collapse-whitespace --remove-comments --minify-css true --minify-js true -o %DIST_DIR%\index.min.html

	REM Clean up temp files
	rmdir /s /q %TEMP_DIR%

	REM Copy to public folder
	scp -i "C:/Users/georg/CrossWordle-Keys/crswordle-server-key-pair.pem" -r  %DIST_DIR%\index.min.html %PUBLIC_DIR%\index.html
	REM scp -i "C:/Users/georg/CrossWordle-Keys/crswordle-server-key-pair.pem" -r  %DIST_DIR%\app.bundle.supermin.js %JS_DIR%\app.bundle.supermin.js
	scp -i "C:/Users/georg/CrossWordle-Keys/crswordle-server-key-pair.pem" -r  ".\images\*.jpg" %IMAGES_DIR%
	REM scp -i "C:/Users/georg/CrossWordle-Keys/crswordle-server-key-pair.pem" -r ".\routes\Puzzles.js" %ROUTES_DIR%

	echo Build complete! Bundled minified JS and HTML are in the node/public folder

endlocal