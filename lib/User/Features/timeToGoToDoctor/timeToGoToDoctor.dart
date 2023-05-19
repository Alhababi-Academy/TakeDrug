import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Common/Authentication/myProfile.dart';
import 'package:take_drug/Common/Widgets/Drawer.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/User/Features/timeToGoToDoctor/timeToGotToDoctorDetials.dart';

class timeToGoToDoctor extends StatefulWidget {
  const timeToGoToDoctor({super.key});

  @override
  State<timeToGoToDoctor> createState() => _timeToGoToDoctor();
}

class _timeToGoToDoctor extends State<timeToGoToDoctor> {
  String? currentUser = takeDrug.auth?.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    Stream<List<NotificationModel>> getNotificationsStream() async* {
      List<NotificationModel> notifications =
          await AwesomeNotifications().listScheduledNotifications();
      yield notifications;
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Route route =
              MaterialPageRoute(builder: (_) => timeToGotToDoctorDetials());
          Navigator.push(context, route);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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
            // Image.asset(
            //   "images/lightBlue.png",
            //   width: 50,
            // ),
            Text("medical_time".tr().toString())
          ],
        ),
        centerTitle: true,
      ),
      endDrawer: currentUser != null ? UserDrawer() : null,
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       StreamBuilder<List<NotificationModel>>(
      //         stream: getNotificationsStream(),
      //         builder: (context, snapshot) {
      //           if (snapshot.hasData) {
      //             // Replace this with your own UI code for displaying the list of notifications
      //             return ListView.builder(
      //               shrinkWrap: true,
      //               itemCount: snapshot.data!.length,
      //               itemBuilder: (context, index) {
      //                 return ListTile(
      //                   title: Text(
      //                       snapshot.data![index].content!.title.toString()),
      //                 );
      //               },
      //             );
      //           } else if (snapshot.hasError) {
      //             return Text("Error: ${snapshot.error}");
      //           } else {
      //             return CircularProgressIndicator();
      //           }
      //         },
      //       )
      //     ],
      //   ),
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            StreamBuilder<List<NotificationModel>>(
              stream: getNotificationsStream(),
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
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic>? gettingSchduleData =
                            snapshot.data![index].schedule?.toMap();
                        int? notificationID = snapshot.data![index].content!.id;
                        // to check the lenght
                        print(gettingSchduleData!['day']);
                        String asdf =
                            "${gettingSchduleData['year'].toString()}-${gettingSchduleData['month'].toString()}-${gettingSchduleData['day'].toString()}";

                        if (gettingSchduleData['day'].toString().isNotEmpty) {
                          return Container(
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), // shadow color
                                  spreadRadius: 5, // spread radius
                                  blurRadius: 7, // blur radius
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.local_offer,
                                                  color:
                                                      takeDrug.BackgroundColor,
                                                  size: 15,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "alarm_address"
                                                          .tr()
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .content!.title
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_month,
                                                  color:
                                                      takeDrug.BackgroundColor,
                                                  size: 15,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "date_of_alarm"
                                                          .tr()
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${gettingSchduleData['year'].toString()}-${gettingSchduleData['month'].toString()}-${gettingSchduleData['day'].toString()}",
                                                    ),
                                                    // Text(snapshot
                                                    //     .data![index].schedule
                                                    //     .toString())
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.watch,
                                                  color:
                                                      takeDrug.BackgroundColor,
                                                  size: 15,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "date_of_alarm"
                                                          .tr()
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${gettingSchduleData['hour'].toString()}:${gettingSchduleData['minute'].toString()}",
                                                    ),
                                                    // Text(snapshot
                                                    //     .data![index].schedule
                                                    //     .toString())
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              AwesomeNotifications()
                                                  .cancel(
                                                int.parse(
                                                  snapshot
                                                      .data![index].content!.id
                                                      .toString(),
                                                ),
                                              )
                                                  .then((value) {
                                                setState(() {});
                                              });
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    snapshot.data![index].content!.bigPicture
                                        .toString(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return null;
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  showAlarms() async {
    List<NotificationModel> notifications = [];

    // String jsonExample =
    //     await AwesomeNotifications().listScheduledNotifications().toString();

    // print(jsonExample);

    // var asdf = dataa.forEach((element) {
    //   return element;
    // });
    // var asdfas = welcomeFromJson(dataa.forEach((element) {}));
  }
}
