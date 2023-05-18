import 'package:flutter/material.dart';
import 'package:take_drug/Admin/medical/goodPractice/goodPractice.dart';
import 'package:take_drug/Admin/medical/medicalInfomration/medicalInformation.dart';
import 'package:take_drug/Common/Authentication/myProfile.dart';
import 'package:take_drug/Common/Widgets/Drawer.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/User/Features/Map/googleMap.dart';
import 'package:take_drug/User/Features/gmail/viewData.dart';
import 'package:take_drug/User/Features/uploadFiles/viewFiles.dart';
import 'package:take_drug/User/Features/yourMedication/healthDoing/healthyDoing.dart';
import 'package:take_drug/User/Features/yourMedication/medicalInformation/medicalInfomration.dart';
import 'package:take_drug/User/Features/yourMedication/showDetialsFood/foodSystem.dart';

class yourMedication extends StatefulWidget {
  const yourMedication({super.key});

  @override
  State<yourMedication> createState() => _yourMedication();
}

class _yourMedication extends State<yourMedication> {
  String? currentUser = takeDrug.auth?.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: takeDrug.BackgroundColor,
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Route route =
                    MaterialPageRoute(builder: (_) => const MyProfile());
                Navigator.push(context, route);
              },
              child: Column(
                children: [
                  const Icon(
                    Icons.person_2_rounded,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: const [
                        Text(
                          "رجوع",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Icon(
                          Icons.arrow_forward,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
        title: Column(
          children: const [
            // Image.asset(
            //   "images/lightBlue.png",
            //   width: 50,
            // ),
            Text("دليلك الطبي")
          ],
        ),
        centerTitle: true,
      ),
      drawer: currentUser != null ? UserDrawer() : null,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (_) => foodSystemUser());
                    Navigator.push(context, route);
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: 250,
                      height: 70,
                      child: const Center(
                        child: Text(
                          ' الانظمة الغذائية',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (_) => healthyDoingUser());
                    Navigator.push(context, route);
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: 250,
                      height: 70,
                      child: const Center(
                        child: Text(
                          'ممارسات صحية',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (_) => medicalInfomrationUserPage());
                    Navigator.push(context, route);
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: 250,
                      height: 70,
                      child: const Center(
                        child: Text(
                          'معلومات طبية',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
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
}
