import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/config/config.dart';

class showAllUsers extends StatefulWidget {
  const showAllUsers({super.key});

  @override
  State<showAllUsers> createState() => _showAllUsers();
}

class _showAllUsers extends State<showAllUsers> {
  String searching = '';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("عرض المستخدمين"),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(17),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("عرض جميع المستخدمين"),
                // البحث

                StreamBuilder<QuerySnapshot>(
                  stream: takeDrug.firebaseFirestore!.collection("users").where(
                      "userType",
                      whereNotIn: ["admin", "coach"]).snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var userId = snapshot.data!.docs[index].id;
                              var activeOrNot =
                                  snapshot.data!.docs[index]['userStatus'];

                              return Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 206, 205, 205),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(snapshot
                                                  .data!.docs[index]['fullName']
                                                  .toString()),
                                              const SizedBox(
                                                width: 40,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "الايميل: ",
                                              ),
                                              Text(
                                                snapshot
                                                    .data!.docs[index]['email']
                                                    .toString(),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "حالة الحساب: ",
                                              ),
                                              Text(
                                                snapshot.data!
                                                    .docs[index]['userStatus']
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                        activeOrNot == "active"
                                                            ? Colors.green
                                                            : Colors.red),
                                              ),
                                            ],
                                          ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     Row(
                                          //       children: [
                                          //         const Text(
                                          //           "الميلاد: ",
                                          //         ),
                                          //         Text(
                                          //           snapshot.data!
                                          //               .docs[index]['brithDay']
                                          //               .toString(),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  disableThisBUtton(String id) async {
    showDialog(
        context: context,
        builder: (_) => const LoadingAlertDialog(
              message: 'حفظ البيانات ',
            ));
    await takeDrug.firebaseFirestore!
        .collection("users")
        .doc(id)
        .update({"accountStatus": "notActive"}).then((value) {
      Navigator.pop(context);
    });
  }

  enable(String id) async {
    showDialog(
        context: context,
        builder: (_) => const LoadingAlertDialog(
              message: 'حفظ البيانات ',
            ));
    await takeDrug.firebaseFirestore!
        .collection("users")
        .doc(id)
        .update({"accountStatus": "active"}).then((value) {
      Navigator.pop(context);
    });
  }

  delete(String id) async {
    showDialog(
        context: context,
        builder: (_) => const LoadingAlertDialog(
              message: 'حذف المستخدم ',
            ));
    await takeDrug.firebaseFirestore!
        .collection("users")
        .doc(id)
        .delete()
        .then((value) {
      Navigator.pop(context);
    });
  }
}
