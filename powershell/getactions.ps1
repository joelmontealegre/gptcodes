param (
    [Parameter(Mandatory = $true)]
    [string]$JsonFilePath
)

# Read the JSON data from the specified file
$jsonData = Get-Content -Path $JsonFilePath | Out-String

# Parse the JSON data
$jsonObject = $jsonData | ConvertFrom-Json

# Function to recursively extract keys from objects
function Get-Keys($obj) {
    foreach ($property in $obj.PSObject.Properties) {
        if ($property.Name -eq "actions") {
            $property.Value.PSObject.Properties.Name
        }
        elseif ($property.Value -is [System.Management.Automation.PSCustomObject]) {
            Get-Keys $property.Value
        }
    }
}

# Call the function to extract keys under "actions"
$keysUnderActions = Get-Keys $jsonObject

# Output the keys
$keysUnderActions
