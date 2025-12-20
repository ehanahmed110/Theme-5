$ErrorActionPreference = "Stop"
$arFolder = "c:\Users\ML\Desktop\theme 5 new (2)\theme 5 new\theme 5\ar"

$replacements = @(
    @("Menu", "القائمة"),
    @("Cyber Monday", "سايبر مانداي"),
    @("Iphones", "آيفون"),
    @("Samsungs", "سامسونج"),
    @("MacBooks", "ماك بوك"),
    @("Laptops", "لابتوب"),
    @("Ipads", "آيباد"),
    @("TVs", "تلفزيونات"),
    @("Accessories and Audio", "إكسسوارات وصوتيات"),
    @("Apple Watches", "ساعات آبل"),
    @("For Business", "للأعمال"),
    @("Revibe Express", "ريفايب إكسبرس"),
    @("What are you looking for", "ما الذي تبحث عنه"),
    @("Get 100 AED off your order with code CYBERMONDAY and enjoy 200 AED cashback!", "احصل على خصم 100 درهم على طلبك باستخدام كود CYBERMONDAY واستمتع بـ 200 درهم كاش باك!"),
    @("Free Delivery", "توصيل مجاني"),
    @("10 Days To Return", "10 أيام للإرجاع"),
    @("12 Months Warranty", "ضمان 12 شهر"),
    @("Buy Now, Pay Later", "اشتر الآن، ادفع لاحقاً"),
    @("See all", "عرض الكل"),
    @("New Arrivals", "وصل حديثاً"),
    @("Best Sellers", "الأكثر مبيعاً"),
    @("Discount Offers", "عروض الخصم"),
    @("Makeup", "مكياج"),
    @("Skin Care", "العناية بالبشرة"),
    @("Fragrance", "عطور"),
    @("Previous", "السابق"),
    @("Next", "التالي"),
    @("vs new", "مقارنة بالجديد"),
    @("vs New", "مقارنة بالجديد"),
    @("Good", "جيد"),
    @("Excellent", "ممتاز"),
    @("Like New", "كأنه جديد"),
    @("Very Good", "جيد جداً"),
    @("Sort By", "ترتيب حسب"),
    @("Filter", "تصفية"),
    @("Home", "الرئيسية"),
    @("Products Found", "منتجات وجدت"),
    @("Show more", "عرض المزيد"),
    @("Add to Cart", "أضف إلى السلة"),
    @("Buy Now", "اشتر الآن"),
    @("Price", "السعر"),
    @("Color", "اللون"),
    @("Storage", "مساحة التخزين"),
    @("Brand", "العلامة التجارية"),
    @("Condition", "الحالة"),
    @("Warranty", "الضمان"),
    @("Description", "الوصف"),
    @("Specifications", "المواصفات"),
    @("Reviews", "التقييمات"),
    @("Days", "أيام"),
    @("Hours", "ساعات"),
    @("Mins", "دقائق"),
    @("Secs", "ثواني"),
    @("DAYS", "أيام"),
    @("HRS", "ساعات"),
    @("MINS", "دقائق"),
    @("SECS", "ثواني"),
    @(" SHOP CERTIFIED RENEWED", " تسوق المنتجات المجددة المعتمدة"),
    @("What is Renewed from Revibe?", "ما المقصود بالمنتجات المجددة من ريفايب؟"),
    @(" GB", " جيجابايت")
)

$files = Get-ChildItem -Path $arFolder -Filter "*.html"

foreach ($file in $files) {
    Write-Host "Processing $($file.Name)..."
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $newContent = $content
    
    foreach ($pair in $replacements) {
        $key = $pair[0]
        $val = $pair[1]
        # Escape special regex characters in the key
        $escapedKey = [regex]::Escape($key)
        $newContent = $newContent -replace $escapedKey, $val
    }
    
    if ($newContent -ne $content) {
        [System.IO.File]::WriteAllText($file.FullName, $newContent, [System.Text.Encoding]::UTF8)
        Write-Host "Updated $($file.Name)" -ForegroundColor Green
    } else {
        Write-Host "No changes for $($file.Name)" -ForegroundColor Yellow
    }
}
