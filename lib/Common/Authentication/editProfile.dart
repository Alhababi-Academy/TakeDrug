import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Common/DialogBox/errorDialog.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/Widgets/customTextFieldRegisterPage.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:take_drug/User/UserHomePage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String currentUser = takeDrug.auth!.currentUser!.uid;
  TextEditingController FristName = TextEditingController();
  TextEditingController SecondName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController _SecondName = TextEditingController();
  TextEditingController _FristName = TextEditingController();
  TextEditingController age = TextEditingController();

  String? name = takeDrug.sharedPreferences!
      .getString("${takeDrug.FristNameUser} ${takeDrug.SecondNameUser}");

  XFile? ImageXFile;
  File? imageGetting;
  ImagePicker _picker = ImagePicker();
  String? profileImage;

// frist thing to runf
  @override
  void initState() {
    // First thing that it runs
    GettingData();
    super.initState();
  }

  GettingData() async {
    await takeDrug.firebaseFirestore!
        .collection("users")
        .doc(currentUser)
        .get()
        .then((result) {
      setState(() {
        FristName.text = result.data()!['firstName'];
        SecondName.text = result.data()!['secondName'];
        phoneNumber.text = result.data()!['phoneNumber'];
        age.text = result.data()!['age'].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: takeDrug.BackgroundColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Route route = MaterialPageRoute(
                                  builder: (_) => const UserHomePage());
                              Navigator.pushAndRemoveUntil(
                                  context, route, (route) => false);
                            },
                            icon: Icon(
                              Icons.home,
                              color: takeDrug.BackgroundColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "الملف الشخصي",
                      style: TextStyle(
                        color: Color(0XFF00213F),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: const Color(0XFFD9D9D9),
                                backgroundImage: ImageXFile == null
                                    ? null
                                    : FileImage(File(ImageXFile!.path)),
                                child: ImageXFile == null
                                    ? Icon(
                                        Icons.add_photo_alternate,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.20,
                                        color: Colors.grey,
                                      )
                                    : null,
                              ),
                              Positioned(
                                bottom: 10,
                                right: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color.fromARGB(
                                          255, 198, 197, 197)),
                                  child: IconButton(
                                    onPressed: () {
                                      pickingImageFromGallery();
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${takeDrug.sharedPreferences!.getString(takeDrug.FristNameUser)} ${takeDrug.sharedPreferences!.getString(takeDrug.SecondNameUser)}",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 15, left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("الاسم الاول"),
                            customTextFieldRegsiterPage(
                              isSecure: false,
                              enabledEdit: true,
                              prefixIcon: Icon(
                                Icons.person,
                                color: takeDrug.BackgroundColor,
                              ),
                              textEditingController: FristName,
                              textInputType: TextInputType.text,
                              hint: "lena",
                            ),
                            const Text("الاسم الثاني"),
                            customTextFieldRegsiterPage(
                              isSecure: false,
                              enabledEdit: true,
                              prefixIcon: Icon(
                                Icons.person,
                                color: takeDrug.BackgroundColor,
                              ),
                              textEditingController: SecondName,
                              textInputType: TextInputType.text,
                              hint: "mohammed",
                            ),
                            const Text("العمر"),
                            customTextFieldRegsiterPage(
                              isSecure: false,
                              enabledEdit: true,
                              prefixIcon: Icon(
                                Icons.man,
                                color: takeDrug.BackgroundColor,
                              ),
                              textEditingController: age,
                              textInputType: TextInputType.phone,
                              hint: "28",
                            ),
                            const Text(" الرقم"),
                            customTextFieldRegsiterPage(
                              isSecure: false,
                              enabledEdit: true,
                              prefixIcon: Icon(
                                Icons.phone,
                                color: takeDrug.BackgroundColor,
                              ),
                              textEditingController: phoneNumber,
                              textInputType: TextInputType.phone,
                              hint: "0554545834",
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // checkUsers();
                          updatingData();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            takeDrug.BackgroundColor,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                30.0,
                              ),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                right: 25, left: 25, top: 7, bottom: 7),
                          ),
                        ),
                        child: const Text(
                          " تحديث",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     Route route = MaterialPageRoute(
                      //         builder: (_) => const EditAllergy());
                      //     Navigator.push(context, route);
                      //   },
                      //   child: Text(
                      //     "Edit Allergy Information?",
                      //     style: TextStyle(
                      //       color: takeDrug.primaryColor,
                      //     ),
                      //   ),
                      // ),
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

  // Picking Image
  pickingImageFromGallery() async {
    // var providerPage = Provider.of<postPageProvider>(context, listen: false);
    ImageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageGetting = File(ImageXFile!.path);
    });
  }

  checkingData() {
    _FristName.text.isNotEmpty && _SecondName.text.isNotEmpty
        ? updatingData()
        : showDialog(
            context: context,
            builder: (_) => const errorDialog(message: "رجا قم بملي البيانات"),
          );
  }

  Future updatingData() async {
    showDialog(
      context: context,
      builder: (c) => const LoadingAlertDialog(
        message: "حفظ البيانات",
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
        profileImage = SavedIMageUrl;
      });
    }

    User? user = takeDrug.auth!.currentUser;
    String uid = user!.uid;

    await takeDrug.firebaseFirestore!.collection("users").doc(uid).update({
      "firstName": FristName.text.trim(),
      "secondName": SecondName.text.trim(),
      "phoneNumber": phoneNumber.text.trim(),
      "ImageURL": profileImage ?? "",
      "age": age.text.trim(),
    }).then(
      (value) {
        Navigator.pop(context);
        takeDrug.sharedPreferences!
            .setString(takeDrug.FristNameUser, FristName.text.trim());
        takeDrug.sharedPreferences!
            .setString(takeDrug.SecondNameUser, SecondName.text.trim());

        if (profileImage != null) {
          takeDrug.sharedPreferences!
              .setString(takeDrug.profileImageUser, profileImage.toString());
        }
        showDialog(
          context: context,
          builder: (_) => const errorDialog(message: "تم تحديث البيانات"),
        );
      },
    );
  }
}
