import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Common/Authentication/myProfile.dart';
import 'package:take_drug/Common/Widgets/Drawer.dart';
import 'package:take_drug/Common/config/config.dart';

class PageDetailsFood extends StatefulWidget {
  final String medicalID;
  const PageDetailsFood({required this.medicalID, super.key});

  @override
  State<PageDetailsFood> createState() => _PageDetailsFood();
}

class _PageDetailsFood extends State<PageDetailsFood> {
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
          children: [Text("your_Medical".tr().toString())],
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
        child: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(10),
          child: StreamBuilder<DocumentSnapshot>(
            stream: takeDrug.firebaseFirestore!
                .collection("medicalFood")
                .doc(widget.medicalID)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    children: [
                      Column(
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
                              Text("${snapshot.data!['foodTitle']}"),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.receipt,
                                color: takeDrug.BackgroundColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text("${snapshot.data!['catagories']}"),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info,
                                color: takeDrug.BackgroundColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: const [
                                  Text("تفاصيل النظام الغذائي"),
                                ],
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 35),
                            child: Text(
                              "${snapshot.data!['foodDescription']}",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          // child: StreamBuilder(
          //     stream: takeDrug.firebaseFirestore!
          //         .collection("medicalFood")
          //         .doc(widget.medicalID)
          //         .snapshots(),
          //     builder: (context, snapshot) {
          //   return Column(
          //     children: [
          //       Row(
          //         children: [
          //           Icon(
          //             Icons.local_offer,
          //             color: takeDrug.BackgroundColor,
          //           ),
          //           const SizedBox(
          //             width: 10,
          //           ),
          //           Text(snapshot.data!.get(['foodTitle']))
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 20,
          //       ),
          //       Row(
          //         children: [
          //           Icon(
          //             Icons.receipt,
          //             color: takeDrug.BackgroundColor,
          //           ),
          //           const SizedBox(
          //             width: 10,
          //           ),
          //           Text(snapshot.data!.get(['foodDescription']))
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 20,
          //       ),
          //       Row(
          //         children: [
          //           Icon(
          //             Icons.info,
          //             color: takeDrug.BackgroundColor,
          //           ),
          //           const SizedBox(
          //             width: 10,
          //           ),
          //           Column(
          //             children: const [
          //               Text("تفاصيل النظام الغذائي"),
          //             ],
          //           )
          //         ],
          //       ),
          //       Container(
          //         margin: const EdgeInsets.only(right: 27),
          //         child: Text(snapshot.data!.get(['foodDescription'])),
          //       ),
          //     ],
          //   );
          // }),
        ),
      ),
    );
  }
}
