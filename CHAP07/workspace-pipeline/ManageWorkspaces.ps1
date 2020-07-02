$envName=$args[0]
$countws = terraform workspace list -no-color | Select-String $envName -AllMatches
if ($countws.Matches.Count -eq 0) {
    Write-Host "Create new Workspace $envName"
    terraform workspace new $envName
}else{
    Write-Host "The Workspace $envName alreay exist and is selected"
    terraform workspace select $envName
}