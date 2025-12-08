# Arabic Translation PowerShell Script
$arFolder = "c:\Users\ML\Desktop\theme 5 new (2)\theme 5 new\theme 5\ar"

# Key translations
$translations = @{
    "See all" = "عرض الكل"
    " vs new" = " مقارنة بالجديد"
    " vs New" = " مقارنة بالجديد"
    "New Arrivals" = "وصل حديثاً"
    "Best Sellers" = "الأكثر مبيعاً"
    "Discount Offers" = "عروض الخصم"
    "Previous" = "السابق"
    "Next" = "التالي"
    " / Good" = " / جيد"
    " / Excellent" = " / ممتاز"
    " / Very Good" = " / جيد جداً"
    " / Like New" = " / كأنه جديد"
    " GB" = " جيجابايت"
}

Get-ChildItem -Path $arFolder -Filter *.html | ForEach-Object {
    $file = $_.FullName
    Write-Host "Processing: $($_.Name)"
    
    $content = Get-Content -Path $file -Encoding UTF8 -Raw
    $originalContent = $content
    
    foreach ($key in $translations.Keys) {
        $content = $content -replace [regex]::Escape($key), $translations[$key]
    }
    
    if ($content -ne $originalContent) {
        $content | Set-Content -Path $file -Encoding UTF8 -NoNewline
        Write-Host "  ✓ Translated" -ForegroundColor Green
    } else {
        Write-Host "  - No changes" -ForegroundColor Yellow
    }
}

Write-Host "`nTranslation complete!" -ForegroundColor Cyan
