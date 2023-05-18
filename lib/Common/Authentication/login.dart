import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Admin/home/adminHomePage.dart';
import 'package:take_drug/Common/Authentication/register.dart';
import 'package:take_drug/Common/Authentication/resetPassword.dart';
import 'package:take_drug/Common/DialogBox/errorDialog.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/Widgets/customTextFieldRegisterPage.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/User/UserHomePage.dart';
import 'package:flag/flag.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPage();
}

class _loginPage extends State<loginPage> {
  TextEditingController EmailAdministrative = TextEditingController();
  TextEditingController PasswordAdministrative = TextEditingController();
  bool isSecureClicked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: takeDrug.BackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          "الايميل",
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
                        textEditingController: EmailAdministrative,
                        textInputType: TextInputType.emailAddress,
                        hint: "example@gmail.com",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Text(
                          "كلمة المرور",
                          style: TextStyle(
                            color: takeDrug.whiteTow,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      customTextFieldRegsiterPage(
                          isSecure: isSecureClicked,
                          enabledEdit: true,
                          textEditingController: PasswordAdministrative,
                          textInputType: TextInputType.emailAddress,
                          hint: "123456789*",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: takeDrug.BackgroundColor,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(!isSecureClicked
                                ? Icons.visibility_off
                                : Icons.remove_red_eye),
                            color: takeDrug.BackgroundColor,
                            onPressed: () {
                              setState(() {
                                isSecureClicked = !isSecureClicked;
                              });
                            },
                          )),
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
                        validateData();
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
                                'ارسال',
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " نسيت كلمة المرور ؟ ",
                          style: TextStyle(
                            color: takeDrug.whiteOne,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (_) => const ResetPassword());
                            Navigator.push(context, route);
                          },
                          child: Text(
                            "أظغط هنا",
                            style: TextStyle(
                              color: takeDrug.whiteTow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ليس لديك حساب؟ ",
                          style: TextStyle(
                            color: takeDrug.whiteOne,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (_) => const ReigsterPage());
                            Navigator.push(context, route);
                          },
                          child: Text(
                            "سجل الان",
                            style: TextStyle(
                              color: takeDrug.whiteTow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  color: takeDrug.thirdColor,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " الاستمرار كا زائر ؟ ",
                      style: TextStyle(
                        color: takeDrug.whiteOne,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (_) => const UserHomePage());
                        Navigator.push(context, route);
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.zero,
                        ),
                      ),
                      child: Text(
                        "أظغط هنا",
                        style: TextStyle(
                          color: takeDrug.whiteTow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> validateData() async {
    EmailAdministrative.text.isNotEmpty &&
            PasswordAdministrative.text.isNotEmpty
        ? uploadToStorage()
        : displayDialog();
  }

  displayDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return const errorDialog(
            message: "قم بي مل الاستمارة",
          );
        });
  }

  uploadToStorage() async {
    showDialog(
        context: context,
        builder: (c) {
          return const LoadingAlertDialog(
              message: "...التحقق من البيانات ، يرجاء الانتظار");
        });
    _login();
  }

  String? currentUser;
  void _login() async {
    takeDrug.auth!
        .signInWithEmailAndPassword(
            email: EmailAdministrative.text.trim(),
            password: PasswordAdministrative.text.trim())
        .then((auth) {
      currentUser = auth.user!.uid;
      GettingData(currentUser!);
    }).catchError(
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

  GettingData(String currrentUser) async {
    await takeDrug.firebaseFirestore!
        .collection("users")
        .doc(currrentUser)
        .get()
        .then((results) {
      String UserType = results.data()!['type'];
      switch (UserType) {
        case "admin":
          // to store temp files
          takeDrug.sharedPreferences!
              .setString(takeDrug.FristNameAdmin, results.data()!['firstName']);
          takeDrug.sharedPreferences!
              .setString(takeDrug.AdminEmail, results.data()!['secondName']);
          takeDrug.sharedPreferences!
              .setString(takeDrug.AdminEmail, results.data()!['email']);

          Route route = MaterialPageRoute(builder: (_) => adminHomePage());
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
          break;
        // to store temp files
        case "user":
          takeDrug.sharedPreferences!
              .setString(takeDrug.FristNameUser, results.data()!['firstName']);
          takeDrug.sharedPreferences!.setString(
              takeDrug.SecondNameUser, results.data()!['secondName']);
          takeDrug.sharedPreferences!
              .setString(takeDrug.UserEmail, results.data()!['email']);

          Route route = MaterialPageRoute(builder: (_) => const UserHomePage());
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
          break;
      }
    });
  }
}
