import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Common/Authentication/login.dart';
import 'package:take_drug/Common/Authentication/myProfile.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/User/Features/PagesInDrawer/aboutUs.dart';
import 'package:take_drug/User/Features/PagesInDrawer/privacyAndSecurity.dart';
import 'package:take_drug/User/Features/suggestions/uploadSuggestions.dart';
import 'package:take_drug/User/Features/suggestions/viewSugesstions.dart';
import 'package:take_drug/User/UserHomePage.dart';

class UserDrawer extends StatelessWidget {
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
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "الصفحة اليئيسية",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => UserHomePage());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                const Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "السياسات والخصوصية",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => PrivacyPolicyPage());
                    Navigator.push(context, route);
                  },
                ),
                const Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.indeterminate_check_box,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "الاقتراحات والشكاوي",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (c) => const ViewSugesstions());
                    Navigator.push(context, route);
                  },
                ),
                const Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "عن التطبيق",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => AboutUsPage());
                    Navigator.push(context, route);
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
                    Route route =
                        MaterialPageRoute(builder: (c) => loginPage());
                    Navigator.pushAndRemoveUntil(
                        context, route, (route) => false);
                  },
                ),
                const Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        context.setLocale(const Locale("en"));
                      },
                      child: Container(
                        child: Flag.fromCode(
                          FlagsCode.US,
                          height: 30,
                          width: 40,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.setLocale(const Locale("ar"));
                      },
                      child: Container(
                        child: Flag.fromCode(
                          FlagsCode.SA,
                          height: 30,
                          width: 40,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
