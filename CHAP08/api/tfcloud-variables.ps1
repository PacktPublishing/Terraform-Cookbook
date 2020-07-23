$apiToken = $args[0]  #API TOKEN
$worspaceId = $args[1] # WORKSPACE ID
$headers = @{ }
$headers["Authorization"] = "Bearer  $apiToken"
$headers["Content-Type"] = "application/vnd.api+json"
$uriVariables = "https://app.terraform.io/api/v2/workspaces/$worspaceId/vars"
try
{
    $json = Get-Content("variables.json") | ConvertFrom-Json
    $varList = $json.vars

    foreach ($var in $varList)
    {
        $varjson = $var | ConvertTo-Json
        Invoke-RestMethod -Uri $uriVariables -Body $varjson -Headers $headers -Method Post
    }
}
Catch
{
    Write-Host $_.Exception
}





