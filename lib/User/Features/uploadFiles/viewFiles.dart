import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:take_drug/Common/Authentication/login.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/User/Features/uploadFiles/uploadFiles.dart';

class viewFiles extends StatefulWidget {
  const viewFiles({super.key});

  @override
  State<viewFiles> createState() => _viewFiles();
}

// This Page will show The User Donations
class _viewFiles extends State<viewFiles> {
  String? _taskId;
  String? _localPath;
  // this is for the logged in user
  User? user = takeDrug.auth?.currentUser;
  bool? userIsLoggedIn = false;

  @override
  void initState() {
    checkIfUserIsLoggedIN();
    super.initState();
  }

  checkIfUserIsLoggedIN() {
    String? currentUserChecking = user?.uid;
    if (currentUserChecking != null) {
      setState(() {
        userIsLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? currentUser = user?.uid;
    return Scaffold(
      floatingActionButton: userIsLoggedIn == true
          ? FloatingActionButton(
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: (_) => FileUploadScreen());
                Navigator.push(context, route);
              },
              child: const Icon(Icons.upload),
            )
          : Container(),
      appBar: AppBar(
        title: Text("all_files".tr().toString()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          userIsLoggedIn == true
              ? Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: takeDrug.firebaseFirestore!
                        .collection("filesUploaded")
                        .where("userUploadedUID", isEqualTo: currentUser)
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
                                String deleteID = snapshot.data!.docs[index].id;
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
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("from".tr().toString()),
                                                  Text(
                                                    "${snapshot.data!.docs[index]['FullName']}",
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "file_type".tr().toString(),
                                                  ),
                                                  Text(
                                                    snapshot.data!
                                                        .docs[index]['fileType']
                                                        .toString(),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "date_uploaded"
                                                        .tr()
                                                        .toString(),
                                                  ),
                                                  Text(
                                                    snapshot.data!
                                                        .docs[index]['DateTime']
                                                        .toString(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    IconButton(
                                                      color: takeDrug
                                                          .BackgroundColor,
                                                      onPressed: () {
                                                        delete(deleteID);
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      downloadFile(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['fileURL'],
                                                      );
                                                    },
                                                    child: Text(
                                                      "download"
                                                          .tr()
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
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
                            "you_need_to_login".tr().toString(),
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
    );
  }

  delete(String UID) async {
    showDialog(
      context: context,
      builder: (_) => LoadingAlertDialog(
        message: "حذف المف",
      ),
    );
    await takeDrug.firebaseFirestore!
        .collection("filesUploaded")
        .doc(UID)
        .delete();
    Navigator.pop(context);
  }

  downloadFile(String url) async {
    showDialog(
      context: context,
      builder: (_) => const LoadingAlertDialog(
        message: "...تحميل",
      ),
    );
    FileDownloader.downloadFile(
        url: url,
        onProgress: (String? fileName, double progress) {
          print('FILE fileName HAS PROGRESS $progress');
        },
        onDownloadCompleted: (String path) {
          Navigator.pop(context);
          const snackBar = SnackBar(
            content: Text('تم التحميل'),
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        onDownloadError: (String error) {
          print('DOWNLOAD ERROR: $error');
        });
  }

  //You can download a single file

  // showImage(image) {
  //   return showDialog(
  //     context: context,
  //     builder: (contextd) => AlertDialog(
  //       content: Container(
  //         child: Image.network(image),
  //       ),
  //     ),
  //   );
  // }

  // accept functoin
  // downloadFile(String certificateID) async {
  // showDialog(
  //   context: context,
  //   builder: (_) => LoadingAlertDialog(message: "Rejecting Certificate"),
  // );
  // await takeDrug.firebaseFirestore!
  //     .collection("users")
  //     .doc(certificateID)
  //     .update({
  //   "proofeStatus": "Rejected",
  // });
  // Navigator.pop(context);
}
