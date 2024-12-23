# Domain változók
$domain = "debrecen.kkk.com"
$ouk = @(@("Felhasznalok", "DC=debrecen,DC=kkk,DC=com"), @("IT", "OU=Felhasznalok,DC=debrecen,DC=kkk,DC=com"), @("Alkalmazott", "OU=Felhasznalok,DC=debrecen,DC=kkk,DC=com"), @("Fiokvezeto", "OU=Felhasznalok,DC=debrecen,DC=kkk,DC=com"), @("Tehetseg", "OU=Felhasznalok,,DC=debrecen,DC=kkk,DC=com"), @("Kiado", "OU=Felhasznalok,DC=debrecen,DC=kkk,DC=com"), @("Csoportok", "OU=Felhasznalok,,DC=debrecen,DC=kkk,DC=com"))
$csoportok = @(@("Fiokvezeto","ou=Csoportok,ou=Felhasznalok,dc=debrecen,dc=kkk,dc=com"), @("Tehetseg","ou=Csoportok,ou=Felhasznalok,dc=debrecen,dc=kkk,dc=com"), @("Kiado","ou=Csoportok,ou=Felhasznalok,dc=debrecen,dc=kkk,dc=com"), @("IT","ou=Csoportok,ou=Felhasznalok,dc=debrecen,dc=kkk,dc=com"))

# OU-k létrehozása
foreach ($i in $ouk) {
    New-ADOrganizationalUnit -Name $i[0] -Path $i[1]
}


# Csoportok létrehozása
foreach ($i in $ouk) {
    New-ADGroup -Name $i[0] -Path $i[1] -GroupScope Global
}
