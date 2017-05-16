#localuser modification
$user = set-localuser -name administrator -Password $pwd -AccountNeverExpires -passwordneverexpires
add-localgroupmember -group administrators -member $user

#join domain
Add-Computer -DomainName $domain -Credential $credential

#prompt for credentials
$credential = get-credential -message "Password for system" -username "moss"

#one line to unninstall a list of software (useful for getting rid of OEM bloatware)
cat .\programssort.txt | foreach{$filter = "Name = '"+ $_+"'"; $app = Get-WMIobject -class Win32_Product -filter $filter; $app.uninstall() }
#map a drive
New-PSDrive -Persist -Name Z -PSProvider FileSystem -Root $folder

#set active hours registry values
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings -Name ActiveHoursStart -Value 8
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings -Name ActiveHoursEnd -Value 20

#enable .net3
enable-WindowsOptionalFeature -Online -PackageName netfx3

#run a program once on next boot
$exePath = 'C:\Temp\update.exe'
$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
Set-ItemProperty $RunOnceKey "NextRun" ($exePath)
