Invoke-WebRequest -Uri https://www.tightvnc.com/download/2.8.81/tightvnc-2.8.81-gpl-setup-64bit.msi -O tightvnc-2.8.81-gpl-setup-64bit.msi


msiexec /i "tightvnc-2.8.81-gpl-setup-64bit.msi" /quiet /norestart ADDLOCAL="Server,Viewer" VIEWER_ASSOCIATE_VNC_EXTENSION=1 SERVER_REGISTER_AS_SERVICE=1 SERVER_ADD_FIREWALL_EXCEPTION=1 VIEWER_ADD_FIREWALL_EXCEPTION=1 SERVER_ALLOW_SAS=1 SET_USEVNCAUTHENTICATION=1 VALUE_OF_USEVNCAUTHENTICATION=1 SET_PASSWORD=1 VALUE_OF_PASSWORD=1243 SET_USECONTROLAUTHENTICATION=1 VALUE_OF_USECONTROLAUTHENTICATION=1 SET_CONTROLPASSWORD=1 VALUE_OF_CONTROLPASSWORD=1243

Start-Sleep -Seconds 3

# Set the loopback key to allow connections
$loopbackKeyPath = "HKLM:\SOFTWARE\TightVNC\Server"
$loopbackValueName = "AllowLoopback"
$loopbackValueData = 1  # 1 to allow, 0 to disallow

# Set the DWORD value
Set-ItemProperty -Path $loopbackKeyPath -Name $loopbackValueName -Value $loopbackValueData -Type DWORD

# Restart the TightVNC Server service
Restart-Service -Name "TightVNC Server"


Start-Sleep -Seconds 2

# Set the registry key to disable hiding of desktop wallpaper
$registryPath = "HKLM:\Software\TightVNC\Server"
$registryValueName = "RemoveWallpaper"
$registryValueData = 0  # 1 to disable hiding of wallpaper

# Set the DWORD value
Set-ItemProperty -Path $registryPath -Name $registryValueName -Value $registryValueData -Type DWORD

# Restart the TightVNC Server service
Restart-Service -Name "TightVNC Server"
