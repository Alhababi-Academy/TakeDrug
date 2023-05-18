import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:take_drug/Admin/home/adminHomePage.dart';
import 'package:take_drug/Common/DialogBox/errorDialog.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/Widgets/customTextFieldRegisterPage.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:intl/intl.dart' as DateInt;
import 'package:take_drug/User/Features/suggestions/viewSugesstions.dart';

class MedicalInfomration extends StatefulWidget {
  const MedicalInfomration({super.key});

  @override
  State<MedicalInfomration> createState() => _MedicalInfomration();
}

class _MedicalInfomration extends State<MedicalInfomration> {
  String uploadImageUrl = "";
  final TextEditingController MedicalDescription = TextEditingController();

  String name =
      "${takeDrug.sharedPreferences!.getString(takeDrug.FristNameUser)} ${takeDrug.sharedPreferences!.getString(takeDrug.SecondNameUser)}";

  final TextEditingController MedicalTitle = TextEditingController();

  final List<String> medicalTypeEach = [
    'كبار السن',
    'غير الحامل',
    'الحامل',
    'الكل'
  ];
  String? medicalEach;
  final ImagePicker _imagePicker = ImagePicker();
  XFile? imageXFile;
  String? imageUrl;

  XFile? imageXFileProofe;
  String? imageUrlProofe;

  Future uploadImage() async {
    imageXFileProofe =
        (await _imagePicker.pickImage(source: ImageSource.gallery))!;
    setState(() {
      imageXFileProofe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
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
                          "اضافة معلومات طبية",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: takeDrug.BackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 12.0)),
                        // ListTile(
                        //   leading: Icon(
                        //     Icons.money,
                        //     color: takeDrug.BackgroundColor,
                        //   ),
                        //   title: SizedBox(
                        //     width: 250.0,
                        //     child: TextField(
                        //       style:
                        //           TextStyle(color: takeDrug.BackgroundColor),
                        //       controller: suggestionsTitle,
                        //       decoration: const InputDecoration(
                        //         hintText: "عنوان الغذاء",
                        //         hintStyle: TextStyle(color: Colors.grey),
                        //         border: InputBorder.none,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "العنوان",
                            style: TextStyle(
                              color: takeDrug.BackgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        customTextFieldRegsiterPage(
                          isSecure: false,
                          enabledEdit: true,
                          prefixIcon: Icon(
                            Icons.title,
                            color: takeDrug.BackgroundColor,
                          ),
                          textEditingController: MedicalTitle,
                          textInputType: TextInputType.text,
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "الوصف",
                          style: TextStyle(
                            color: takeDrug.BackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        customTextFieldRegsiterPage(
                          isSecure: false,
                          enabledEdit: true,
                          prefixIcon: Icon(
                            Icons.type_specimen,
                            color: takeDrug.BackgroundColor,
                          ),
                          textEditingController: MedicalDescription,
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, right: 45, left: 45),
                          child: Column(
                            children: [
                              Text(
                                "رفع صورة",
                                style: TextStyle(
                                  color: takeDrug.BackgroundColor,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  uploadImage();
                                },
                                child: Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: imageXFileProofe == null
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(
                                              255, 214, 214, 214),
                                        )
                                      : BoxDecoration(
                                          image: DecorationImage(
                                            image: FileImage(
                                              File(imageXFileProofe!.path),
                                            ),
                                          ),
                                        ),
                                  child: Icon(
                                    Icons.upload,
                                    color: takeDrug.BackgroundColor,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ListTile(
                        //   leading: Icon(
                        //     Icons.description,
                        //     color: takeDrug.BackgroundColor,
                        //   ),
                        //   title: const SizedBox(
                        //     // child: TextField(
                        //     //   style:
                        //     //       TextStyle(color: takeDrug.BackgroundColor),
                        //     //   controller: suggestionsDescription,
                        //     //   decoration: const InputDecoration(
                        //     //     hintText: "وصف الاقتراح",
                        //     //     hintStyle: TextStyle(color: Colors.grey),
                        //     //     border: InputBorder.none,
                        //     //   ),
                        //     // ),
                        //     child: TextField(
                        //       maxLines: 3, // Allows for unlimited lines of text
                        //       keyboardType: TextInputType
                        //           .multiline, // Shows the multiline keyboard
                        //       decoration: InputDecoration(
                        //         hintText: "وصف الاقتراح",
                        //         border:
                        //             OutlineInputBorder(), // Adds an outline border
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Text(
                          "الفئة",
                          style: TextStyle(
                            color: takeDrug.BackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: DropdownButton<String>(
                            value: medicalEach,
                            isDense: true,
                            underline: const Text(""),
                            style: TextStyle(
                              color: takeDrug.BackgroundColor,
                              fontWeight: FontWeight.bold,
                            ),
                            items: medicalTypeEach.map(medicalType).toList(),
                            iconSize: 20,
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: takeDrug.BackgroundColor,
                            ),
                            onChanged: (value) =>
                                setState(() => medicalEach = value),
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
                            width: 100,
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text(
                                  "اضافة",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
      ),
    );
  }

  // For drop Down Menu
  DropdownMenuItem<String> medicalType(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      );

  saveItemInfo() async {
    MedicalTitle.text.isNotEmpty &&
            MedicalDescription.text.isNotEmpty &&
            medicalEach!.isNotEmpty
        ? savingImage()
        : const errorDialog(message: "عدم ترك الحقل فارغ");
  }

  savingImage() async {
    String imageName = DateTime.now().microsecondsSinceEpoch.toString();

    if (imageXFileProofe != null) {
      Reference reference = takeDrug.firebaseStorage!
          .ref()
          .child("medicalInformation")
          .child(imageName);
      UploadTask uploadTask = reference.putFile(File(imageXFileProofe!.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((imageUrll) {
        imageUrl = imageUrll;
      });
      savingData();
    }
  }

  savingData() async {
    showDialog(
      context: context,
      builder: (_) => const LoadingAlertDialog(
        message: "حفظ",
      ),
    );
    final User? user = takeDrug.auth?.currentUser;
    final uid = user!.uid;
    final itemsRef =
        await FirebaseFirestore.instance.collection("medicalInformation").add({
      "foodTitle": MedicalTitle.text.trim(),
      "foodDescription": MedicalDescription.text.trim(),
      "publishedDate":
          DateInt.DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
      "uid": uid,
      "byAdmin": name.toString(),
      "medicalType": "medicalInformation",
      "catagories": medicalEach,
      "imageUrl": imageUrl ?? "noImage",
    }).then((value) {
      Navigator.pop(context);
      Route route = MaterialPageRoute(builder: (_) => adminHomePage());
      Navigator.push(context, route);
    });
  }
}