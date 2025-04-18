# Set the password for all new users
$passw = "Password123" | ConvertTo-SecureString -AsPlainText -Force

# Path to the CSV file containing user information
$csvFile = ".\Kozpont_users.csv"

# Function to remove Hungarian accents and convert to ASCII
function Remove-HungarianAccents {
    param (
        [string]$InputString
    )
    # Replace accented characters with their non-accented equivalents
    $InputString -replace 'á', 'a' -replace 'é', 'e' -replace 'í', 'i' -replace 'ó', 'o' -replace 'ö', 'o' `
                 -replace 'ő', 'o' -replace 'ú', 'u' -replace 'ü', 'u' -replace 'ű', 'u' `
                 -replace 'Á', 'a' -replace 'É', 'e' -replace 'Í', 'i' -replace 'Ó', 'o' -replace 'Ö', 'o' `
                 -replace 'Ő', 'o' -replace 'Ú', 'u' -replace 'Ü', 'u' -replace 'Ű', 'u'
}

# Import the CSV file
if (Test-Path $csvFile) {
    $users = Import-Csv -Path $csvFile
} else {
    Write-Error "CSV file not found at $csvFile"
    exit
}

$i = 1
$uid = 5000
$gid = 1999

# Loop through each user in the CSV
foreach ($user in $users) {
    try {
        # Extract data from CSV
        $fullName = $user.Name
        $ouPath = $user.Path
        $title = $user.Title
        $groupName = $user.Group

        # Split full name into first and last name
        $nameParts = $fullName -split ' ', 2
        $firstName = $nameParts[1]
        $lastName = $nameParts[0]

        # Generate username from first and last name, removing Hungarian characters and converting to lowercase
        $cleanFirstName = Remove-HungarianAccents -InputString $firstName
        $cleanLastName = Remove-HungarianAccents -InputString $lastName
        $username = "$($cleanLastName).$($cleanFirstName)".ToLower()

        # Generate UserPrincipalName
        $userPrincipalName = "$username@kkk.com"

        # Check if the user already exists
        $existingUser = Get-ADUser -Filter {SamAccountName -eq $username} -ErrorAction SilentlyContinue

        if ($existingUser) {
            Write-Host "A $username felhasználó már létezik."
            continue
        }

        # Create the new AD user
        New-ADUser -Name $fullName `
                   -GivenName $firstName `
                   -Surname $lastName `
                   -SamAccountName $username `
                   -UserPrincipalName $userPrincipalName `
                   -Path $ouPath `
                   -Title $title `
                   -AccountPassword $passw `
                   -Enabled $true `
                   -ChangePasswordAtLogon $true

       Set-ADUser -Identity $Username -Add @{
            uid = $uid;
            gidNumber = $gid
            homeDirectory = "/mailboxes/$username"
        }
        $uid = $uid + 1
        
        Write-Host "A $username felhasználó sikeresen létre lett hozva a következő OU-ban: $ouPath"

        # Search for the group in the determined OU
        $groupDN = Get-ADGroup -Filter {Name -eq $groupName} -SearchBase "OU=csoportok,OU=Felhasznalok,DC=kkk,DC=com"

        if ($groupDN) {
            # Add the user to the group
            Add-ADGroupMember -Identity $groupDN -Members $username
            Write-Host "$i. A $username felhasználó hozzá lett adva a $groupName csoporthoz."
            $i = $i + 1
        } else {
            Write-Error "Group $groupName not found in $groupOU."
        }

    } catch {
        Write-Error "Error creating user $fullName : $($_.Exception.Message)"
    }
}
