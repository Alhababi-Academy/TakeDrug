import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:intl/intl.dart' as DateFormat;

class SendMail extends StatefulWidget {
  const SendMail({Key? key}) : super(key: key);

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  final TextEditingController _recipientEmailController =
      TextEditingController();
  final TextEditingController _mailMessageController = TextEditingController();

  // Send Mail function
  void sendMail({
    required String recipientEmail,
    required String mailMessage,
  }) async {
    // change your email here
    String username = 'alhababu111@gmail.com';
    // change your password here
    String password = 'czdiomfplcwtnoae';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Mail Service')
      ..recipients.add(recipientEmail)
      ..subject = 'Sending From Take Drug app '
      ..text = 'Message: $mailMessage';

    try {
      await send(message, smtpServer).then(
        (value) {
          // getting current User
          String currentUser = takeDrug.auth!.currentUser!.uid;

          takeDrug.firebaseFirestore!.collection("emails").add({
            "MessageSentOn":
                DateFormat.DateFormat('dd-mm-yyyy').format(DateTime.now()),
            "message": mailMessage.toString(),
            "From": username.trim(),
            "To": recipientEmail.trim(),
            "subject": "Sending From Take Drug app",
            "sentBy": currentUser.trim().toString(),
          }).then((value) {
            showSnackbar('تم ارسال الايميل');
          });
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ارسال ايميل'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'إلى',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                controller: _recipientEmailController,
              ),
              const SizedBox(height: 30),
              TextFormField(
                maxLines: 5,
                controller: _mailMessageController,
                decoration: const InputDecoration(
                  labelText: 'الرسالة',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    sendMail(
                      recipientEmail: _recipientEmailController.text.toString(),
                      mailMessage: _mailMessageController.text.toString(),
                    );
                  },
                  child: const Text('ارسل الرسالة'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(),
        ),
      ),
    );
  }
}
