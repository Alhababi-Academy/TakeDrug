import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Common/Authentication/editProfile.dart';
import 'package:take_drug/Common/Authentication/login.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:take_drug/User/UserHomePage.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String? currentUser = takeDrug.auth?.currentUser?.uid;
  String? NameTemp = takeDrug.sharedPreferences!
      .getString("${takeDrug.FristNameUser} ${takeDrug.SecondNameUser}");
  String imageGetting = takeDrug.sharedPreferences!
      .getString(takeDrug.profileImageUser)
      .toString();

  XFile? ImageXFile;
  ImagePicker _picker = ImagePicker();
  String? profileImage;

  // this is an empty variables to call the data on it
  String? FristName;
  String? SecondName;
  String? Email;
  String? Gender;
  String? phoneNumber;
  String? DateOfRegistering;
  int? age;
  String? city;
  String? DateOfBrithDay;

  @override
  Widget build(BuildContext context) {
    // temp files

    return Material(
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              takeDrug.auth!.signOut().then((value) {
                                Route route = MaterialPageRoute(
                                    builder: (_) => const loginPage());
                                Navigator.pushAndRemoveUntil(
                                    context, route, (route) => false);
                              });
                            },
                            icon: Icon(
                              Icons.logout,
                              color: takeDrug.BackgroundColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Route route = MaterialPageRoute(
                                  builder: (_) => const UserHomePage());
                              Navigator.pushAndRemoveUntil(
                                  context, route, (route) => false);
                            },
                            icon: Icon(
                              Icons.home,
                              color: takeDrug.BackgroundColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "الملف الشخصي",
                      style: TextStyle(
                        color: Color(0XFF00213F),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          imageGetting.isNotEmpty
                              ? CircleAvatar(
                                  backgroundColor: Colors.black12,
                                  backgroundImage: NetworkImage(imageGetting),
                                  radius: 50,
                                )
                              : const CircleAvatar(
                                  backgroundColor: Colors.black12,
                                  radius: 23,
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${takeDrug.sharedPreferences!.getString(takeDrug.FristNameUser)} ${takeDrug.sharedPreferences!.getString(takeDrug.SecondNameUser)}",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 15, left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StreamBuilder<DocumentSnapshot>(
                              stream: takeDrug.firebaseFirestore!
                                  .collection("users")
                                  .doc(currentUser)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return Container(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  " اسم المستخدم : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                    "${snapshot.data!['firstName']} ${snapshot.data!['secondName']}"),
                                              ],
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  " الجنس : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(snapshot.data!['gender']),
                                              ],
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  " تاريخ الميلاد : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(snapshot
                                                    .data!['dateOfBrith']),
                                              ],
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  " رقم الهاتف : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                    "${snapshot.data!['phoneNumber']}"),
                                              ],
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "  المدينة : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                    "${snapshot.data!['city']}"),
                                              ],
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  " تاريخ التسجيل في التطبيق : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(snapshot
                                                    .data!['registedOn']),
                                              ],
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // checkUsers();
                          Route route =
                              MaterialPageRoute(builder: (_) => EditProfile());
                          Navigator.push(context, route);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            takeDrug.BackgroundColor,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                30.0,
                              ),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(7),
                          ),
                        ),
                        child: const Text(
                          "تعديل الحساب",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
