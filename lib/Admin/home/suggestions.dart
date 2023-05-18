import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as dateFixing;
import 'package:take_drug/Admin/home/widgets/adminDrawer.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/Widgets/Drawer.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/User/Features/suggestions/uploadSuggestions.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({super.key});

  @override
  State<Suggestions> createState() => _Suggestions();
}

class _Suggestions extends State<Suggestions> {
  String currentUser = takeDrug.auth!.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("جميع الاقتراحات والشكاوي"),
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
                    .collection("suggestions")
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
                            String suggestionsID =
                                snapshot.data!.docs[index].id;
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
                                              const Text("الموضوع: "),
                                              Text(
                                                "${snapshot.data!.docs[index]['suggestionsTitle']}",
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              DeletectSuggestions(
                                                  suggestionsID);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: takeDrug.BackgroundColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'الوصف: ',
                                          ),
                                          Text(
                                            snapshot.data!
                                                .docs[index]['longDescription']
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'تاريخ الارسال: ',
                                          ),
                                          Text(
                                            snapshot.data!
                                                .docs[index]['publishedDate']
                                                .toString(),
                                          ),
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
  DeletectSuggestions(String certificateID) async {
    showDialog(
      context: context,
      builder: (_) => const LoadingAlertDialog(message: "حذف الاقتراح"),
    );
    await takeDrug.firebaseFirestore!
        .collection("suggestions")
        .doc(certificateID)
        .delete();
    Navigator.pop(context);
  }
}
