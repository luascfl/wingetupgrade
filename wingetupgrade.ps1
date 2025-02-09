# Announce the start
Write-Host "Buscando pacotes com atualizações disponíveis..." -ForegroundColor Cyan

# Retrieve available updates as plain text
$wingetOutput = winget upgrade

# Define packages to exclude
$excludedPackages = @("Microsoft.Edge")

# Initialize an array to hold package identifiers
$packages = @()

# Flag to skip header lines
$headerSkipped = $false

# Process the winget output line by line
$wingetOutput | ForEach-Object {
    $line = $_.Trim()

    # Skip until after the header
    if (-not $headerSkipped) {
        if ($line -like '---*') {
            # Found the separator line after headers
            $headerSkipped = $true
        }
        return
    }

    # Use regular expression to split the line into columns
    $regex = '^(.*?)\s{2,}(.*?)\s{2,}(.*?)\s{2,}(.*?)\s{2,}(.*?)$'

    if ($line -match $regex) {
        $packageName = $matches[1].Trim()
        $packageId = $matches[2].Trim()
        $installedVersion = $matches[3].Trim()
        $availableVersion = $matches[4].Trim()
        $source = $matches[5].Trim()

        # Remove version from packageId if present
        $packageId = $packageId -replace '\s+\d+.*$', ''

        # Debug output
        Write-Host "Debug: PackageName='$packageName', PackageId='$packageId'"

        # Check if the package is in the exclusion list
        if ($excludedPackages -notcontains $packageId) {
            # Add the package to the array
            $packages += New-Object psobject -Property @{
                Name = $packageName
                PackageIdentifier = $packageId
                InstalledVersion = $installedVersion
                AvailableVersion = $availableVersion
                Source = $source
            }
        }
    }
}

# Check if there are packages to update
if ($packages.Count -eq 0) {
    Write-Host "Nenhum pacote encontrado para atualização (exceto os excluídos)." -ForegroundColor Yellow
} else {
    Write-Host "Os seguintes pacotes serão atualizados:" -ForegroundColor Green
    $packages | ForEach-Object { Write-Host "- $($_.Name) ($($_.PackageIdentifier))" }

    foreach ($package in $packages) {
        Write-Host "Atualizando pacote: $($package.Name) ($($package.PackageIdentifier))" -ForegroundColor Green
        try {
            winget upgrade --id $($package.PackageIdentifier) --accept-source-agreements --accept-package-agreements -e
        } catch {
            Write-Host "Erro ao atualizar o pacote $($package.Name): $_" -ForegroundColor Red
        }
    }

    Write-Host "Todas as atualizações concluídas!" -ForegroundColor Green
}