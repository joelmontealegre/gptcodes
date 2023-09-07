param (
    [string]$jsonFilePath
)

# Function to list keys under "actions" node and its nested "actions" nodes
function ListActionKeys($node, $path) {
    foreach ($property in $node.PSObject.Properties) {
        if ($property.Name -eq "actions") {
            foreach ($actionKey in $property.Value.PSObject.Properties.Name) {
                Write-Host "Key under '$path/actions': $actionKey"
                ListActionKeys $property.Value.$actionKey "$path/actions/$actionKey"
            }
        }
    }
}

# Read JSON data from the file
$jsonData = Get-Content -Path $jsonFilePath | Out-String | ConvertFrom-Json

# Call the function to list keys under "actions" nodes
ListActionKeys $jsonData "root"
