# Read the JSON payload from stdin
$jsonpayload = [Console]::In.ReadLine()

# Convert JSON to a string
$json = ConvertFrom-Json $jsonpayload
$environment = $json.environment


# Write-Error "Something went wrong"
# exit 1
if($environment -eq "Production"){
    $location="westeurope"
}else{
    $location="westus"
}

# Write output to stdout
Write-Output "{ ""location"" : ""$location""}"