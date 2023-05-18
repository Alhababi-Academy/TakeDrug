import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('من نحن'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(height: 20),
              Text(
                'نحن فريق من المطورين المتحمسين الذين يسعون جاهدين لتطوير تطبيقات مفيدة وسهلة الاستخدام.',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'نحن نؤمن بقيمة الابتكار والجودة والتفاني في توفير تجربة مستخدم ممتازة لجميع مستخدمي تطبيقاتنا. نحن نسعى جاهدين لتحقيق هذا الهدف من خلال العمل الجاد والمثابرة في تطوير تطبيقاتنا، وتقديم الدعم الفني والتحديثات المستمرة للحفاظ على رضا عملائنا.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'نحن نشجع التفاعل والتواصل مع عملائنا، ونرحب بجميع الاقتراحات والشكاوي والملاحظات التي تساعدنا على تحسين خدماتنا وتلبية احتياجات عملائنا. فلا تتردد في التواصل معنا في أي وقت.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
