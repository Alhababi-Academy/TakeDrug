import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:take_drug/Common/DialogBox/errorDialog.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/Widgets/Drawer.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/services/notificationsServices.dart';
import 'package:intl/intl.dart' as dateDate;

class timeToEatDetails extends StatefulWidget {
  const timeToEatDetails({super.key});

  @override
  State<timeToEatDetails> createState() => _timeToEatDetails();
}

class _timeToEatDetails extends State<timeToEatDetails> {
  TextEditingController titleOfTheAlarm = TextEditingController();
  TextEditingController DetialsfTheAlarm = TextEditingController();

  final minDateTime = DateTime.now();
  // each day
  bool? eachDay;
  // for images
  XFile? ImageXFile;
  File? imageGetting;
  final ImagePicker _picker = ImagePicker();
  String? ImageUrl;

  // For The Date and Time
  DateTime? selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  String? currentUser = takeDrug.auth?.currentUser?.uid;

  final List<String> _days = [
    'sunday'.tr().toString(),
    'monday'.tr().toString(),
    'tuesday'.tr().toString(),
    'wednesday'.tr().toString(),
    'thursday'.tr().toString(),
    'friday'.tr().toString(),
    'saturday'.tr().toString(),
  ];

  final List<bool> _isChecked = List<bool>.filled(7, false);

// for the count
  final int _count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: takeDrug.BackgroundColor,
        title: Text(
          "Add_a_medication_alert".tr().toString(),
        ),
        centerTitle: true,
      ),
      endDrawer: currentUser != null ? UserDrawer() : null,
      body: SingleChildScrollView(
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
              boxShadow: const [],
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
                        hintText: "drink_ansolin".tr().toString(),
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
                        hintText: "drink_med_details".tr().toString(),
                        hintStyle: const TextStyle(fontSize: 13),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          Container(
                            height: 220,
                            child: ListView.builder(
                              itemCount: _days.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      height: 20,
                                      child: Checkbox(
                                        value: _isChecked[index],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _isChecked[index] = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      _days[index],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const Divider(
                            height: 2,
                            color: Colors.black,
                          ),
                          Container(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
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
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    Text(
                                        "${selectedTime.hour}:${selectedTime.minute}"),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        _selectTime();
                                      },
                                      child: Text(
                                          "pick_date_and_time".tr().toString()),
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
                                style: const TextStyle(fontSize: 13),
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
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
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
                        Navigator.pop(context);
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

  Future<Null> _selectTime() async {
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
    if (titleOfTheAlarm.text.isNotEmpty && DetialsfTheAlarm.text.isNotEmpty) {
      for (int i = 0; i < _days.length; i++) {
        String day = _days[i];
        bool isChecked = _isChecked[i];
        if (isChecked) {
          print('$day is checked');
          return uploadToDatbase();
        }
      }
    } else {
      showError();
    }
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
    // taking the finaling selected time for the alarm
    final newSelectedDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      selectedTime.hour,
      selectedTime.minute,
    );
    if (newSelectedDate.isBefore(minDateTime)) {
      showDialog(
        context: context,
        builder: (_) => errorDialog(
          message: "time_choosed_should_be_above_20_mintures".tr().toString(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => LoadingAlertDialog(
          message: "Add_a_medication_alert".tr().toString(),
        ),
      );
      if (ImageXFile != null) {
        String imageName = DateTime.now().microsecondsSinceEpoch.toString();
        Reference reference =
            takeDrug.firebaseStorage!.ref().child("alamr").child(imageName);
        UploadTask uploadTask = reference.putFile(
          File(imageGetting!.path),
        );
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        await taskSnapshot.ref.getDownloadURL().then((SavedIMageUrl) {
          ImageUrl = SavedIMageUrl;
          print(ImageUrl);
        });
      }

      await NotificationService.showNotification(
        bigPicture: ImageUrl,
        title: titleOfTheAlarm.text,
        body: DetialsfTheAlarm.text,
        scheduled: true,
        interval: false,
        notificationCalendar: NotificationCalendar(
          timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
          hour: selectedTime.hour,
          minute: selectedTime.minute,
          year: DateTime.now().year,
          day: DateTime.now().day,
          allowWhileIdle: true,
          month: DateTime.now().month,
          repeats: true,
          preciseAlarm: true,
        ),
      ).then((value) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (_) => errorDialog(
            message: "done_adding_alarm".tr().toString(),
          ),
        );
      });
    }
  }
}
