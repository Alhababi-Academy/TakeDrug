import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:take_drug/Common/Authentication/myProfile.dart';
import 'package:take_drug/Common/DialogBox/errorDialog.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/Widgets/Drawer.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/services/notificationsServices.dart';

class timeToEatDetails extends StatefulWidget {
  const timeToEatDetails({super.key});

  @override
  State<timeToEatDetails> createState() => _timeToEatDetails();
}

class _timeToEatDetails extends State<timeToEatDetails> {
  TextEditingController titleOfTheAlarm = TextEditingController();
  TextEditingController DetialsfTheAlarm = TextEditingController();
  // for days
  final List<String> _days = [
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت'
  ];
  // time of the day
  TimeOfDay _time =
      TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 3)));
  // final minDateTime = DateTime.now().add(const Duration(minutes: 3));

  final minDateTime = DateTime.now();
  // each day
  bool? eachDay;
  // for images
  XFile? ImageXFile;
  File? imageGetting;
  ImagePicker _picker = ImagePicker();
  String? ImageUrl;

// for the count
  int _count = 1;

  final List<bool> _isChecked = List<bool>.filled(7, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: takeDrug.BackgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Route route =
                    MaterialPageRoute(builder: (_) => const MyProfile());
                Navigator.push(context, route);
              },
              child: Column(
                children: [
                  const Icon(
                    Icons.person_2_rounded,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: const [
                        Text(
                          "رجوع",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Icon(
                          Icons.arrow_forward,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
        title: Column(
          children: const [
            // Image.asset(
            //   "images/lightBlue.png",
            //   width: 50,
            // ),
            Text("اضافة تنبيه دواء")
          ],
        ),
        centerTitle: true,
      ),
      drawer: UserDrawer(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.all(10),
            child: Container(
              margin: const EdgeInsets.only(
                  right: 15, left: 15, top: 5, bottom: 10),
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
                          hintText: "عنوان المنبه: تناول دوا الانسولين",
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
                          hintText: " التفاصيل : تناول دوا الانسولين والتفاصيل",
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
                            Row(
                              children: [
                                Icon(
                                  Icons.watch,
                                  color: takeDrug.BackgroundColor,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  "اوقات التنبيه:",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
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
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.watch,
                                  color: takeDrug.BackgroundColor,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  "عدد المرات في اليوم:",
                                  style: TextStyle(fontSize: 13),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove,
                                        color: takeDrug.BackgroundColor,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (_count > 1) {
                                            _count--;
                                          }
                                        });
                                      },
                                    ),
                                    Text('$_count'),
                                    IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: takeDrug.BackgroundColor,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _count++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "المرة الاولى: ",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // showTimePicker(
                                        //   context: context,
                                        //   initialTime: _time,
                                        // ).then((value) {
                                        //   if (value != null) {
                                        //     setState(() {
                                        //       _time = value;
                                        //     });
                                        //   }
                                        // });
                                        showTimePicker(
                                          context: context,
                                          // initialTime: TimeOfDay.fromDateTime(
                                          //     DateTime.now().add(
                                          //         const Duration(minutes: 3))),
                                          initialTime: TimeOfDay.now(),
                                        ).then((selectedTime) {
                                          if (selectedTime != null) {
                                            final selectedDateTime = DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day,
                                              selectedTime.hour,
                                              selectedTime.minute,
                                            );
                                            // regular variable with addinoalt mintues

                                            // if (selectedDateTime
                                            //     .isBefore(minDateTime)) {
                                            //   ScaffoldMessenger.of(context)
                                            //       .showSnackBar(
                                            //     const SnackBar(
                                            //       content: Text(
                                            //           'الوقت المختار لابد ان يزيد عن ٢٠ دقيقة من الوقت الحالي'),
                                            //     ),
                                            //   );
                                            // } else {
                                            setState(() {
                                              _time = selectedTime;
                                            });
                                            // }
                                          }
                                        });
                                      },
                                      child: Text(
                                        '${_time}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
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
                        height: 15,
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
                                const Text(
                                  "صورة الاشعار: ",
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
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Text("تحميل"),
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
                        child: const Text(
                          "الغاء",
                          style: TextStyle(
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
                        child: const Text(
                          "حفظ",
                          style: TextStyle(
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
      ),
    );
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
      builder: (_) => const errorDialog(
        message: "قم بملى جميع الخيارات",
      ),
    );
  }

  uploadToDatbase() async {
    String currentUser = takeDrug.auth!.currentUser!.uid;
    // taking the finaling selected time for the alarm
    final newSelectedDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      _time.hour,
      _time.minute,
    );
    if (newSelectedDate.isBefore(minDateTime)) {
      showDialog(
        context: context,
        builder: (_) => const errorDialog(
          message: 'الوقت المختار لابد ان يزيد عن ٢٠ دقيقة من الوقت الحالي',
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => const LoadingAlertDialog(
          message: "اضافة تنبيه دواء",
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

      takeDrug.firebaseFirestore!.collection("medicineAlarm").add({
        "userUID": currentUser,
        'sunday': _isChecked[0],
        'monday': _isChecked[4],
        'tuesday': _isChecked[1],
        'wednesday': _isChecked[2],
        'thursday': _isChecked[3],
        'friday': _isChecked[4],
        'saturday': _isChecked[5],
        "imageUrl": ImageUrl,
        "HowManyTimes": _count,
        // "timeForFristAlarm":  Foramtt.DateFormat('HH:mm').format(_time as DateTime)
        "timeForFristAlarm": _time.format(context),
      }).then((value) async {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (_) => const errorDialog(
            message: "تم اضافة تنبيه",
          ),
        );
        // To Add Notifications

        await NotificationService.showNotification(
          bigPicture: ImageUrl,
          title: titleOfTheAlarm.text,
          body: DetialsfTheAlarm.text,
          scheduled: true,
          notificationCalendar: NotificationCalendar(
            timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
            hour: _time.hour,
            minute: _time.minute,
            year: DateTime.now().year,
            allowWhileIdle: true,
            month: DateTime.now().month,
          ),
        );
        setState(() {
          titleOfTheAlarm.text = "";
          DetialsfTheAlarm.text = "";
          for (int i = 0; i < _isChecked.length; i++) {
            _isChecked[i] = false;
          }
        });
      });
    }
  }
}
