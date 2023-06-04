import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Common/Authentication/myProfile.dart';
import 'package:take_drug/Common/Widgets/Drawer.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/User/Features/yourMedication/healthDoing/pageDetails.dart';

class healthyDoingUser extends StatefulWidget {
  const healthyDoingUser({super.key});

  @override
  State<healthyDoingUser> createState() => _healthyDoingUser();
}

class _healthyDoingUser extends State<healthyDoingUser> {
  String? currentUser = takeDrug.auth?.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: takeDrug.BackgroundColor,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: GestureDetector(
        //       onTap: () {
        //         Route route =
        //             MaterialPageRoute(builder: (_) => const MyProfile());
        //         Navigator.push(context, route);
        //       },
        //       child: Column(
        //         children: [
        //           const Icon(
        //             Icons.person_2_rounded,
        //           ),
        //           GestureDetector(
        //             onTap: () {
        //               Navigator.pop(context);
        //             },
        //             child: Row(
        //               children: const [
        //                 Text(
        //                   "رجوع",
        //                   style: TextStyle(fontWeight: FontWeight.bold),
        //                 ),
        //                 SizedBox(
        //                   width: 5,
        //                 ),
        //                 SizedBox(
        //                   height: 30,
        //                 ),
        //                 Icon(
        //                   Icons.arrow_forward,
        //                 ),
        //               ],
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ],
        title: Column(
          children: [
            Text(
              "healthy_doing".tr().toString(),
            ),
          ],
        ),
        centerTitle: true,
      ),
      endDrawer: currentUser != null ? UserDrawer() : null,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: takeDrug.firebaseFirestore!
                  .collection("goodPractice")
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
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      String medicalID = snapshot.data!.docs[index].id;

                      return Container(
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // shadow color
                              spreadRadius: 5, // spread radius
                              blurRadius: 7, // blur radius
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.local_offer,
                                      color: takeDrug.BackgroundColor,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(snapshot.data!.docs[index]
                                        ['foodTitle']),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.pix,
                                  color: takeDrug.BackgroundColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    snapshot.data!.docs[index]
                                        ['foodDescription'],
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Route route = MaterialPageRoute(
                                    builder: (_) => PageDetailsGoodPractice(
                                        medicalID: medicalID));
                                Navigator.push(context, route);
                              },
                              child: Center(
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(right: 4, left: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.lightBlue[50],
                                  ),
                                  child: Text("show_details".tr().toString()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
