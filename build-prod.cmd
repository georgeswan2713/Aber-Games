@echo off
setlocal

	set PEM_FILE="D:\GitHub Repos\CrossWordle-Keys/crswordle-server-key-pair.pem"
	REM set PEM_FILE="C:\Users\georg\GitHub Repos\CrossWordle-Keys/crswordle-server-key-pair.pem"
	set NODE_DIR=/home/ubuntu/NodeJS-Setup
	set EC2_IP=ubuntu@3.143.205.120
	
		echo Build in progress ...
	
		REM Copy to public folder
		scp -i %PEM_FILE% -r  .\index.html %EC2_IP%:/%NODE_DIR%/public/index.html
		scp -i %PEM_FILE% -r  ".\images\*.jpg" %EC2_IP%:/%NODE_DIR%/public/images/
		scp -i %PEM_FILE% -r ".\images\favicon.ico" %EC2_IP%:/%NODE_DIR%/public/images/
	
		echo Build complete! Bundled minified JS and HTML are in the node/public folder

endlocal