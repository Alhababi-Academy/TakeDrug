import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:take_drug/Common/DialogBox/errorDialog.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/Widgets/customTextFieldRegisterPage.dart';
import 'package:take_drug/Common/config/config.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
      ),
      backgroundColor: takeDrug.BackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 180,
              child: Image.asset("images/lightBlue.png"),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      "email".tr().toString(),
                      style: TextStyle(
                        color: takeDrug.whiteTow,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  customTextFieldRegsiterPage(
                    isSecure: false,
                    enabledEdit: true,
                    prefixIcon: Icon(
                      Icons.email,
                      color: takeDrug.BackgroundColor,
                    ),
                    textEditingController: _emailTextEditingController,
                    textInputType: TextInputType.emailAddress,
                    hint: "example@gmail.com",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      takeDrug.whiteOne,
                    ),
                    shadowColor: MaterialStateProperty.all(
                      Colors.transparent,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    restPassowrd();
                  },
                  child: Container(
                    width: 100,
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            "send".tr().toString(),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: takeDrug.BackgroundColor),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: takeDrug.BackgroundColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> restPassowrd() async {
    _emailTextEditingController.text.isNotEmpty
        ? uploadToStorage()
        : displayDialog();
  }

  displayDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) {
        return errorDialog(
          message: "fill_up_the_form".tr().toString(),
        );
      },
    );
  }

  uploadToStorage() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
              message: "validating_data_please_wait".tr().toString());
        });
    _login();
  }

  var currentUser;
  void _login() async {
    takeDrug.auth!
        .sendPasswordResetEmail(email: _emailTextEditingController.text.trim())
        .then(
      (auth) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) => const errorDialog(
                  message: "تم ارسال الرسالة الى ايميلك",
                ));
      },
    ).catchError(
      (error) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (c) => errorDialog(
            message: error.toString(),
          ),
        );
      },
    );
  }
}
