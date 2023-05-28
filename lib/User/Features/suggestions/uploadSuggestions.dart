import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Common/DialogBox/errorDialog.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:intl/intl.dart' as DateInt;
import 'package:take_drug/User/Features/suggestions/viewSugesstions.dart';

class UploadSugestions extends StatefulWidget {
  const UploadSugestions({super.key});

  @override
  State<UploadSugestions> createState() => _UploadSugestions();
}

class _UploadSugestions extends State<UploadSugestions> {
  String uploadImageUrl = "";
  final TextEditingController suggestionsTitle = TextEditingController();

  String name =
      "${takeDrug.sharedPreferences!.getString(takeDrug.FristNameUser)} ${takeDrug.sharedPreferences!.getString(takeDrug.SecondNameUser)}";

  final TextEditingController suggestionsDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Text(
                        "add_complaint".tr().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: takeDrug.BackgroundColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 24),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 12.0)),
                      ListTile(
                        leading: Icon(
                          Icons.money,
                          color: takeDrug.BackgroundColor,
                        ),
                        title: SizedBox(
                          width: 250.0,
                          child: TextField(
                            style: TextStyle(color: takeDrug.BackgroundColor),
                            controller: suggestionsTitle,
                            decoration: InputDecoration(
                              hintText: "complaint_title".tr().toString(),
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.description,
                          color: takeDrug.BackgroundColor,
                        ),
                        title: SizedBox(
                          width: 250.0,
                          child: TextField(
                            style: TextStyle(color: takeDrug.BackgroundColor),
                            controller: suggestionsDescription,
                            decoration: InputDecoration(
                              hintText: "complaint_description".tr().toString(),
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xff0058A0),
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
                          saveItemInfo();
                        },
                        child: Container(
                          height: 45,
                          child: Center(
                            child: Text(
                              "add".tr().toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  clearFormInfo() {
    // Navigator.of(context).pushReplacementNamed();
    setState(() {
      suggestionsTitle.clear();
      suggestionsDescription.clear();
    });
  }

  saveItemInfo() async {
    suggestionsTitle.text.isNotEmpty && suggestionsDescription.text.isNotEmpty
        ? loadingDialog()
        : showDialog(
            context: context,
            builder: (_) => const errorDialog(
              message: "erro",
            ),
          );
  }

  loadingDialog() {
    showDialog(
      context: context,
      builder: (_) => LoadingAlertDialog(
        message: "upload_files".tr().toString(),
      ),
    );
    uploadeData();
  }

  uploadeData() async {
    String? user = takeDrug.auth?.currentUser?.uid;

    await FirebaseFirestore.instance.collection("suggestions").add({
      "suggestionsTitle": suggestionsTitle.text.trim(),
      "longDescription": suggestionsDescription.text.trim(),
      "publishedDate":
          DateInt.DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
      "uid": user,
      "name": name.toString(),
    }).then((value) {
      Navigator.pop(context);
      Route route = MaterialPageRoute(builder: (_) => ViewSugesstions());
      Navigator.push(context, route);
    });
  }
}
