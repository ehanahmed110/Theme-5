$ErrorActionPreference = "Stop"
$arFolder = "c:\Users\ML\Desktop\theme 5 new (2)\theme 5 new\theme 5\ar"

# Define replacements (Key, Value)
# Ordered by length descending will be handled by sorting the keys/array
$rawReplacements = @(
    # Hero & Banner Long Strings
    @("Get 100 AED off your order with code CYBERMONDAY and enjoy 200 AED cashback!", "احصل على خصم 100 درهم على طلبك باستخدام كود CYBERMONDAY واستمتع بـ 200 درهم كاش باك!"),
    @("Certified renewed devices - Inspected by Experts - Up to 70% cheaper than new", "أجهزة مجددة معتمدة - تم فحصها من قبل الخبراء - أرخص بنسبة تصل إلى 70% من الجديد"),
    @("ALL OUR DEVICES ARE ORIGINAL AND VERIFIED BY EXPERTS", "جميع أجهزتنا أصلية ومعتمدة من قبل الخبراء"),
    @("150,000+ CUSTOMERS TRUST OUR PLATFORM", "أكثر من 150,000 عميل يثقون بمنصتنا"),
    @(" Certified Renewed Apple iPhones", " آيفون مجدد معتمد من آبل"),
    @("Certified Renewed Apple iPhones", "آيفون مجدد معتمد من آبل"),
    @("Certified Renewed", "مجدد معتمد"),
    @("Apple iPhones", "آيفون من آبل"),
    @("Samsung Galaxy", "سامسونج جالاكسي"),
    @("What is Renewed from Revibe?", "ما المقصود بالمنتجات المجددة من ريفايب؟"),
    @("SHOP CERTIFIED RENEWED", "تسوق المنتجات المجددة المعتمدة"),
    @("CYBER MONDAY DEAL SECTION", "قسم عروض سايبر مانداي"),
    
    # Navigation & Headers
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
    @("Home", "الرئيسية"),
    
    # UI Elements & Filters
    @("See all", "عرض الكل"),
    @("Show more", "عرض المزيد"),
    @("Previous", "السابق"),
    @("Next", "التالي"),
    @("Sort By", "ترتيب حسب"),
    @("Filter", "تصفية"),
    @("Products Found", "منتج موجود"),
    @("Items per page:", "عنصر لكل صفحة:"),
    @("Min", "أدنى"),
    @("Max", "أقصى"),
    @("Brand", "العلامة التجارية"),
    @("Color", "اللون"),
    @("Storage", "سعة التخزين"),
    @("Price", "السعر"),
    @("Condition", "الحالة"),
    @("Warranty", "الضمان"),
    @("Description", "الوصف"),
    @("Specifications", "المواصفات"),
    @("Reviews", "التقييمات"),
    @("Add to Cart", "أضف إلى السلة"),
    @("Buy Now", "اشتر الآن"),
    @("View Details", "عرض التفاصيل"),
    @("Quick View", "نظرة سريعة"),
    @("Out of Stock", "نفذت الكمية"),
    
    # Features & Badges
    @("Free Delivery", "توصيل مجاني"),
    @("10 Days To Return", "10 أيام للإرجاع"),
    @("12 Months Warranty", "ضمان 12 شهر"),
    @("Buy Now, Pay Later", "اشتر الآن، ادفع لاحقاً"),
    @("New Arrivals", "وصل حديثاً"),
    @("Best Sellers", "الأكثر مبيعاً"),
    @("Discount Offers", "عروض الخصم"),
    @("vs new", "مقارنة بالجديد"),
    @("vs New", "مقارنة بالجديد"),
    @("Good", "جيد"),
    @("Excellent", "ممتاز"),
    @("Like New", "كأنه جديد"),
    @("Very Good", "جيد جداً"),
    
    # Categories & Brands
    @("Makeup", "مكياج"),
    @("Skin Care", "العناية بالبشرة"),
    @("Fragrance", "عطور"),
    @("Apple", "آبل"),
    @("Samsung", "سامسونج"),
    @("Dell", "ديل"),
    @("HP", "إتش بي"),
    @("Lenovo", "لينوفو"),
    @("Asus", "أسوس"),
    @("Sony", "سوني"),
    @("Intel", "إنتل"),
    
    # Colors
    @("Black", "أسود"),
    @("White", "أبيض"),
    @("Red", "أحمر"),
    @("Blue", "أزرق"),
    @("Purple", "بنفسجي"),
    @("Gold", "ذهبي"),
    @("Silver", "فضي"),
    @("Green", "أخضر"),
    @("Graphite", "جرافيت"),
    @("Space Black", "أسود فضائي"),
    @("Midnight", "منتصف الليل"),
    @("Starlight", "ضوء النجوم"),
    @("Pink", "وردي"),
    @("Pacific Blue", "أزرق المحيط الهادئ"),
    
    # Units & Time
    @(" GB", " جيجابايت"),
    @("1TB", "1 تيرابايت"),
    @("Days", "أيام"),
    @("Hours", "ساعات"),
    @("Mins", "دقائق"),
    @("Secs", "ثواني"),
    @("DAYS", "أيام"),
    @("HRS", "ساعات"),
    @("MINS", "دقائق"),
    @("SECS", "ثواني")
)

# Sort replacements by length of key descending to match longest strings first
$replacements = $rawReplacements | Sort-Object -Property @{Expression={$_[0].Length}} -Descending

$files = Get-ChildItem -Path $arFolder -Filter "*.html"

foreach ($file in $files) {
    Write-Host "Processing $($file.Name)..."
    # Use UTF8 explicitly
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $newContent = $content
    
    foreach ($pair in $replacements) {
        $key = $pair[0]
        $val = $pair[1]
        # Escape special regex characters in the key
        $escapedKey = [regex]::Escape($key)
        # Use Case-Sensitive Replacement (-creplace)
        $newContent = $newContent -creplace $escapedKey, $val
    }
    
    if ($newContent -ne $content) {
        [System.IO.File]::WriteAllText($file.FullName, $newContent, [System.Text.Encoding]::UTF8)
        Write-Host "  -> Updated" -ForegroundColor Green
    } else {
        Write-Host "  -> No changes" -ForegroundColor Yellow
    }
}
Write-Host "Done!"
