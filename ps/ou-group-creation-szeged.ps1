# Domain változók
$domain = "szeged.kkk.com"
$ouk = @(@("Vezeto", "DC=szeged,DC=kkk,DC=com"), @("IT", "DC=szeged,DC=kkk,DC=com"), @("Alkalmazott", "DC=szeged,DC=kkk,DC=com"), @("Fiokvezeto", "OU=Vezeto,DC=szeged,DC=kkk,DC=com"), @("IT", "OU=IT,DC=szeged,DC=kkk,DC=com"), @("Kozonseg", "OU=Alkalmazott,DC=szeged,DC=kkk,DC=com"), @("Esemeny", "OU=Alkalmazott,DC=szeged,DC=kkk,DC=com"), @("Csoportok", "OU=Alkalmazott,DC=szeged,DC=kkk,DC=com"), @("Csoportok", "OU=IT,DC=szeged,DC=kkk,DC=com"), , @("Csoportok", "OU=Vezeto,DC=szeged,DC=kkk,DC=com")
$csoportok = @(@("Vezeto","ou=Csoportok,ou=Vezeto,dc=kkk,dc=com"), @("Kiado","ou=Csoportok,ou=Alkalmazott,dc=kkk,dc=com"), @("Adminisztracio","ou=Csoportok,ou=Alkalmazott,dc=kkk,dc=com"), @("Zene","ou=Csoportok,ou=Alkalmazott,dc=kkk,dc=com"), @("Marketing","ou=Csoportok,ou=Alkalmazott,dc=kkk,dc=com"), @("IT","ou=Csoportok,ou=IT,dc=kkk,dc=com"))

# OU-k létrehozása
foreach ($i in $ouk) {
    New-ADOrganizationalUnit -Name $i[0] -Path $i[1]
}


# Csoportok létrehozása
foreach ($i in $ouk) {
    New-ADGroup -Name $i[0] -Path $i[1] -GroupScope Global
}