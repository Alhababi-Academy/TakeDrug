import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as dateFixing;
import 'package:take_drug/Common/Authentication/login.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/Widgets/Drawer.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/User/Features/gmail/sendGmail.dart';
import 'package:take_drug/User/Features/suggestions/uploadSuggestions.dart';

class ViewSugesstions extends StatefulWidget {
  const ViewSugesstions({super.key});

  @override
  State<ViewSugesstions> createState() => _ViewSugesstions();
}

class _ViewSugesstions extends State<ViewSugesstions> {
  String? currentUser = takeDrug.auth?.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: currentUser != null
          ? FloatingActionButton(
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: (_) => const UploadSugestions());
                Navigator.push(context, route);
              },
              child: const Icon(
                Icons.send,
              ),
            )
          : Container(),
      appBar: AppBar(
        title: const Text("جميع الاقتراحات والشكاوي"),
        centerTitle: true,
      ),
      drawer: UserDrawer(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Container(
              child: Row(
                children: [],
              ),
            ),
            currentUser != null
                ? Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: takeDrug.firebaseFirestore!
                          .collection("suggestions")
                          .where("uid", isEqualTo: currentUser)
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
                                      color: const Color.fromARGB(
                                          255, 206, 205, 205),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                    color: takeDrug
                                                        .BackgroundColor,
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
                                                  snapshot
                                                      .data!
                                                      .docs[index]
                                                          ['longDescription']
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
                                                  snapshot
                                                      .data!
                                                      .docs[index]
                                                          ['publishedDate']
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
                  )
                : Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          takeDrug.whiteOne,
                        ),
                        shadowColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Route route =
                            MaterialPageRoute(builder: (_) => loginPage());
                        Navigator.pushAndRemoveUntil(
                            context, route, (route) => false);
                      },
                      child: Container(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'يجب تسجيل الدخول',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: takeDrug.BackgroundColor),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: takeDrug.BackgroundColor,
                            ),
                          ],
                        ),
                      ),
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
