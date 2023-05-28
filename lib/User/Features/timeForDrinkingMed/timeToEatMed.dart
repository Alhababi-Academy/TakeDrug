import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Common/Authentication/myProfile.dart';
import 'package:take_drug/Common/Widgets/Drawer.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/User/Features/timeForDrinkingMed/timeToEatDetails.dart';

class timeToEatUser extends StatefulWidget {
  const timeToEatUser({super.key});

  @override
  State<timeToEatUser> createState() => _timeToEatUser();
}

class _timeToEatUser extends State<timeToEatUser> {
  List<NotificationModel> alarmsWithRepeat = [];

  @override
  Widget build(BuildContext context) {
    Stream<List<NotificationModel>> getNotificationsStream() async* {
      // Replace this with your logic for fetching the list of notifications
      List<NotificationModel> notifications =
          await AwesomeNotifications().listScheduledNotifications();
      yield notifications;
    }

    String? currentUser = takeDrug.auth?.currentUser?.uid;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Route route =
              MaterialPageRoute(builder: (_) => const timeToEatDetails());
          Navigator.push(context, route);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: takeDrug.BackgroundColor,
        title: Column(
          children: [
            Text(
              "Medication_times".tr().toString(),
            ),
          ],
        ),
        centerTitle: true,
      ),
      endDrawer: currentUser != null ? UserDrawer() : null,
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
                        print("this is the day${gettingSchduleData!['day']}");
                        bool reapet = gettingSchduleData['repeats'];
                        print(reapet);
                        String theYear =
                            "${gettingSchduleData['year'].toString()}-${gettingSchduleData['month'].toString()}-${gettingSchduleData['day'].toString()}";

                        if (reapet = true) {
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
                                        const Divider(
                                          height: 2,
                                          color: Colors.black,
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
                                                      "alarm_time"
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
                                  child: snapshot.data![index].content!
                                              .bigPicture !=
                                          null
                                      ? Image.network(
                                          snapshot
                                              .data![index].content!.bigPicture
                                              .toString(),
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                          );
                        }
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
