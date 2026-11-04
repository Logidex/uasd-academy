param(
    [switch]$Recrear,
    [switch]$Verificar
)
$ErrorActionPreference = 'Stop'
$archivo = Join-Path $PSScriptRoot 'inicializar.py'
$argumentos = @($archivo)
if ($Recrear) { $argumentos += '--recrear' }
if ($Verificar) { $argumentos += '--verificar' }
& python @argumentos
if ($LASTEXITCODE -ne 0) {
    throw 'Fallo la inicializacion. Se conservo la base original.'
}
