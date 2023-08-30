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
$variableGroupContentUrl = "$baseUrl/distributedtask/variablegroups?api-version=7.0"
$variableGroupContentUrl
$variableGroupContent = Invoke-RestMethod -Uri $variableGroupContentUrl -Headers @{Authorization = "Basic " + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($personalAccessToken)"))} -Method Get
$variableGroupContent