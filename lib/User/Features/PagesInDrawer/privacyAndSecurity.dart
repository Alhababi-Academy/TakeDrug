import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سياسة الخصوصية'),
      ),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'نحن نأخذ خصوصيتك على محمل الجد ونلتزم بحماية معلوماتك الشخصية. توضح هذه السياسة كيفية جمعنا واستخدامنا وكشفنا لمعلوماتك الشخصية عند استخدام تطبيقنا المحمول.',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                const Text(
                  'استخدام الكوكيز وتقنيات التتبع الأخرى',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'يجمع تطبيقنا معلومات عن استخدامك للتطبيق باستخدام ملفات تعريف الارتباط وتقنيات التتبع الأخرى. يساعدنا هذا على تحسين خدماتنا وتقديم تجربة مستخدم مخصصة. عند استخدام تطبيقنا، فإنك توافق على استخدامنا لملفات تعريف الارتباط وفقًا لسياسة الخصوصية هذه.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'حقوق المستخدم',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'تتوفر لك العديد من الحقوق بخصوص المعلومات الشخصية التي نجمعها عنك. تتضمن هذه الحقوق الحصول على نسخة من المعلومات التي نحتفظ بها عنك، وتصحيح المعلومات الغير صحيحة، وطلب حذف بياناتك الشخصية، والاعتراض على معالجة بياناتك الشخصية لأغراض التسويق. إذا كنت ترغب في ممارسة أي من هذه الحقوق، يرجى الاتصال بنا على البريد الإلكتروني المذكور في هذه السياسة.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
