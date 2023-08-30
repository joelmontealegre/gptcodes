param (
    [string]$YamlFilePath = '.\sample.yaml',
    [string]$PropertyPath = 'address-street'
)

# Read the YAML content
$yamlContent = Get-Content -Path $YamlFilePath -Raw

# Parse the YAML content
$yamlData = ConvertFrom-Yaml $yamlContent
$jsonData = $yamlData | ConvertTo-Json
$parsedObject = ConvertFrom-Json $jsonData

$propertyKeys = $PropertyPath -split '\s*-\s*'
$currentObject = $parsedObject

foreach ($part in $propertyKeys) {
   
    $currentObject = $currentObject.$part

}

return $currentObject | ConvertTo-Json




