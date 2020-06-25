$tfplan = terraform show -json tfout.tfplan
$actions = $tfplan | jq.exe .resource_changes[].change.actions[]
$nbdelete = $actions -match 'delete' | Measure-Object | Select-Object Count
Write-Host $nbdelete.Count