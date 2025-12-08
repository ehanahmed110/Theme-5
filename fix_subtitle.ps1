$ErrorActionPreference = "Stop"
$arFolder = "c:\Users\ML\Desktop\theme 5 new (2)\theme 5 new\theme 5\ar"
$files = Get-ChildItem -Path $arFolder -Filter "*.html"

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Regex replace for multi-line subtitle
    $newContent = $content -replace "Certified renewed devices - Inspected by Experts - Up to 70%\s+cheaper than new", "أجهزة مجددة معتمدة - تم فحصها من قبل الخبراء - أرخص بنسبة تصل إلى 70% من الجديد"
    
    if ($newContent -ne $content) {
        [System.IO.File]::WriteAllText($file.FullName, $newContent, [System.Text.Encoding]::UTF8)
        Write-Host "Fixed subtitle in $($file.Name)"
    }
}
