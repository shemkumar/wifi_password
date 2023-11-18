$profiles = netsh wlan show profiles | Select-String "All User Profile\s+:\s(.+)$" | %{$_.Matches.Groups[1].Value.Trim()}

$results = @()

foreach ($profile in $profiles) {
    $profileDetails = netsh wlan show profile name="$profile" key=clear | Select-String "Key Content\s+:\s(.+)$" | %{$_.Matches.Groups[1].Value.Trim()}
    
    $results += [PSCustomObject]@{
        PROFILE_NAME = $profile
        PASSWORD = $profileDetails
    }
}

$results | Format-Table -AutoSize

# Output to a text file
$results | Out-File -FilePath "C:\Users\SAM\Desktop\pass.txt"
