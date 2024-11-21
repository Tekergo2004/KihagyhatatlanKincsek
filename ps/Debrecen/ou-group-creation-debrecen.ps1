# Domain változók
$domain = "debrecen.kkk.com"
$ouk = @(@("Vezeto", "DC=debrecen,DC=kkk,DC=com"), @("IT", "DC=debrecen,DC=kkk,DC=com"), @("Alkalmazott", "DC=debrecen,DC=kkk,DC=com"), @("Fiokvezeto", "OU=Vezeto,DC=debrecen,DC=kkk,DC=com"), @("IT", "OU=IT,DC=debrecen,DC=kkk,DC=com"), @("Tehetseg", "OU=Alkalmazott,DC=debrecen,DC=kkk,DC=com"), @("Kiado", "OU=Alkalmazott,DC=debrecen,DC=kkk,DC=com"), @("Csoportok", "OU=Alkalmazott,DC=debrecen,DC=kkk,DC=com"), @("Csoportok", "OU=IT,DC=debrecen,DC=kkk,DC=com"), @("Csoportok", "OU=Vezeto,DC=debrecen,DC=kkk,DC=com"))
$csoportok = @(@("Fiokvezeto","ou=Csoportok,ou=Vezeto,dc=debrecen,dc=kkk,dc=com"), @("Tehetseg","ou=Csoportok,ou=Alkalmazott,dc=debrecen,dc=kkk,dc=com"), @("Kiado","ou=Csoportok,ou=Alkalmazott,dc=debrecen,dc=kkk,dc=com"), @("IT","ou=Csoportok,ou=IT,dc=debrecen,dc=kkk,dc=com"))

# OU-k létrehozása
foreach ($i in $ouk) {
    New-ADOrganizationalUnit -Name $i[0] -Path $i[1]
}


# Csoportok létrehozása
foreach ($i in $ouk) {
    New-ADGroup -Name $i[0] -Path $i[1] -GroupScope Global
}