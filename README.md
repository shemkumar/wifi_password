# wifi_password

TO steal the stored wifi password in your system

PowerShell Script to Retrieve Wi-Fi Passwords
This PowerShell script is designed to retrieve Wi-Fi passwords stored on a Windows system. It utilizes netsh wlan commands to gather information about Wi-Fi profiles and their associated passwords.

Script Overview
Retrieving Wi-Fi Profiles
The script begins by using the netsh wlan show profiles command to gather a list of all Wi-Fi profiles stored on the system.

powershell
Copy code
$profiles = netsh wlan show profiles | Select-String "All User Profile\s+:\s(.+)$" | %{$_.Matches.Groups[1].Value.Trim()}
Extracting Passwords
For each Wi-Fi profile, the script retrieves the password using the netsh wlan show profile command with the key=clear parameter.

powershell
Copy code
foreach ($profile in $profiles) {
    $profileDetails = netsh wlan show profile name="$profile" key=clear | Select-String "Key Content\s+:\s(.+)$" | %{$_.Matches.Groups[1].Value.Trim()}
    
    $results += [PSCustomObject]@{
        PROFILE_NAME = $profile
        PASSWORD = $profileDetails
    }
}
Output
The script outputs the Wi-Fi profile names and their associated passwords in a tabular format.

powershell
Copy code
$results | Format-Table -AutoSize
Additionally, the script saves the results to a text file named pass.txt on the desktop.

powershell
Copy code
$results | Out-File -FilePath "C:\Users\SAM\Desktop\pass.txt" #to change your location
Security Considerations
It's important to note that extracting Wi-Fi passwords without proper authorization may violate privacy and security policies. This script should only be used in controlled environments with appropriate permissions.

