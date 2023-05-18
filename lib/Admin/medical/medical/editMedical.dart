import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Admin/home/adminHomePage.dart';
import 'package:take_drug/Common/DialogBox/errorDialog.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/Widgets/customTextFieldRegisterPage.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:intl/intl.dart' as DateInt;
import 'package:take_drug/User/Features/suggestions/viewSugesstions.dart';

class editMedical extends StatefulWidget {
  final String ID;
  const editMedical({super.key, required this.ID});

  @override
  State<editMedical> createState() => _editMedical();
}

class _editMedical extends State<editMedical> {
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

  @override
  void initState() {
    GettingData();
    super.initState();
  }

  GettingData() async {
    await takeDrug.firebaseFirestore!
        .collection("medicalGuide")
        .doc(widget.ID)
        .get()
        .then((result) {
      setState(() {
        MedicalTitle.text = result.data()?['foodTitle'];
        MedicalDescription.text = result.data()?['foodDescription'];
        medicalEach = result.data()?['catagories'];
      });
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
                          "اضافة دليل الطبيب",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: takeDrug.BackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 12.0)),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "العنوان ",
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
        ? savingData()
        : const errorDialog(message: "عدم ترك الحقل فارغ");
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
    final itemsRef = await FirebaseFirestore.instance
        .collection("medicalGuide")
        .doc(widget.ID)
        .update({
      "foodTitle": MedicalTitle.text.trim(),
      "foodDescription": MedicalDescription.text.trim(),
      "catagories": medicalEach,
    }).then((value) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (_) => const errorDialog(
          message: "تم تحديث البيانات",
        ),
      ).then((value) {
        Route route = MaterialPageRoute(builder: (_) => adminHomePage());
        Navigator.push(context, route);
      });
    });
  }
}
