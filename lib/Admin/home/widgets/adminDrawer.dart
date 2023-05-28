import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Admin/home/adminHomePage.dart';
import 'package:take_drug/Common/Authentication/login.dart';
import 'package:take_drug/Common/config/config.dart';

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
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: Text(
                    "home_page".tr().toString(),
                    style: const TextStyle(
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
                  title: Text(
                    "sign_out".tr().toString(),
                    style: const TextStyle(
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
          ),
        ],
      ),
    );
  }
}
