Write-Host "=== Welcome to your Linux Developer System :) ** MADE BY NOBODY ** ===" -ForegroundColor Cyan
Write-Host "=== INFO: You can cd to anywhere on your Windows system. By default the application will cd to your desktop.===" -ForegroundColor Yellow
Write-Host "=== INFO: All files you have are in a virtual folder: /mnt/<partition letter> while being in this enviroment. ===" -ForegroundColor Yellow
Write-Host "=== INFO: For example /mnt/C is your C-drive (Windows System by Default) ===" -ForegroundColor Yellow
Write-Host "=== INFO: Your files locations haven't changed, but in this enviroment they are located in /mnt/ folder. ===" -ForegroundColor Yellow
Write-Host "=== INFO: You can edit files, and use your Windows machine just like before even if you keep this terminal open. ===" -ForegroundColor Yellow

$desktopPath = [Environment]::GetFolderPath("Desktop")

Start-Process wsl.exe -ArgumentList "-d", "Debian", "-u", "dev", "--cd", "$desktopPath"