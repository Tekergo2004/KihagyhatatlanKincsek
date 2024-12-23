# Domain változók
$domain = "kkk.com"
$ouk = @(@("Felhasznalok", "DC=kkk,DC=com"),@("Vezeto", "OU=Felhasznalok,DC=kkk,DC=com"), @("IT", "OU=Felhasznalok,DC=kkk,DC=com"), @("Vezeto", "OU=Felhasznalok,DC=kkk,DC=com"), @("Kiado", "OU=Felhasznalok,DC=kkk,DC=com"), @("Adminisztracio", "OU=Felhasznalok,DC=kkk,DC=com"), @("Zene", "OU=Felhasznalok,DC=kkk,DC=com"), @("Marketing", "OU=Felhasznalok,DC=kkk,DC=com"), @("Csoportok", "OU=Felhasznalok,DC=kkk,DC=com"))
$csoportok = @(@("Vezeto","ou=Csoportok,ou=Felhasznalok,dc=kkk,dc=com"), @("Kiado","ou=Csoportok,ou=Felhasznalok,dc=kkk,dc=com"), @("Adminisztracio","ou=Csoportok,ou=Felhasznalok,dc=kkk,dc=com"), @("Zene","ou=Csoportok,ou=Felhasznalok,dc=kkk,dc=com"), @("Marketing","ou=Csoportok,ou=Felhasznalok,dc=kkk,dc=com"), @("IT","ou=Csoportok,ou=Felhasznalok,dc=kkk,dc=com"))

# OU-k létrehozása
foreach ($i in $ouk) {
    New-ADOrganizationalUnit -Name $i[0] -Path $i[1] -ProtectedFromAccidentalDeletion $False
}


# Csoportok létrehozása
foreach ($i in $csoportok) {
    New-ADGroup -Name $i[0] -Path $i[1] -GroupScope Global
}

Write-Host("Sikeres ou, csoport letrehozas")
