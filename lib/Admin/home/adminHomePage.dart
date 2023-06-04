import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Admin/home/allUsers.dart';
import 'package:take_drug/Admin/medical/goodPractice/allGoodPractice.dart';
import 'package:take_drug/Admin/medical/medical_food_system/allMedicalFood.dart';
import 'package:take_drug/Admin/home/suggestions.dart';
import 'package:take_drug/Admin/home/widgets/adminDrawer.dart';
import 'package:take_drug/Admin/medical/medicalInfomration/allMedicalInformation.dart';
import 'package:take_drug/Common/config/config.dart';

class adminHomePage extends StatefulWidget {
  @override
  _adminHomePage createState() => _adminHomePage();
}

class _adminHomePage extends State<adminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(),
        title: Text(
          "admin".tr().toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      drawer: AdminDrawer(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 30.0),
          child: GridView.count(
            padding: const EdgeInsets.all(15),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            primary: false,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                onTap: () {
                  Route route =
                      MaterialPageRoute(builder: (_) => Suggestions());
                  Navigator.push(context, route);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.view_agenda,
                        color: takeDrug.BackgroundColor,
                        size: 33,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Suggestions_and_complaints".tr().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: takeDrug.BackgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Route route = MaterialPageRoute(builder: (_) => allUsers());
                  Navigator.push(context, route);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: takeDrug.BackgroundColor,
                        size: 33,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "all_users".tr().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: takeDrug.BackgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Route route =
                      MaterialPageRoute(builder: (_) => const allMedicalFood());
                  Navigator.push(context, route);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: takeDrug.BackgroundColor,
                        size: 33,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "medical_food_system".tr().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: takeDrug.BackgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Route route =
                      MaterialPageRoute(builder: (_) => allGoodPractice());
                  Navigator.push(context, route);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: takeDrug.BackgroundColor,
                        size: 33,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "healthy_doing".tr().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: takeDrug.BackgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Route route = MaterialPageRoute(
                      builder: (_) => const allMedicalInformation());
                  Navigator.push(context, route);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: takeDrug.BackgroundColor,
                        size: 33,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "medical_information_home".tr().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: takeDrug.BackgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // GestureDetector(
              //   onTap: () => {},
              //   child: Card(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     elevation: 4,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(
              //           Icons.info,
              //           color: takeDrug.BackgroundColor,
              //           size: 33,
              //         ),
              //         SizedBox(
              //           height: 5,
              //         ),
              //         Text(
              //           "About",
              //           style: TextStyle(
              //             fontSize: 17,
              //             fontWeight: FontWeight.bold,
              //             color: takeDrug.BackgroundColor,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () => {},
              //   child: Card(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     elevation: 4,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(
              //           Icons.not_interested_sharp,
              //           color: takeDrug.BackgroundColor,
              //           size: 33,
              //         ),
              //         SizedBox(
              //           height: 5,
              //         ),
              //         Text(
              //           "Reported Posts",
              //           style: TextStyle(
              //             fontSize: 17,
              //             fontWeight: FontWeight.bold,
              //             color: takeDrug.BackgroundColor,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  checkExpertStatus() {
    Navigator.of(context);
  }
}
