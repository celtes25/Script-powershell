$localUsername  = "~\admin"
$localPassword  = ConvertTo-SecureString "Mot de passe" -AsPlainText -Force
$localCredentials  = New-Object System.Management.Automation.PSCredential($localUsername, $localPassword)

$postes="PC306A","PC306B","PC306C","PC306D","PC306E","PC306F","PC306G","PC306H","PC306I","PC306J","PC306K","PC306L","PC306M","PC306N","PC306O","PC306P","PC306Q","PC306R","PC306S","PC306T","PC306U","PC306V","PC306W","PC306X","PC306Y"
 
$postes="PC208A","PC208B","PC208C","PC208D","PC208E","PC208F","PC208G","PC208H","PC208I","PC208J","PC208K","PC208L","PC208M","PC208N","PC208O","PC208P","PC208Q","PC208R","PC208S","PC208T","PC208U","PC208V","PC208W","PC208X","PC208Y"
 
$postes="PC302A","PC302B","PC302C","PC302D","PC302E","PC302F","PC302G","PC302H","PC302I","PC302J","PC302K","PC302L","PC302M","PC302N","PC302O","PC302P","PC302Q","PC302R","PC302S","PC302T","PC302U","PC302V","PC302W","PC302X","PC302Y"

$postes="PC212A","PC212B","PC212C","PC212D","PC212E","PC212F","PC212G","PC212H","PC212I","PC212J","PC212K","PC212L","PC212M","PC212N","PC212O","PC212P","PC212Q","PC212R","PC212S","PC212T","PC212U","PC212V","PC212W","PC212X","PC212Y"


#
echo $postes | foreach {
echo "tentative de maj de la ram uefi du poste : $_"
echo "On se connecte à la session admin du poste : $_" Enter-PSSession -ComputerName $_ -Credential $localCredentials
echo "copie du fichier backup2.txt  sur le poste: $_ "

$savePath = '\\'+$_+'\C$\Temp\'
$bcdInit = 'bcdbackup2.txt'
Copy-Item -Path $bcdInit -Destination $savePath

echo "On fait un import du Bios"

Invoke-Command -ComputerName $_ -Credential $localCredentials -ScriptBlock {

$filepath = 'c:\Temp\bcdbackup2.txt'

sleep 2
#bcdedit /export c:\Temp\initial.txt
bcdedit /import $filepath /clean
sleep 2
echo "suppression de c:\Temp\bcdbackup2.txt "
rm -r $filepath
}
Exit-PSSession
}
