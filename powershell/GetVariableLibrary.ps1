param(
    [string]$organization = 'sphereware',
    [string]$project = 'Spherewere%20DevOps%20Projects',
    [string]$variableGroupId,
    [string]$personalAccessToken,
    [string]$outputFile = "test.csv"
)

# Base URL for Azure DevOps REST APIls
$baseUrl = "https://dev.azure.com/$organization/$project/_apis"
$baseUrl

# Get variable group content
$variableGroupContentUrl = "$baseUrl/distributedtask/variablegroups/$variableGroupId" + "/?api-version=7.1-preview.1"
$variableGroupContentUrl
$variableGroupContent = Invoke-RestMethod -Uri $variableGroupContentUrl -Headers @{Authorization = "Basic " + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($personalAccessToken)"))} -Method Get
$variableGroupContent

# Extract variables from the content
$variables = $variableGroupContent.variables | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name

# Create an array to hold variable data
$variableData = @()

foreach ($variableName in $variables) {
    $variableValue = $variableGroupContent.variables."$variableName".value

    $variableData += [PSCustomObject]@{
        Name = $variableName
        Value = $variableValue
    }
}

# Export variable data to a CSV file
$variableData | Export-Csv -Path $outputFile -NoTypeInformation

Write-Host "Variables from '$variableGroupName' variable group exported to '$outputFile'"