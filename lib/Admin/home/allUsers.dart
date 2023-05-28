import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as dateFixing;
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/config/config.dart';

class allUsers extends StatefulWidget {
  const allUsers({super.key});

  @override
  State<allUsers> createState() => _allUsers();
}

// This Page will show The User Donations
class _allUsers extends State<allUsers> {
  User? user = takeDrug.auth!.currentUser;
  @override
  Widget build(BuildContext context) {
    String currentUser = user!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text("All_users".tr().toString()),
        centerTitle: true,
      ),
      body: displayTimeSlot(context),
    );
  }

  // Date
  displayTimeSlot(BuildContext context) {
    // var module = Provider.of<donateBloodModule>(context);
    return Column(
      children: [
        Container(
          child: Row(
            children: [],
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: takeDrug.firebaseFirestore!
                .collection("users")
                .where("type", isNotEqualTo: "admin")
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
                        String imageGetting =
                            snapshot.data!.docs[index]['ImageURL'];

                        String userStatus =
                            snapshot.data!.docs[index]['status'].toString();
                        String userUID = snapshot.data!.docs[index].id;

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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              imageGetting.length > 5
                                  ? CircleAvatar(
                                      backgroundColor: Colors.black12,
                                      backgroundImage:
                                          NetworkImage(imageGetting),
                                      radius: 50,
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: Colors.black12,
                                      radius: 50,
                                    ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("name".tr().toString()),
                                      Text(
                                        "${snapshot.data!.docs[index]['firstName']}",
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'email_'.tr().toString(),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['email']
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "phone_number_".tr().toString(),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['phoneNumber']
                                        .toString(),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'account_status'.tr().toString(),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['status']
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: userStatus == "active"
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'account_was_creted_on'.tr().toString(),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['registedOn']
                                        .toString(),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      activateAccount(userUID);
                                    },
                                    child: Text("activate".tr().toString()),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      disActivateAccount(userUID);
                                    },
                                    child: Text("Deactivate".tr().toString()),
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
    );
  }

  showImage(image) {
    return showDialog(
      context: context,
      builder: (contextd) => AlertDialog(
        content: Container(
          child: Image.network(image),
        ),
      ),
    );
  }

// accept functoin
  activateAccount(String uid) async {
    showDialog(
      context: context,
      builder: (_) =>
          LoadingAlertDialog(message: "activating_account".tr().toString()),
    );
    await takeDrug.firebaseFirestore!.collection("users").doc(uid).update({
      "status": "active",
    });
    Navigator.pop(context);
  }

  // accept functoin
  disActivateAccount(String uid) async {
    showDialog(
      context: context,
      builder: (_) =>
          LoadingAlertDialog(message: "deactivate_the_account".tr().toString()),
    );
    await takeDrug.firebaseFirestore!.collection("users").doc(uid).update({
      "status": "notActive",
    });
    Navigator.pop(context);
  }
}
