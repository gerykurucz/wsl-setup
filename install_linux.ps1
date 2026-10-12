if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $currentProcessPath = [System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName
    if ($currentProcessPath.EndsWith(".exe", [System.StringComparison]::OrdinalIgnoreCase)) {
        Start-Process $currentProcessPath -Verb RunAs
    } else {
        Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    }
    exit
}

Write-Host "=== Nobody's WSL Linux Developer Enviroment Setup for Debian 13 (Trixie) ===" -ForegroundColor Cyan

Write-Host "`n[1/5] Installing Linux.." -ForegroundColor Yellow
wsl --install -d Debian --no-launch

Write-Host "`n[2/5] Creating User: dev | Password: 1234" -ForegroundColor Yellow
wsl -d Debian -u root bash -c "useradd -m -s /bin/bash dev 2>/dev/null || true"
wsl -d Debian -u root bash -c "usermod -p `'`$(openssl passwd -6 '1234')`' dev"
wsl -d Debian -u root bash -c "usermod -aG sudo dev"

Write-Host "`n[3/5] Getting Debian 13 packages.." -ForegroundColor Yellow
wsl -d Debian -u root bash -c "sed -i 's/bookworm/trixie/g' /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null || true"

Write-Host "`n[4/5] Adding architecture i386 (32-bit).." -ForegroundColor Yellow
wsl -d Debian -u root bash -c "dpkg --add-architecture i386"

Write-Host "`n[5/5] Updating the system & installing developer packages.." -ForegroundColor Yellow

$packages = "build-essential gcc-multilib g++-multilib libc6-dev-i386 nasm yasm cmake make git gdb nano curl wget"

wsl -d Debian -u root bash -c "export DEBIAN_FRONTEND=noninteractive; apt-get update && apt-get dist-upgrade -y && apt-get install -y $packages"

Write-Host "`n=== Done! Linux developer enviroment has been installed successfully! ===" -ForegroundColor Green
Write-Host "`n=== Now you can start Debian 13 with the Linux application! ===" -ForegroundColor Green
Write-Host "`n=== CREATED BY NOBODY ===" -ForegroundColor Green
pause