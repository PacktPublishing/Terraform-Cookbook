$apiToken = $args[0]  #API TOKEN
$headers = @{ }
$headers["Authorization"] = "Bearer  $apiToken"
$headers["Content-Type"] = "application/vnd.api+json"
$uriWorkspaces = "https://app.terraform.io/api/v2/runs"

$json = Get-Content("run.json")
Invoke-RestMethod -Uri $uriWorkspaces -Body $json -Headers $headers -Method Post





