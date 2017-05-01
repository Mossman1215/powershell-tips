#localuser modification
set-localuser -name administrator -Password $pwd -AccountNeverExpires
Set-localgroup -name administrators $username

#join domain
Add-Computer -DomainName $domain -Credential $credential

#prompt for credentials
$credential = get-credential -message "Password for system" -username "moss"

#one line to unninstall a list of software (useful for getting rid of OEM bloatware)
cat .\programssort.txt | foreach{$filter = "Name = '"+ $_+"'"; $app = Get-WMIobject -class Win32_Product -filter $filter; $app.uninstall() }
#map a drive
New-PSDrive -Persist -Name Z -PSProvider FileSystem -Root $folder
