function KPS-Dir{
    param([String]$name,[String]$root)
    if($root.Length -eq 0){
        .\KPScript.exe -c:AddEntry O:\Passwords\Caduceus.kdbx -pw:$dbpwd -Title:'test' -GroupPath:"Clients/$name"
    }else{
        .\KPScript.exe -c:AddEntry O:\Passwords\Caduceus.kdbx -pw:$dbpwd -Title:'test' -GroupPath:"Clients/$root/$name"
    }
}
$file = Get-Content C:\Users\moss\Documents\Dev\clients.txt
Set-Location -Path "C:\Program Files (x86)\KeePass Password Safe 2"
foreach ($name in $file){
    if($name.length -eq 1){
        #remember name as $rootdir
        $rootdir = $name
    }
    if(!$name.Contains('.') ){
        if($name -eq $rootdir){
            KPS-Dir -name $name -root ""
        }else{
            KPS-Dir -name $name -root $rootdir
        }
    }
}