import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as dateFixing;
import 'package:take_drug/Admin/home/widgets/adminDrawer.dart';
import 'package:take_drug/Admin/medical/goodPractice/editGoodPractice.dart';
import 'package:take_drug/Admin/medical/goodPractice/goodPractice.dart';
import 'package:take_drug/Common/Authentication/login.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/Widgets/Drawer.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/User/Features/gmail/sendGmail.dart';
import 'package:take_drug/User/Features/suggestions/uploadSuggestions.dart';

class allGoodPractice extends StatefulWidget {
  const allGoodPractice({super.key});

  @override
  State<allGoodPractice> createState() => _allGoodPractice();
}

class _allGoodPractice extends State<allGoodPractice> {
  String? currentUser = takeDrug.auth?.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Route route = MaterialPageRoute(builder: (_) => const goodPractice());
          Navigator.push(context, route);
        },
        child: const Icon(
          Icons.send,
        ),
      ),
      appBar: AppBar(
        title: const Text("جميع الممارسات الصحية"),
        centerTitle: true,
      ),
      drawer: AdminDrawer(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Container(
              child: Row(
                children: [],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: takeDrug.firebaseFirestore!
                    .collection("goodPractice")
                    .orderBy("publishedDate", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            String ID = snapshot.data!.docs[index].id;
                            return Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 206, 205, 205),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Text("العنوان: "),
                                              Text(
                                                "${snapshot.data!.docs[index]['foodTitle']}",
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Delete(ID);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: takeDrug.BackgroundColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'الوصف: ',
                                          ),
                                          Text(
                                            snapshot.data!
                                                .docs[index]['foodDescription']
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'تاريخ الرفع: ',
                                              ),
                                              Text(
                                                snapshot
                                                    .data!
                                                    .docs[index]
                                                        ['publishedDate']
                                                    .toString(),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Route route =
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                EditGoodPractice(
                                                                    ID: ID));
                                                    Navigator.push(
                                                        context, route);
                                                  },
                                                  child: Text("تعديل"))
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Delete Suggestions
  Delete(String certificateID) async {
    showDialog(
      context: context,
      builder: (_) => const LoadingAlertDialog(message: "حذف"),
    );
    await takeDrug.firebaseFirestore!
        .collection("goodPractice")
        .doc(certificateID)
        .delete();
    Navigator.pop(context);
  }
}