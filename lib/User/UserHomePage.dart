import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Common/Authentication/myProfile.dart';
import 'package:take_drug/Common/Widgets/Drawer.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/User/Features/Map/googleMap.dart';
import 'package:take_drug/User/Features/gmail/viewData.dart';
import 'package:take_drug/User/Features/timeForDrinkingMed/timeToEatDetails.dart';
import 'package:take_drug/User/Features/timeForDrinkingMed/timeToEatMed.dart';
import 'package:take_drug/User/Features/timeToGoToDoctor/timeToGoToDoctor.dart';
import 'package:take_drug/User/Features/uploadFiles/viewFiles.dart';
import 'package:take_drug/User/Features/yourMedication/yourMedication.dart';
import 'package:url_launcher/url_launcher.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  String? currentUser = takeDrug.auth?.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: takeDrug.BackgroundColor,
        leading: currentUser != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (_) => const MyProfile());
                    Navigator.push(context, route);
                  },
                  child: const Icon(
                    Icons.person_2_rounded,
                  ),
                ),
              )
            : Container(),
        title: Column(
          children: [
            Text("main_page".tr().toString()),
          ],
        ),
        centerTitle: true,
      ),
      endDrawer: currentUser != null ? UserDrawer() : null,
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Route route =
                    MaterialPageRoute(builder: (_) => const timeToEatUser());
                Navigator.push(context, route);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Icon(
                        Icons.watch_later_rounded,
                        size: 50,
                        color: takeDrug.BackgroundColor,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                          color: takeDrug.BackgroundColor,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "Medication_times".tr().toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Route route =
                    MaterialPageRoute(builder: (_) => const timeToGoToDoctor());
                Navigator.push(context, route);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Icon(
                        Icons.local_hospital,
                        size: 50,
                        color: takeDrug.BackgroundColor,
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: takeDrug.BackgroundColor,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "Medical_appointment_times".tr().toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Route route =
                    MaterialPageRoute(builder: (_) => const yourMedication());
                Navigator.push(context, route);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Icon(
                        Icons.medical_information,
                        size: 50,
                        color: takeDrug.BackgroundColor,
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: takeDrug.BackgroundColor,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "medical_directory".tr().toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Route route =
                    MaterialPageRoute(builder: (_) => const viewFiles());
                Navigator.push(context, route);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Icon(
                        Icons.folder,
                        size: 50,
                        color: takeDrug.BackgroundColor,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                          color: takeDrug.BackgroundColor,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "saved_Files".tr().toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (currentUser != null) {
                  final Uri _emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: '',
                      queryParameters: {'subject': '', 'body': ''});
                  String url = _emailLaunchUri.toString();
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(
                      _emailLaunchUri,
                    );
                  } else {
                    throw 'Could not launch $url';
                  }
                } else {
                  Route route =
                      MaterialPageRoute(builder: (_) => const ViewAllEmails());
                  Navigator.push(context, route);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Icon(
                        Icons.email,
                        size: 50,
                        color: takeDrug.BackgroundColor,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                          color: takeDrug.BackgroundColor,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "E-mail".tr().toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Route route = MaterialPageRoute(builder: (_) => MapScreen());
                Navigator.push(context, route);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Icon(
                        Icons.location_on,
                        size: 50,
                        color: takeDrug.BackgroundColor,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                          color: takeDrug.BackgroundColor,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "Local_site_map".tr().toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
