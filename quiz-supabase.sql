-- HTML quiz savollari uchun jadval (Supabase SQL Editor da bir marta ishga tushiring)

create table if not exists public.quiz_questions (
    id bigserial primary key,
    category text not null,
    question text not null,
    options text[] not null,
    answer int not null check (answer >= 0),
    explain text
);

alter table public.quiz_questions enable row level security;

drop policy if exists "quiz read" on public.quiz_questions;
create policy "quiz read" on public.quiz_questions
    for select to anon, authenticated
    using (true);

-- Qayta to‘ldirish kerak bo‘lsa, avval quyidagini ishga tushiring:
-- truncate table public.quiz_questions restart identity;

insert into public.quiz_questions (category, question, options, answer, explain) values
-- Asosiy tuzilma
('Asosiy tuzilma', 'Hujjat boshida qaysi satr yoziladi?', array['<html>','<!DOCTYPE html>','<head>','<body>'], 1, 'DOCTYPE brauzerga hujjat HTML5 ekanini bildiradi.'),
('Asosiy tuzilma', 'Sahifa tilini qaysi atribut bilan ko‘rsatamiz?', array['<html charset>','<html lang="uz">','<meta lang>','<body language>'], 1, 'lang atributi html tegiga yoziladi.'),
('Asosiy tuzilma', 'Belgilar kodirovkasini qaysi meta teg bilan beramiz?', array['<meta charset="UTF-8">','<meta name="charset">','<charset utf8>','<meta encoding>'], 0, 'meta charset="UTF-8" kodirovkani belgilaydi.'),
('Asosiy tuzilma', 'Brauzer yorlig‘ida ko‘rinadigan sarlavha qaysi teg ichida yoziladi?', array['<head>','<title>','<h1>','<name>'], 1, 'title head ichida yoziladi va yorliqda ko‘rinadi.'),
('Asosiy tuzilma', 'HTML kodda izoh qanday yoziladi?', array['// izoh','# izoh','<!-- izoh -->','/* izoh */'], 2, 'HTML izohi <!-- --> ichida yoziladi. /* */ CSS da ishlatiladi.'),
('Asosiy tuzilma', 'meta viewport nima uchun kerak?', array['Rangni o‘zgartiradi','Mobil qurilmada sahifa kengligini moslaydi','Rasmni yuklaydi','Sahifani yopadi'], 1, 'viewport sahifani telefon ekraniga moslaydi.'),
('Asosiy tuzilma', 'Hujjatning ildiz (asosiy) tegi qaysi?', array['<body>','<html>','<head>','<main>'], 1, 'Barcha kontent html tegi ichida bo‘ladi.'),
('Asosiy tuzilma', 'Ko‘rinadigan kontent qaysi teg ichida yoziladi?', array['<head>','<meta>','<body>','<title>'], 2, 'Matn, rasm va linklar body ichida bo‘ladi.'),
('Asosiy tuzilma', 'Metama’lumotlar qaysi bo‘limda yoziladi?', array['<body>','<head>','<footer>','<section>'], 1, 'meta, title va boshqa servis ma’lumotlari head ichida.'),
('Asosiy tuzilma', 'Eng ko‘p ishlatiladigan kodirovka qaysi?', array['ASCII','UTF-8','Windows-1251','KOI8'], 1, 'UTF-8 o‘zbekcha harflarni ham to‘g‘ri ko‘rsatadi.'),
('Asosiy tuzilma', 'HTML fayl kengaytmasi qaysi?', array['.htm.txt','.html','.hmtl','.web'], 1, 'To‘g‘ri kengaytma .html.'),
('Asosiy tuzilma', 'Teg nomlari katta-kichik harfga bog‘liqmi?', array['Har doim farq qiladi','Teglar uchun farq qilmaydi','Faqat h1 katta harfda','Faqat title da'], 1, 'Teglar katta-kichik harfga sezgir emas, lekin kichik harfda yozish tavsiya etiladi.'),
('Asosiy tuzilma', 'Ichma-ich teglar qanday yopiladi?', array['Ochilgan tartibda','Teskari tartibda','Istalgan tartibda','Yopilmaydi'], 1, 'Oxirgi ochilgan teg birinchi bo‘lib yopiladi.'),
('Asosiy tuzilma', 'Atributlar qayerda yoziladi?', array['Yopuvchi tegda','Ochuvchi tegning ichida','Matn ichida','Faqat CSS da'], 1, 'Atributlar ochuvchi tegda yoziladi: <a href="...">.'),

-- Sarlavhalar va matn
('Sarlavhalar va matn', 'Eng katta sarlavha qaysi teg?', array['h6','h1','h3','title'], 1, 'h1 eng katta, h6 eng kichik sarlavha.'),
('Sarlavhalar va matn', 'Eng kichik sarlavha qaysi teg?', array['h1','h3','h6','hr'], 2, 'h6 — eng kichik sarlavha darajasi.'),
('Sarlavhalar va matn', 'Uchinchi darajali sarlavha qaysi teg?', array['h3','h2','h4','h5'], 0, 'h1 — birinchi, h2 — ikkinchi, h3 — uchinchi daraja.'),
('Sarlavhalar va matn', 'Odatda bitta sahifada nechta h1 bo‘ladi?', array['Hech qachon','Bitta','Ikkita','Har bir bo‘limda beshtadan'], 1, 'Asosiy sarlavha bitta h1 bo‘ladi, qolganlari h2–h6.'),
('Sarlavhalar va matn', 'Paragraf (matn bloki) yaratadigan teg qaysi?', array['p','br','hr','li'], 0, 'p — paragraf tegi.'),
('Sarlavhalar va matn', 'Satrni uzib, keyingi qatorga o‘tkazadigan teg qaysi?', array['hr','p','br','em'], 2, 'br — satr uzilishi, juftlanmaydigan teg.'),
('Sarlavhalar va matn', 'Sahifada gorizontal chiziq chizadigan teg qaysi?', array['br','hr','img','ul'], 1, 'hr — mavzular orasiga qo‘yiladigan gorizontal chiziq.'),
('Sarlavhalar va matn', 'Matnni sariq fon bilan ajratib ko‘rsatadigan teg qaysi?', array['mark','del','sub','em'], 0, 'mark — muhim matnni ajratib ko‘rsatadi.'),
('Sarlavhalar va matn', 'h2 qaysi daraja sarlavhasi?', array['Birinchi','Ikkinchi','Uchinchi','To‘rtinchi'], 1, 'h2 — ikkinchi daraja, bo‘limlar uchun ko‘p ishlatiladi.'),
('Sarlavhalar va matn', 'h4 qaysi daraja sarlavhasi?', array['To‘rtinchi','Ikkinchi','Beshinchi','Birinchi'], 0, 'h4 — to‘rtinchi daraja.'),
('Sarlavhalar va matn', 'h2–h6 sarlavhalar brauzerda qanday ko‘rinadi?', array['Har doim bir xil katta','Daraja kichiklashgan sari matn kichrayadi','Faqat qizil rangda','Ko‘rinmaydi'], 1, 'Daraja kichraygan sari sarlavha ham kichrayadi.'),
('Sarlavhalar va matn', 'Paragrafni yopish kerakmi?', array['Ha, </p>','Yo‘q','Faqat oxirgi paragrafda','Faqat h1 dan keyin'], 0, 'p juftlanadigan teg, </p> yoziladi.'),
('Sarlavhalar va matn', 'hr tegi yopilmaydimi?', array['Ha, </hr>','Yo‘q, juftlanmaydigan teg','Faqat matn oxirida','Faqat jadvalda'], 1, 'hr — juftlanmaydigan teg.'),
('Sarlavhalar va matn', 'br teg ikki marta yozilsa nima bo‘ladi?', array['Ikki satr bo‘sh joy hosil bo‘ladi','Xato chiqadi','Matn o‘chadi','Sahifa yopiladi'], 0, 'Har br satrni uzadi, ikki marta yozilsa bo‘sh qator hosil bo‘ladi.'),
('Sarlavhalar va matn', 'Matnda ketma-ket bo‘sh joylar qanday ko‘rinadi?', array['Hammasi ko‘rinadi','Bitta bo‘sh joyga qisqaradi','Har biri alohida qator','Ko‘rinmaydi'], 1, 'Brauzer ketma-ket bo‘sh joylarni bittaga qisqartiradi.'),
('Sarlavhalar va matn', 'Kod matnini ko‘rsatadigan teg qaysi?', array['code','kod','text','pre-code'], 0, 'code — kompyuter kodi uchun teg.'),
('Sarlavhalar va matn', 'Qisqa iqtibos (qo‘shtirnoqli) matn uchun qaysi teg?', array['q','quote','qq','qt'], 0, 'q — satr ichidagi iqtibos, brauzer qo‘shtirnoq qo‘shadi.'),
('Sarlavhalar va matn', 'Sarlavha va paragraf orasida bo‘sh joy qanday hosil bo‘ladi?', array['Har bir blok avtomatik ajratiladi','Hech qachon','Faqat br bilan','Faqat hr bilan'], 0, 'Blok elementlar brauzerda avtomatik alohida qatorda chiqadi.'),

-- Formatlash
('Formatlash', 'Matnni o‘chirilgan (eskirgan) ko‘rinishda chiziq bilan ko‘rsatadigan teg qaysi?', array['i','del','sup','b'], 1, 'del — o‘chirilgan (eskirgan) matn.'),
('Formatlash', 'Darajani ifodalash uchun (masalan, 2<sup>3</sup>) qaysi teg ishlatiladi?', array['sub','em','sup','strong'], 2, 'sup — yuqori indeks (daraja).'),
('Formatlash', 'Kimyoviy formulada H<sub>2</sub>O dagi pastki indeks uchun qaysi teg?', array['sup','sub','del','mark'], 1, 'sub — pastki indeks.'),
('Formatlash', 'Matnni og‘ma (kursiv) ko‘rinishda yozadigan teg qaysi, ma’noli urg‘u bo‘lmasa?', array['b','i','u','strong'], 1, 'i — kursiv, masalan xorijiy so‘z yoki atama uchun.'),
('Formatlash', 'Matnni faqat qalin (bold) qilish uchun qaysi teg?', array['em','b','mark','sup'], 1, 'b — qalin matn, ma’no urg‘usiz.'),
('Formatlash', 'Gap ma’nosiga urg‘u beradigan teg qaysi?', array['em','hr','ul','iframe'], 0, 'em — ma’noli urg‘u, ko‘pincha kursiv ko‘rinadi.'),
('Formatlash', 'Juda muhim ogohlantirish matni uchun qaysi teg?', array['strong','br','li','img'], 0, 'strong — juda muhim matn, kuchli urg‘u.'),
('Formatlash', 'Ins teg nimani bildiradi?', array['ins','new','add','plus'], 0, 'ins — qo‘shilgan matn, odatda tagiga chiziq bilan ko‘rinadi.'),
('Formatlash', 'Kichik shrift uchun qaysi teg?', array['small','tiny','mini','lite'], 0, 'small — kichikroq matn uchun.'),
('Formatlash', 'Qisqartma (masalan, HTML) uchun qaysi teg?', array['abbr','short','ab','shortcut'], 0, 'abbr — qisqartma, title ichida to‘liq shakli yoziladi.'),
('Formatlash', '<b> va <strong> orasidagi farq nima?', array['Farq yo‘q','b — faqat ko‘rinish, strong — muhimlik ma’nosi','strong faqat rasm uchun','b — faqat link uchun'], 1, 'b faqat ko‘rinish uchun, strong esa ma’noli muhimlikni bildiradi.'),
('Formatlash', '<i> va <em> orasidagi farq nima?', array['em — faqat ko‘rinish, i — ma’noli','i — ko‘rinish (kursiv), em — ma’noli urg‘u','Farq yo‘q','i faqat link uchun'], 1, 'i kursiv ko‘rinish, em esa ma’noli urg‘u.'),
('Formatlash', 'E=mc<sup>2</sup> ifodasida qaysi teg ishlatiladi?', array['sub','sup','del','mark'], 1, 'Daraja uchun sup ishlatiladi.'),
('Formatlash', 'H<sub>2</sub>SO<sub>4</sub> ifodasida nechta sub teg bor?', array['1','2','3','4'], 1, 'Ikki marta: H va O uchun.'),
('Formatlash', 'Ma’no o‘zgartirmasdan matnni ajratish uchun satr ichidagi konteyner qaysi?', array['span','split','part','sep'], 0, 'span — satr ichidagi umumiy konteyner, uslub berish uchun ishlatiladi.'),

-- Ro‘yxatlar
('Ro‘yxatlar', 'Tartiblanmagan (nuqtali) ro‘yxat qaysi teg bilan yaratiladi?', array['ol','ul','li','dl'], 1, 'ul — unordered list.'),
('Ro‘yxatlar', 'Tartiblangan (raqamli) ro‘yxat qaysi teg bilan yaratiladi?', array['ul','ol','li','dt'], 1, 'ol — ordered list.'),
('Ro‘yxatlar', 'Ro‘yxatning har bir elementi qaysi teg bilan yoziladi?', array['li','ll','item','ul'], 0, 'li — list item. U ul yoki ol ichida yoziladi.'),
('Ro‘yxatlar', 'Ro‘yxat ichiga boshqa ro‘yxat qo‘yish mumkinmi?', array['Yo‘q, mumkin emas','Ha, ro‘yxatlarni ichma-ich qilish mumkin','Faqat ol ichida ul mumkin','Faqat h1 ichida'], 1, 'Ichma-ich ro‘yxat li ichiga yoziladi.'),
('Ro‘yxatlar', 'ol tegidagi type atributi nima qiladi?', array['Ro‘yxat belgisini o‘zgartiradi (1, a, I va h.k.)','Rangni beradi','Havola yaratadi','Rasm qo‘yadi'], 0, 'type — raqam, harf yoki rim raqamlarini tanlaydi.'),
('Ro‘yxatlar', 'ol tegidagi start atributi nima qiladi?', array['Ro‘yxat raqamini qaysi sondan boshlashni belgilaydi','Animatsiya boshlaydi','Sahifani boshlaydi','Matnni qalin qiladi'], 0, 'start — raqamlashni boshlanadigan sonni belgilaydi.'),
('Ro‘yxatlar', 'Ul yoki ol ichiga faqat qaysi element joylashtiriladi?', array['Faqat li','Faqat p','Faqat h1','Faqat img'], 0, 'Ro‘yxat ichida faqat li elementlari bo‘ladi.'),
('Ro‘yxatlar', 'ul tegi qanday yopiladi?', array['</ul>','</list>','</ulist>','Yopilmaydi'], 0, 'ul juftlanadigan teg, </ul> bilan yopiladi.'),
('Ro‘yxatlar', 'Ro‘yxat elementi ichiga rasm qo‘yish mumkinmi?', array['Ha, li ichiga img qo‘yiladi','Yo‘q','Faqat ol ichida','Faqat h1 ichida'], 0, 'li ichida boshqa elementlar, jumladan img, bo‘lishi mumkin.'),
('Ro‘yxatlar', 'Menyu uchun ko‘pincha qaysi ro‘yxat ishlatiladi?', array['ol','ul (havolalar bilan)','dl','table'], 1, 'Menyu odatda ul va li ichidagi linklardan yasaladi.'),
('Ro‘yxatlar', 'ul ning standart belgisi qaysi?', array['Disk (nuqta)','Raqam','Harf','Rasm'], 0, 'ul standart holatda nuqta (disc) belgisi bilan chiqadi.'),
('Ro‘yxatlar', 'Ro‘yxatdagi elementlar soni cheklanganmi?', array['Ha, 5 tadan oshmasligi kerak','Yo‘q, cheklov yo‘q','Ha, 10 tadan','Faqat ol da cheklangan'], 1, 'Ro‘yxatda istalgancha li bo‘lishi mumkin.'),

-- Rasm
('Rasm', 'Rasm manzili src atributida qaysi teg bilan beriladi?', array['<image href>','<img src>','<pic link>','<img href>'], 1, 'img tegida rasm manzili src atributida beriladi.'),
('Rasm', 'img tegidagi alt atributi nima uchun kerak?', array['Rasm o‘lchamini o‘zgartiradi','Rasm ko‘rinmasa yoki ekran o‘quvchilar uchun matn beradi','Rasmni o‘chiradi','Rasmni havolaga aylantiradi'], 1, 'alt — rasm mazmunini matn bilan tushuntiradi.'),
('Rasm', 'img tegini yopish kerakmi?', array['Ha, </img> kerak','Yo‘q, img juftlanmaydigan teg','Faqat rasm kattaligi 0 bo‘lsa','Faqat h1 ichida'], 1, 'img — juftlanmaydigan (void) teg.'),
('Rasm', 'Rasm o‘lchamini belgilash uchun qaysi atributlar ishlatiladi?', array['width va height','size va color','w va h','length'], 0, 'width va height rasm o‘lchamini belgilaydi.'),
('Rasm', 'Rasm manzili nisbiy (relative) bo‘lsa, nimani bildiradi?', array['Shu papka ichidagi fayl','Internetdagi har qanday sayt','Faqat kompyuterdagi fayl','Hech narsa'], 0, 'images/a.jpg — joriy papka ichidagi fayl.'),
('Rasm', 'Rasmning to‘liq internet manzili qanday ko‘rinadi?', array['https://site.uz/rasm.jpg','site.uz','rasm.jpg/https','//rasm'], 0, 'To‘liq manzil https:// bilan boshlanadi.'),
('Rasm', 'alt=""  (bo‘sh alt) qachon ishlatiladi?', array['Har doim','Rasm faqat bezak bo‘lsa (ma’no yo‘q)','Rasm muhim bo‘lsa','Hech qachon'], 1, 'Bezak rasmlar uchun bo‘sh alt ishlatiladi.'),
('Rasm', 'img tegi qaysi turdagi teg?', array['Blok','Inline (satr ichidagi)','Ro‘yxat','Sarlavha'], 1, 'img satr ichida joylashadigan inline elementdir.'),
('Rasm', 'JPG, PNG va GIF nima?', array['Rasm formatlari','Dasturlash tillari','Brauzerlar','Shriftlar'], 0, 'Bular rasm fayl formatlari.'),
('Rasm', 'Rasmni havola qilish uchun img qaysi teg ichiga yoziladi?', array['<a> ichiga','<p> ichiga emas','<li> ichiga','<title> ichiga'], 0, 'Rasm <a> ichiga yozilsa, bosilganda havola ochiladi.'),
('Rasm', 'Rasmda src yo‘q bo‘lsa nima bo‘ladi?', array['Rasm ko‘rinmaydi','Rasm avtomatik paydo bo‘ladi','Sahifa yopiladi','Matn chiqadi'], 0, 'Manba ko‘rsatilmagan rasm yuklanmaydi.'),
('Rasm', 'Rasm yuklanishini kechiktirish uchun qaysi atribut?', array['loading="lazy"','defer','async','hidden'], 0, 'loading="lazy" rasmni kerak bo‘lganda yuklaydi.'),

-- Linklar
('Linklar', 'Sahifadagi bo‘limga (id="tarix") o‘tuvchi local link qanday yoziladi?', array['<a href="tarix.com">','<a href="#tarix">','<link to="tarix">','<a src="tarix">'], 1, 'Local link # belgisi bilan boshlanadi: href="#tarix".'),
('Linklar', 'Boshqa saytga o‘tuvchi global link qaysi?', array['<a href="#">','<a name="site">','<a href="https://www.example.com">','<a id="site">'], 2, 'Global link to‘liq manzil bilan yoziladi: https://...'),
('Linklar', 'target="_blank" atributi nima qiladi?', array['Sahifani yopadi','Havolani yangi oynada yoki yorliqda ochadi','Matn rangini o‘zgartiradi','Matnni qalin qiladi'], 1, '_blank havolani yangi oynada ochadi.'),
('Linklar', 'target="_blank" bilan birga rel="noopener noreferrer" nega yoziladi?', array['Havolani o‘chirish uchun','Yangi sahifa asl sahifani boshqarishini cheklash uchun (xavfsizlik)','Havola rangini berish uchun','Havolani yashirish uchun'], 1, 'rel atributi yangi oynadagi sahifa xavfsizligini oshiradi.'),
('Linklar', 'Elektron pochta yuborish oynasini ochadigan havola qanday yoziladi?', array['<a href="mailto:info@site.uz">','<a href="email:info">','<a href="pochta">','<a href="@info">'], 0, 'mailto: sxemasi pochta dasturini ochadi.'),
('Linklar', 'Telefon raqamga bosiladigan havola qanday yoziladi?', array['<a href="tel:+998901234567">','<a href="call:+998">','<a href="phone+998">','<a href="tel//998">'], 0, 'tel: sxemasi telefon qo‘ng‘irog‘ini boshlaydi.'),
('Linklar', 'Havolaning ko‘rinadigan matni qayerda yoziladi?', array['<a> ichidagi matn','href ichidagi manzil','title atributi','id atributi'], 0, 'Foydalanuvchi a tegi ichidagi matnni ko‘radi.'),
('Linklar', 'Sahifa boshiga qaytadigan eng oddiy link qaysi?', array['<a href="#">','<a href="top">','<a name="x">','<a src="#">'], 0, 'href="#" sahifa boshiga olib boradi.'),
('Linklar', 'Boshqa sahifaga (about.html) o‘tuvchi nisbiy link qaysi?', array['<a href="about.html">','<a href="#about">','<a id="about.html">','<a src="about">'], 0, 'Boshqa fayl nomi href ga yoziladi.'),
('Linklar', 'Havolaga sichqoncha tegkanda chiqadigan maslahat matni qaysi atribut?', array['title','alt','name','lang'], 0, 'title — qo‘shimcha ma’lumot maslahat sifatida chiqadi.'),

-- Iframe (video va xarita)
('Iframe (video va xarita)', 'Sahifaga YouTube videoni joylashtirish uchun qaysi teg ishlatiladi?', array['frame','iframe','video','embed'], 1, 'iframe — boshqa saytdagi sahifani (YouTube videosini) joylashtiradi.'),
('Iframe (video va xarita)', 'iframe ichidagi YouTube videosi uchun src qanday bo‘lishi kerak?', array['youtube.com/watch?v=...','https://www.youtube.com/embed/...','youtu.be ni oddiy havola sifatida','https://youtube.com/video'], 1, 'Embed havolasi /embed/ bilan bo‘ladi.'),
('Iframe (video va xarita)', 'Google Maps xaritasini sahifaga joylashtirish uchun qaysi havola ishlatiladi?', array['Xarita sahifasining oddiy URL manzili','Google Maps “Embed” havolasi (iframe src uchun)','Xaritaning ekran surati','QR-kod'], 1, 'iframe faqat embed havolalarini ko‘rsatadi.'),
('Iframe (video va xarita)', 'iframe dagi title atributi nima uchun kerak?', array['Rangini beradi','Ekran o‘quvchilar uchun iframe mazmunini tushuntiradi','Iframe kattaligini beradi','Iframeni o‘chiradi'], 1, 'title iframe mazmuni haqida qisqa ma’lumot beradi.'),
('Iframe (video va xarita)', 'loading="lazy" atributi nima qiladi?', array['Iframe pastga tushgandagina yuklanadi, sahifa tezroq ochiladi','Videoni avtomatik boshlaydi','Iframe ni yashiradi','Rangni o‘zgartiradi'], 0, 'lazy iframe kerak bo‘lgandagina yuklanadi.'),
('Iframe (video va xarita)', 'allowfullscreen atributi nima qiladi?', array['To‘liq ekran tugmasini yoqadi','Rasm qo‘yadi','Ovozni o‘chiradi','Havola yaratadi'], 0, 'allowfullscreen videoni to‘liq ekranda ko‘rish imkonini beradi.'),
('Iframe (video va xarita)', 'iframe uchun width va height nima uchun kerak?', array['Joy o‘lchamini belgilaydi','Rang beradi','Tilni o‘zgartiradi','Havola yaratadi'], 0, 'width va height iframe joyining o‘lchamini belgilaydi.'),
('Iframe (video va xarita)', 'YouTube dan embed kodni qayerdan olish mumkin?', array['Share, keyin Embed (Ulashish, keyin Joylashtirish)','Download','Subscribe','Like'], 0, 'YouTube ulashish bo‘limida iframe kodini beradi.'),
('Iframe (video va xarita)', 'iframe ni yopish kerakmi?', array['Ha, </iframe>','Yo‘q','Faqat Google Maps da','Faqat YouTube da'], 0, 'iframe juftlanadigan teg.'),
('Iframe (video va xarita)', 'iframe ichiga yozilgan matn nima uchun kerak?', array['Iframe ni qo‘llab-quvvatlamaydigan brauzerlarda shu matn ko‘rinadi','Matn rang beradi','Videoni boshlaydi','Xato chiqaradi'], 0, 'Eski brauzerlar iframe ni ko‘rsatmasa, ichidagi matn chiqadi.'),
('Iframe (video va xarita)', 'iframe dagi allow atributi nima?', array['iframe ichida ruxsat etilgan imkoniyatlar (masalan, autoplay) ro‘yxati','Sahifa rangi','Havola manzili','Rasm tegi'], 0, 'allow iframe ichidagi ruxsatlarni belgilaydi.'),

-- Bo‘limlar va ID
('Bo‘limlar va ID', 'Mazmunli bo‘lim (section) yaratadigan teg qaysi?', array['<div>','<section>','<area>','<block>'], 1, 'section mavzuga bog‘liq bo‘lim uchun ishlatiladi.'),
('Bo‘limlar va ID', 'section ga id="tarix" berilishi nima uchun kerak?', array['Rang berish uchun','Linkdan o‘sha bo‘limga o‘tish uchun (href="#tarix")','Rasm qo‘yish uchun','Tilni o‘zgartirish uchun'], 1, 'id elementga nom beradi, link shu nom orqali o‘tadi.'),
('Bo‘limlar va ID', 'Sahifa boshiga qaytish uchun link qanday yoziladi (h1 da id="top" bo‘lsa)?', array['<a href="top">','<a href="#top">','<a href="/top">','<a href="top.html">'], 1, 'href="#top" sahifadagi id="top" elementiga o‘tadi.'),
('Bo‘limlar va ID', 'article teg nimaga ishlatiladi?', array['Mustaqil maqola yoki kontent bloki uchun','Rasm uchun','Havola uchun','Ro‘yxat uchun'], 0, 'article mustaqil ma’noga ega kontent uchun.'),
('Bo‘limlar va ID', 'header va footer teglari nimaga?', array['Sahifa yuqori va pastki qismi uchun semantik teglar','Rang tegi','Shrift tegi','Rasm tegi'], 0, 'header yuqori, footer pastki qism uchun.'),
('Bo‘limlar va ID', 'nav teg nimaga ishlatiladi?', array['Navigatsiya (menyu) linklari uchun','Rasm uchun','Jadval uchun','Izoh uchun'], 0, 'nav asosiy navigatsiya linklarini guruhlaydi.'),
('Bo‘limlar va ID', 'id atributi bir sahifada nechta marta bo‘lishi mumkin?', array['Har bir id unik bo‘lishi kerak (faqat bir marta)','Istalgancha','Ikki marta','Faqat section da'], 0, 'id sahifada noyob bo‘lishi shart, aks holda link noto‘g‘ri joyga boradi.'),
('Bo‘limlar va ID', 'div teg nimaga?', array['Mazmunga ega bo‘lmagan umumiy blok (guruhlash)','Sarlavha','Rasm','Havola'], 0, 'div — elementlarni guruhlash uchun umumiy blok.');
