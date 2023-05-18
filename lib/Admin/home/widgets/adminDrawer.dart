import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Admin/home/adminHomePage.dart';
import 'package:take_drug/Common/Authentication/login.dart';
import 'package:take_drug/Common/Authentication/myProfile.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/User/Features/PagesInDrawer/aboutUs.dart';
import 'package:take_drug/User/Features/PagesInDrawer/privacyAndSecurity.dart';

class AdminDrawer extends StatelessWidget {
  Color color1 = const Color.fromARGB(128, 208, 199, 1);
  Color color2 = const Color.fromARGB(19, 84, 122, 1);
  String imageGetting = takeDrug.sharedPreferences!
      .getString(takeDrug.profileImageUser)
      .toString();
  String? name = takeDrug.sharedPreferences!
      .getString("${takeDrug.FristNameUser} ${takeDrug.SecondNameUser}");
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: takeDrug.BackgroundColor,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                  elevation: 8.0,
                  child: SizedBox(
                    height: 160.0,
                    width: 160.0,
                    child: imageGetting.length > 5
                        ? CircleAvatar(
                            backgroundColor: Colors.black12,
                            backgroundImage: NetworkImage(imageGetting),
                            radius: 23,
                          )
                        : const CircleAvatar(
                            backgroundColor: Colors.black12,
                            radius: 23,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                // ListTile(
                //   leading: const Icon(
                //     Icons.home,
                //     color: Colors.white,
                //   ),
                //   title: const Text(
                //     "الملف الشخصي",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   onTap: () {
                //     Route route =
                //         MaterialPageRoute(builder: (c) => MyProfile());
                //     Navigator.pushReplacement(context, route);
                //   },
                // ),
                // const Divider(
                //   height: 10.0,
                //   color: Colors.white,
                //   thickness: 6.0,
                // ),
                // ListTile(
                //   leading: const Icon(
                //     Icons.calendar_month,
                //     color: Colors.white,
                //   ),
                //   title: const Text(
                //     "السياسات والخصوصية",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   onTap: () {
                //     Route route =
                //         MaterialPageRoute(builder: (c) => PrivacyPolicyPage());
                //     Navigator.push(context, route);
                //   },
                // ),
                // const Divider(
                //   height: 10.0,
                //   color: Colors.white,
                //   thickness: 6.0,
                // ),
                // ListTile(
                //   leading: const Icon(
                //     Icons.indeterminate_check_box,
                //     color: Colors.white,
                //   ),
                //   title: const Text(
                //     "الاقتراحات والشكاوي",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   onTap: () {
                //     // Route route =
                //     //     MaterialPageRoute(builder: (c) => const apiPage());
                //     // Navigator.push(context, route);
                //   },
                // ),
                // const Divider(
                //   height: 10.0,
                //   color: Colors.white,
                //   thickness: 6.0,
                // ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "الصفحة الرئيسية",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => adminHomePage());
                    Navigator.pushAndRemoveUntil(
                        context, route, (route) => false);
                  },
                ),
                const Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "تسجيل خروج",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    takeDrug.auth?.signOut().then((value) {
                      Route route =
                          MaterialPageRoute(builder: (c) => loginPage());
                      Navigator.pushAndRemoveUntil(
                          context, route, (route) => false);
                    });
                  },
                ),
                const Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
