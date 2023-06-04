import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/User/Features/Map/map.dart';

class hospitals extends StatefulWidget {
  @override
  _hospitalsState createState() => _hospitalsState();
}

class _hospitalsState extends State<hospitals> {
  final loc.Location location = loc.Location();


  User? user = FirebaseAuth.instance.currentUser;
  // for the search
  String searching = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hospitals"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('locations')
                  .where("type", isEqualTo: "hospital")
                  .orderBy('lat')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                var docs = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration:
                          BoxDecoration(color: takeDrug.BackgroundColor),
                      child: Column(
                        children: [
                          const Divider(
                            height: 5,
                          ),
                          ListTile(
                            isThreeLine: true,
                            title: Text(
                              docs[index]['name'].toString(),
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Container(),
                            dense: true,
                            iconColor: Colors.white,
                            trailing: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.map),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                newMyMap(docs[index].id),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
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
          ),
        ],
      ),
    );
  }
}
