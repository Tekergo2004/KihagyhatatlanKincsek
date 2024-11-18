# Domain változók
$domain = "kkk.com"
$ouk = @(@("Vezeto", "DC=kkk,DC=com"), @("IT", "DC=kkk,DC=com"), @("Alkalmazott", "DC=kkk,DC=com"), @("CEO", "OU=Vezeto,DC=kkk,DC=com"), @("IT", "OU=IT,DC=kkk,DC=com"), @("Kiado", "OU=Alkalmazott,DC=kkk,DC=com"), @("Adminisztracio", "OU=Alkalmazott,DC=kkk,DC=com"), @("Zene", "OU=Alkalmazott,DC=kkk,DC=com"), @("Marketing", "OU=Alkalmazott,DC=kkk,DC=com"), @("Csoportok", "OU=Alkalmazott,DC=kkk,DC=com"), @("Csoportok", "OU=IT,DC=kkk,DC=com"), @("Csoportok", "OU=Vezeto,DC=kkk,DC=com"))
$csoportok = @(@("Vezeto","ou=Csoportok,ou=Vezeto,dc=kkk,dc=com"), @("Kiado","ou=Csoportok,ou=Alkalmazott,dc=kkk,dc=com"), @("Adminisztracio","ou=Csoportok,ou=Alkalmazott,dc=kkk,dc=com"), @("Zene","ou=Csoportok,ou=Alkalmazott,dc=kkk,dc=com"), @("Marketing","ou=Csoportok,ou=Alkalmazott,dc=kkk,dc=com"), @("IT","ou=Csoportok,ou=IT,dc=kkk,dc=com"))

# OU-k létrehozása
foreach ($i in $ouk) {
    New-ADOrganizationalUnit -Name $i[0] -Path $i[1] -ProtectedFromAccidentalDeletion $False
}


# Csoportok létrehozása
foreach ($i in $csoportok) {
    New-ADGroup -Name $i[0] -Path $i[1] -GroupScope Global
}

Write-Host("Sikeres ou, csoport letrehozas")