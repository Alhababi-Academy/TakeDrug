import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Admin/home/adminHomePage.dart';
import 'package:take_drug/Common/Authentication/login.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/User/UserHomePage.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  Widget build(BuildContext context) {
    // the start of writing widgets
    return Material(
      color: takeDrug.BackgroundColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("images/lightBlue.png"),
                ),
              ],
            ),
            Column(
              children: const [
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  // this is the start of fucntinos
                  onTap: () {
                    continueButton();
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "continue".tr().toString(),
                          style: TextStyle(
                            color: takeDrug.whiteTow,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: takeDrug.whiteTow,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.setLocale(const Locale("en"));
                      },
                      child: const Text(
                        "English",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.setLocale(const Locale("ar"));
                      },
                      child: const Text(
                        "Arabic",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  continueButton() async {
    if (takeDrug.auth?.currentUser != null) {
      String? currentUser = takeDrug.auth!.currentUser!.uid;
      await takeDrug.firebaseFirestore!
          .collection("users")
          .doc(currentUser)
          .get()
          .then(
        (result) {
          if (result.data()!.isNotEmpty) {
            String userType = result.data()!['type'];
            switch (userType) {
              case "admin":
                Route route =
                    MaterialPageRoute(builder: (_) => adminHomePage());
                Navigator.pushAndRemoveUntil(context, route, (route) => false);
                break;
              case "user":
                Route route = MaterialPageRoute(builder: (_) => UserHomePage());
                Navigator.pushAndRemoveUntil(context, route, (route) => false);
                break;
            }
          }
        },
      );
    } else {
      Route route = MaterialPageRoute(builder: (_) => loginPage());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    }
  }
}
