Write-Output "Creating stand-alone executables for Windows..."
mkdir build -ea 0
raco exe --gui -o build/main.exe ./main.rkt
Write-Output "Complete."
