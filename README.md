# سباق الحلبة · Circuit Rush

تطبيق Android ديال لعبة السباق، مبني بـ Flutter. اللعبة كاملة كاينة ف `assets/game/index.html`، والتطبيق كيعرضها ف WebView بشاشة كاملة.

## شنو كاين ف المشروع

| الملف | شنو كيدير |
|---|---|
| `assets/game/index.html` | اللعبة كاملة (العربية، English، Français) |
| `assets/icon/icon.png` | الأيقونة ديال التطبيق (1024×1024) |
| `assets/icon/icon_fg.png` | الطبقة الأمامية ديال الأيقونة المتكيفة (Adaptive icon) |
| `lib/main.dart` | الكود ديال Flutter: شاشة كاملة، وضع عمودي، وقفة أوتوماتيكية، وزر الرجوع |
| `setup_android.sh` | كيوجد ملفات Android، سمية التطبيق، صلاحية الإنترنت، والأيقونات |
| `.github/workflows/build-apk.yml` | كيبني ملف APK أوتوماتيكيا ف GitHub |

---

## الطريقة 1: تبني APK ف GitHub (بلا ما تثبت والو)

1. دخل لـ github.com ودير **New repository** (مثلا `circuit-rush`).
2. طلع جميع الملفات ديال هاد المجلد للـ repository (حتى المجلد `.github`).
   - من الموقع: **Add file → Upload files** وجر الملفات.
   - المجلد `.github` كيكون مخبي، إلا ما بانش ليك دير الأمر:
     ```
     git init && git add . && git commit -m "Circuit Rush"
     git branch -M main
     git remote add origin https://github.com/rmb-apps/circuit-rush.git
     git push -u origin main
     ```
3. سير لـ **Actions**، غادي تلقى **Build APK** خدام (كياخد تقريبا 5 حتى 8 دقايق).
4. ملي يكمل بالأخضر ✅، دخل عليه وتحت **Artifacts** حمل `circuit-rush-apk`.
5. حل ملف zip، وغادي تلقى `app-release.apk`. صيفطو للتليفون وثبتو
   (خاصك تسمح بـ **تثبيت التطبيقات من مصادر غير معروفة**).

إلا بغيتي تعاود تبني من بعد تعديل، غير دير push ولا ضغط **Run workflow** ف Actions.

## الطريقة 2: تبني ف البيسي ديالك

خاصك Flutter و Android Studio (ولا Android SDK) مثبتين.

```bash
bash setup_android.sh
flutter build apk --release
```

الملف كيتسجل ف: `build/app/outputs/flutter-apk/app-release.apk`

باش تجربها مباشرة ف تليفون مكونيكطي: `flutter run`

---

## Play Store

ملف APK اللي كيخرج موقع بمفتاح التجربة (debug key)، وكيصلح باش تثبتو وتشاركو مع صحابك.
باش تنشر ف Google Play خاصك:
1. توجد مفتاح خاص بيك (keystore) وتزيدو ف `android/app/build.gradle`.
2. تبني `flutter build appbundle` (ملف `.aab`).
3. تحط سمية الباكاج `com.hlba.circuit_rush` ولا تبدلها لشي سمية خاصة بيك.

## الخصوصية

- سياسة الخصوصية بثلاث لغات كاينة ف `docs/privacy.html`.
- باش يولي عندها رابط عمومي: **Settings → Pages**، ف **Branch** ختار `main` و `/docs`، ومن بعد **Save**.
- الرابط: `https://rmb-apps.github.io/circuit-rush/privacy.html` (كاين حتى `#en` و `#fr`).
- هاد الرابط هو اللي كتحط ف Play Console، ف **Privacy policy**.
- ف **Data safety** ف Play Console، جاوب بلي التطبيق **ما كيجمع حتى بيانات** وما كيشاركهم مع حد.

## ملاحظات

- الخطوط (Lalezar و Cairo) كيتحملو وقت البناء وكيتحطو وسط التطبيق، والتطبيق كيخدم بلا إنترنت وبلا صلاحية ديال الإنترنت.
- النتائج، القطع، الطوموبيلات والمهمات كيتسجلو ف التليفون.
- ملي كتخرج من التطبيق ولا تضغط على زر الرجوع، السباق كيوقف بوحدو.
