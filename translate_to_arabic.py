#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import re

# Comprehensive translation dictionary
translations = {
    # Navigation
    "Menu": "القائمة",
    "Cyber Monday": "سايبر مانداي",
    "Iphones": "آيفون",
    "Samsungs": "سامسونج",
    "MacBooks": "ماك بوك",
    "MacBook": "ماك بوك",
    "Laptops": "لابتوب",
    "Laptop": "لابتوب",
    "Ipads": "آيباد",
    "iPads": "آيباد",
    "iPad": "آيباد",
    "TVs": "تلفزيونات",
    "Accessories and Audio": "إكسسوارات وصوتيات",
    "Apple Watches": "ساعات آبل",
    "Apple Watch": "ساعات آبل",
    "For Business": "للأعمال",
    "Revibe Express": "ريفايب إكسبرس",
    
    # Search & UI
    "What are you looking for": "ما الذي تبحث عنه",
    
    # Top Banner
    "Get 100 AED off your order with code CYBERMONDAY and enjoy 200 AED cashback!": "احصل على خصم 100 درهم على طلبك باستخدام كود CYBERMONDAY واستمتع بـ 200 درهم كاش باك!",  
    
    # Key Features
    "Free Delivery": "توصيل مجاني",
    "10 Days To Return": "10 أيام للإرجاع",
    "12 Months Warranty": "ضمان 12 شهر",
    "Buy Now, Pay Later": "اشتر الآن، ادفع لاحقاً",
    
    # Section Headers
    "SHOP CERTIFIED RENEWED": "تسوق المنتجات المجددة المعتمدة",
    "See all": "عرض الكل",
    "CYBER MONDAY DEAL SECTION": "قسم عروض سايبر مانداي",
    "CERTIFIED RENEWED IPHONES": "آيفون مجدد معتمد",
    "CERTIFIED RENEWED LAPTOPS": "لابتوب مجددمعتمد",
    "CERTIFIED RENEWED": "منتجات مجددة معتمدة",
    
    # Product Filters & Details
    "Brand": "العلامة التجارية",
    "Color": "اللون",
    "Storage": "السعة التخزينية",
    "Price": "السعر",
    " GB": " جيجابايت",
    "Min": "الحد الأدنى",
    "Max": "الحد الأقصى",
    "Apple": "آبل",
    "Dell": "ديل",
    "HP": "اتش بي",
    "Lenovo": "لينوفو",
    "Asus": "أسوس",
    "Generation": "الجيل",
    "Intel i5": "إنتل i5",
    "Intel i7": "إنتل i7",
    "Intel i9": "إنتل i9",
    "Screen Size": "حجم الشاشة",
    "Products Found": "منتج موجود",
    "Items per page:": "عدد العناصر في الصفحة:",
    
    # Product Details
    "What is Renewed from Revibe?": "ما المقصود بـ المنتجات المجددة من ريفايب؟",
    
    # Conditions
    " / Good": " / جيد",
    " / Excellent": " / ممتاز",
    " / Very Good": " / جيد جداً",
    " / Like New": " / كأنه جديد",
    
    # Colors
    "Graphite": "جرافيت",
    "Space Black": "أسود فضائي",
    "Black": "أسود",
    "White": "أبيض",
    "Silver": "فضي",
    "Gold": "ذهبي",
    "Blue": "أزرق",
    "Red": "أحمر",
    "Green": "أخضر",
    "Pacific Blue": "أزرق المحيط الهادئ",
    "Pink": "وردي",
    "Purple": "بنفسجي",
    
    # Hero Banners
    "Certified Renewed": "مجدد معتمد",
    "Apple iPhones": "آيفون من آبل",
    "Samsung Galaxy": "سامسونج جالاكسي",
    "Certified renewed devices - Inspected by Experts - Up to 70% cheaper than new": "أجهزة مجددة معتمدة - فحصت من قبل الخبراء - أرخص بنسبة تصل إلى 70% من الجديدة",
    
    # Verified Section
    "ALL OUR DEVICES ARE ORIGINAL AND VERIFIED BY EXPERTS": "جميع أجهزتنا أصلية ومعتمدة من قبل الخبراء",
    "Risk Free": "خالي من المخاطر",
    "10 days to return in case of any issue": "10 أيام للإرجاع في حالة أي مشكلة",
    "Verified Devices- One by One": "أجهزة مفحوصة - واحداً تلو الآخر",
    "50 points quality check on all aspects of the device (screen, battery, speed, durability...)": "فحص جودة من 50 نقطة على جميع جوانب الجهاز (الشاشة، البطارية، السرعة، المتانة...)",
    "Only from the best": "فقط من الأفضل",
    "Rigorous screening process - Only 1 out of 4 suppliers is accepted on Revibe.": "عملية فحص صارمة - يتم قبول مورد واحد فقط من 4 على ريفايب",
    "Always here for you": "نحن هنا دائماً من أجلك",
    "Proactive customer service to answer and solve any concern": "خدمة عملاء استباقية للإجابة وحل أي مشكلة",
    
    # Customer Trust
    "150,000+ CUSTOMERS TRUST OUR PLATFORM": "أكثر من 150,000 عميل يثقون بمنصتنا",
    "Join the Revibe community": "انضم إلى مجتمع ريفايب",
    
    # Countdown Labels
    "DAYS": "أيام",
    "HRS": "ساعات",
    "MINS": "دقائق",
    "SECS": "ثواني",
    "Days": "أيام",
    "Hrs": "ساعات",
    "Mins": "دقائق",
    "Secs": "ثواني",
    
    # Badges
    " vs new": " مقارنة بالجديد",
    " vs New": " مقارنة بالجديد",
    
    # Dropdown
    "New Arrivals": "وصل حديثاً",
    "Best Sellers": "الأكثر مبيعاً",
    "Discount Offers": "عروض الخصم",
    "Makeup": "مكياج",
    "Skin Care": "العناية بالبشرة",
    "Fragrance": "عطور",
    
    # Carousel
    "Previous": "السابق",
    "Next": "التالي",
    
    # Footer
    "About Us": "معلومات عنا",
    "About Revibe": "حول ريفايب",
    "Shop": "المتجر",
    "Our Blog": "مدونتنا",
    "Become A Seller": "كن بائعاً",
    "Revibe Reviews": "تقييمات ريفايب",
    "Informations": "معلومات",
    "Help Center & FAQ": "مركز المساعدة والأسئلة الشائعة",
    "Contact": "اتصل بنا",
    "Terms & Conditions": "الشروط والأحكام",
    "Legal Policy": "السياسة القانونية",
    "My Account": "حسابي",
    "Track Your Order": "تتبع طلبك",
    "Raise A Claim": "رفع شكوى",
    "Track Your Claim": "تتبع شكواك",
    "Sell your Device": "بيع جهازك",
    "Contact Us": "اتصل بنا",
    "Monday to Friday 9:30 am to 5:30 pm": "الاثنين إلى الجمعة من 9:30 صباحاً إلى 5:30 مساءً",
    "(Reply within 1 business day)": "(الرد خلال يوم عمل واحد)",
    "Chat with Us": "تحدث معنا",
    "© 2025 Revibe All Rights Reserved": "© 2025 ريفايب جميع الحقوق محفوظة",
    
    # Additional common text
    "Show more": "عرض المزيد",
    "Filter": "تصفية",
    "Sort by": "الترتيب حسب",
    "Add to Cart": "أضف إلى السلة",
    "Buy Now": "اشتر الآن",
    "Learn More": "اعرف المزيد",
    "Read More": "اقرأ المزيد",
    "View Details": "عرض التفاصيل",
    
    # Category names
    "Samsung": "Samsung",
    "iPhone": "iPhone",
}

def translate_file(filepath):
    """Translate a single HTML file"""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original_content = content
    
    # Apply translations (sorted by length descending to avoid partial replacements)
    for english, arabic in sorted(translations.items(), key=lambda x: len(x[0]), reverse=True):
        content = content.replace(english, arabic)
    
    # Write back only if changed
    if content != original_content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        return True
    return False

def main():
    ar_folder = r"c:\Users\ML\Desktop\theme 5 new (2)\theme 5 new\theme 5\ar"
    
    html_files = [f for f in os.listdir(ar_folder) if f.endswith('.html')]
    
    print(f"Found {len(html_files)} HTML files to translate")
    print("-" * 50)
    
    translated_count = 0
    for html_file in html_files:
        filepath = os.path.join(ar_folder, html_file)
        if translate_file(filepath):
            print(f"✓ Translated: {html_file}")
            translated_count += 1
        else:
            print(f"- No changes: {html_file}")
    
    print("-" * 50)
    print(f"Completed! {translated_count} files translated")

if __name__ == "__main__":
    main()
