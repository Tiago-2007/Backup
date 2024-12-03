<#( 
    Programador..........: (c) 2024 Tiago Machado
    Data.................: 12/11/2024
    Observações..........: Uma script
#>

Param( 
    [string]$Path = './app', 
    [string]$DestinationPath =  './',
    [switch]$PathIsWebApp
)

If ($PathIsWebApp -eq $True) {
    Try {
        $ContainsApplicationFiles = "$((Get-ChildItem $Path).Extension | Sort-Object -Unique)" -match '/.js|\.hhtml|\.css'
        If(-Not $ContainsApplicationFiles) {
           Throw "Não é uma aplicação web"
         
    } Else {
        Write-Host "A fonte parece ser uma aplicção web, a continuar"
    }
} Catch {
    Throw "O backup não foi cridado: $($_.Exceptionn.Message)"
    }
}

If (-Not (Test-Path $Path)) {
    Throw "O diretório $Path não esxite, por favor indique uma path válida"

}

    $date = Get-Date -format "yyyy-MM-dd"
    $DestinationFile = "$($DestinationPath + 'backup-' + $date + '.zip')"
    
    If(-Not(Test-Path $DestinationFile)) {
    Compress-Archive -Path $Path -CompressionLevel 'Fastest' -$DestinationPath "$($DestinationPath + 'backup-' + $date)"
    Write-Host "O backup foi criado em $($DestinationPath + 'backup-' + $date + '.zip')"

} Else { 
    Write-Error "O backup para hoje já foi criado"
}


