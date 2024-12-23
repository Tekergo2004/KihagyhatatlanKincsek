# Domain változók
$domain = "szeged.kkk.com"
$ouk = @(@("Felhasznalok", "DC=szeged,DC=kkk,DC=com") @("IT", "OU=Felhasznalok,DC=szeged,DC=kkk,DC=com"), @("Fiokvezeto", "OU=Felhasznalok,DC=szeged,DC=kkk,DC=com"), @("Kozonseg", "OU=Felhasznalok,DC=szeged,DC=kkk,DC=com"), @("Esemeny", "OU=Felhasznalok,DC=szeged,DC=kkk,DC=com"), @("Csoportok", "OU=Felhasznalok,DC=szeged,DC=kkk,DC=com"))
$csoportok = @(@("Fiokvezeto","ou=Csoportok,OU=Felhasznalok,dc=szeged,dc=kkk,dc=com"), @("Kozonseg","ou=Csoportok,OU=Felhasznalok,dc=szeged,dc=kkk,dc=com"), @("Esemeny","ou=Csoportok,OU=Felhasznalok,dc=szeged,dc=kkk,dc=com"), @("IT","ou=Csoportok,OU=Felhasznalok,dc=szeged,dc=kkk,dc=com"))

# OU-k létrehozása
foreach ($i in $ouk) {
    New-ADOrganizationalUnit -Name $i[0] -Path $i[1]
}


# Csoportok létrehozása
foreach ($i in $ouk) {
    New-ADGroup -Name $i[0] -Path $i[1] -GroupScope Global
}
