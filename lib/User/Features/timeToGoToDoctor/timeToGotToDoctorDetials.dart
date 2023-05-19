import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:take_drug/Common/Authentication/myProfile.dart';
import 'package:take_drug/Common/DialogBox/errorDialog.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/Widgets/Drawer.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/services/notificationsServices.dart';
import 'package:intl/intl.dart' as dateDate;

class timeToGotToDoctorDetials extends StatefulWidget {
  const timeToGotToDoctorDetials({super.key});

  @override
  State<timeToGotToDoctorDetials> createState() => _timeToGotToDoctorDetials();
}

class _timeToGotToDoctorDetials extends State<timeToGotToDoctorDetials> {
  TextEditingController titleOfTheAlarm = TextEditingController();
  TextEditingController DetialsfTheAlarm = TextEditingController();

  bool? eachDay;
  // for images
  XFile? ImageXFile;
  File? imageGetting;
  ImagePicker _picker = ImagePicker();
  String? ImageUrl;

  // For The Date and Time
  String? _setTime, _setDate;
  String? _hour, _minute, _time;
  String? dateTime;
  DateTime? selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

// for the count
  int _count = 1;

  final List<bool> _isChecked = List<bool>.filled(7, false);
  String? currentUser = takeDrug.auth?.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: takeDrug.BackgroundColor,
        // actions: [
        //   GestureDetector(
        //     onTap: () {
        //       Route route =
        //           MaterialPageRoute(builder: (_) => const MyProfile());
        //       Navigator.push(context, route);
        //     },
        //     child: Column(
        //       children: [
        //         const Icon(
        //           Icons.person_2_rounded,
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             Navigator.pop(context);
        //           },
        //           child: Row(
        //             children: const [
        //               Text(
        //                 "رجوع",
        //                 style: TextStyle(fontWeight: FontWeight.bold),
        //               ),
        //               SizedBox(
        //                 width: 5,
        //               ),
        //               SizedBox(
        //                 height: 30,
        //               ),
        //               Icon(
        //                 Icons.arrow_forward,
        //               ),
        //             ],
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ],
        title: Column(
          children: [
            Text("Add_a_medical_appointment".tr().toString()),
          ],
        ),
        centerTitle: true,
      ),
      drawer: currentUser != null ? UserDrawer() : null,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(10),
          child: Container(
            margin:
                const EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
              boxShadow: const [
                // BoxShadow(
                //   color: Colors.grey.withOpacity(0.5), // shadow color
                //   spreadRadius: 5, // spread radius
                //   blurRadius: 7, // blur radius
                //   offset: Offset(0, 3), // changes position of shadow
                // ),
              ],
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    TextField(
                      controller: titleOfTheAlarm,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.local_offer,
                          color: takeDrug.BackgroundColor,
                          size: 18,
                        ),
                        hintText: "dentist".tr().toString(),
                        hintStyle: const TextStyle(fontSize: 13),
                      ),
                    ),
                    TextField(
                      controller: DetialsfTheAlarm,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.local_offer,
                          color: takeDrug.BackgroundColor,
                          size: 18,
                        ),
                        hintText: "go_to_doctor".tr().toString(),
                        hintStyle: const TextStyle(fontSize: 13),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: takeDrug.BackgroundColor,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "date_for_appointment".tr().toString(),
                                style: TextStyle(fontSize: 13),
                              ),
                              Text(
                                  "${selectedDate.toString().substring(0, 10)}"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.watch,
                                color: takeDrug.BackgroundColor,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "appointment_time".tr().toString(),
                                style: TextStyle(fontSize: 13),
                              ),
                              Text(
                                  "${selectedTime.hour}:${selectedTime.minute}"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _selectDate(context);
                                },
                                child: (Text(
                                  "pick_date_and_time".tr().toString(),
                                )),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 2,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.image,
                                color: takeDrug.BackgroundColor,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Notice_image".tr().toString(),
                                style: TextStyle(fontSize: 13),
                              ),
                              GestureDetector(
                                onTap: () {
                                  pickingImageFromGallery();
                                },
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        right: 4, left: 4),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.lightBlue[50],
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10),
                                      child: Text("upload".tr().toString()),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          imageGetting != null
                              ? Text(imageGetting!.path)
                              : Container()
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        showD();
                      },
                      child: Text(
                        "cancel".tr().toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        saveDate();
                      },
                      child: Text(
                        "save".tr().toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    print(selectedDate);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 90),
      ),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        print(selectedDate);

        _selectTime(context, _setDate);
      });
    }
  }

  Future<Null> _selectTime(BuildContext context, _setDate) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(
        () {
          selectedTime = picked;
        },
      );
    }
  }

  showD() async {
    print(await AwesomeNotifications().listScheduledNotifications());
  }

  // Picking Image
  pickingImageFromGallery() async {
    // var providerPage = Provider.of<postPageProvider>(context, listen: false);
    ImageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageGetting = File(ImageXFile!.path);
    });
  }

  saveDate() {
    for (var element in _isChecked) {
      setState(() {
        eachDay = element;
      });
    }
    titleOfTheAlarm.text.isNotEmpty &&
            DetialsfTheAlarm.text.isNotEmpty &&
            eachDay != false
        ? showError()
        : uploadToDatbase();
  }

  showError() {
    showDialog(
      context: context,
      builder: (_) => errorDialog(
        message: "fill_up_the_form".tr().toString(),
      ),
    );
  }

  uploadToDatbase() async {
    showDialog(
      context: context,
      builder: (_) => LoadingAlertDialog(
        message: "Add_a_medical_appointment".tr().toString(),
      ),
    );
    if (ImageXFile != null) {
      String imageName = DateTime.now().microsecondsSinceEpoch.toString();
      Reference reference = takeDrug.firebaseStorage!
          .ref()
          .child("profileImages")
          .child(imageName);
      UploadTask uploadTask = reference.putFile(
        File(imageGetting!.path),
      );
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((SavedIMageUrl) {
        ImageUrl = SavedIMageUrl;
      });
    }

    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => errorDialog(
        message: "done_adding_appointment".tr().toString(),
      ),
    );
    // To Add Notifications

    await NotificationService.showNotification(
      bigPicture: ImageUrl,
      title: titleOfTheAlarm.text,
      body: DetialsfTheAlarm.text,
      scheduled: true,
      interval: false,
      forMedical: true,
      notificationCalendar: NotificationCalendar(
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        year: selectedDate?.year,
        allowWhileIdle: true,
        month: selectedDate?.month,
        day: selectedDate?.day,
        repeats: false,
        preciseAlarm: true,
        hour: selectedTime.hour,
        minute: selectedTime.minute,
      ),
    );

    setState(() {
      // titleOfTheAlarm.text = "";
      // DetialsfTheAlarm.text = "";
      // for (int i = 0; i < _isChecked.length; i++) {
      //   _isChecked[i] = false;
      // }
    });
  }
}
