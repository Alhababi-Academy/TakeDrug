import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Common/Authentication/login.dart';
import 'package:take_drug/Common/DialogBox/errorDialog.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/Widgets/customTextFieldRegisterPage.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:intl/intl.dart' as DateFormatting;

class ReigsterPage extends StatefulWidget {
  const ReigsterPage({super.key});

  @override
  State<ReigsterPage> createState() => _ReigsterPage();
}

enum Gender { male, female }

class _ReigsterPage extends State<ReigsterPage> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passworTextEditingController = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController secondName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  bool isSecureClicked = true;

  Gender _selectedGender = Gender.male;

  String NewDate = '';
  DateTime? selectedDate;
  int newAge = 0;

  final List<String> cites = [
    "الرياض",
    "جدة",
    "مكة المكرمة",
    "المدينة المنورة",
    "بريدة",
    "تبوك",
    "خميس مشيط",
    "حائل",
    "الطائف",
    "نجران",
    "ينبع",
    "أبها",
    "القنفذة",
    "الخرج",
    "الجبيل",
    "ضباء",
    "الظهران",
    "الخبر",
    "حفر الباطن",
    "الرس"
  ];

  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    // the start of widgets
    return Scaffold(
      backgroundColor: takeDrug.primaryNewColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 180,
                      child: Image.asset("images/lightBlue.png"),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Text(
                          "First_Name".tr().toString(),
                          style: TextStyle(
                            color: takeDrug.whiteTow,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      customTextFieldRegsiterPage(
                        isSecure: false,
                        enabledEdit: true,
                        prefixIcon: Icon(
                          Icons.person,
                          color: takeDrug.BackgroundColor,
                        ),
                        textEditingController: firstName,
                        textInputType: TextInputType.emailAddress,
                        hint: "First_Name".tr().toString(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Text(
                          "second_name".tr().toString(),
                          style: TextStyle(
                            color: takeDrug.whiteTow,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      customTextFieldRegsiterPage(
                        isSecure: false,
                        enabledEdit: true,
                        prefixIcon: Icon(
                          Icons.person,
                          color: takeDrug.BackgroundColor,
                        ),
                        textEditingController: secondName,
                        textInputType: TextInputType.emailAddress,
                        hint: "second_name".tr().toString(),
                      ),
                      Text(
                        "Gender".tr().toString(),
                        style: TextStyle(
                          color: takeDrug.whiteTow,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  activeColor: takeDrug.forthColor,
                                  selectedTileColor: takeDrug.forthColor,
                                  title: Text(
                                    "male".tr().toString(),
                                    style: TextStyle(
                                      color: takeDrug.whiteTow,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  value: Gender.male,
                                  dense: true,
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                  activeColor: takeDrug.forthColor,
                                  selectedTileColor: takeDrug.forthColor,
                                  title: Text(
                                    "girl".tr().toString(),
                                    style: TextStyle(
                                      color: takeDrug.whiteTow,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  value: Gender.female,
                                  dense: true,
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: Text(
                              "date_of_birth".tr().toString(),
                              style: TextStyle(
                                color: takeDrug.whiteTow,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _selectDate();
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      NewDate.length > 3
                                          ? NewDate.toString()
                                          : "pick_date".tr().toString(),
                                      style: TextStyle(
                                        color: takeDrug.forthColor,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xffB5D5FF),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.zero,
                                color: takeDrug.whiteTow,
                                width: 80,
                                height: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Text(
                          "email".tr().toString(),
                          style: TextStyle(
                            color: takeDrug.whiteTow,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      customTextFieldRegsiterPage(
                        isSecure: false,
                        enabledEdit: true,
                        prefixIcon: Icon(
                          Icons.email,
                          color: takeDrug.BackgroundColor,
                        ),
                        textEditingController: emailTextEditingController,
                        textInputType: TextInputType.emailAddress,
                        hint: "example@gmail.com",
                      ),
                      Text(
                        "password".tr().toString(),
                        style: TextStyle(
                          color: takeDrug.whiteTow,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      customTextFieldRegsiterPage(
                        isSecure: isSecureClicked,
                        enabledEdit: true,
                        textEditingController: passworTextEditingController,
                        textInputType: TextInputType.emailAddress,
                        hint: "123456789*",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: takeDrug.BackgroundColor,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(!isSecureClicked
                              ? Icons.visibility_off
                              : Icons.remove_red_eye),
                          color: takeDrug.BackgroundColor,
                          onPressed: () {
                            setState(() {
                              isSecureClicked = !isSecureClicked;
                            });
                          },
                        ),
                      ),
                      Text(
                        "City".tr().toString(),
                        style: TextStyle(
                          color: takeDrug.whiteTow,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: takeDrug.whiteOne,
                        ),
                        child: DropdownButton<String>(
                          value: selectedCity,
                          isDense: true,
                          style: TextStyle(
                            color: takeDrug.BackgroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                          items: cites.map(sectorDepartments).toList(),
                          isExpanded: true,
                          underline: const Text(""),
                          iconSize: 20,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: takeDrug.BackgroundColor,
                          ),
                          onChanged: (value) =>
                              setState(() => selectedCity = value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Text(
                          "phone_number".tr().toString(),
                          style: TextStyle(
                            color: takeDrug.whiteTow,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      customTextFieldRegsiterPage(
                        isSecure: false,
                        enabledEdit: true,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: takeDrug.BackgroundColor,
                        ),
                        textEditingController: phoneNumber,
                        textInputType: TextInputType.phone,
                        hint: "0555555555",
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          takeDrug.whiteOne,
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
                        validateData();
                      },
                      child: Container(
                        width: 100,
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "register_now".tr().toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: takeDrug.BackgroundColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "you_Have_Account".tr().toString(),
                          style: TextStyle(
                            color: takeDrug.whiteOne,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const loginPage(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              EdgeInsets.zero,
                            ),
                            minimumSize: MaterialStateProperty.all(
                              const Size(0, 0),
                            ),
                          ),
                          child: Text(
                            "click_here".tr().toString(),
                            style: TextStyle(
                              color: takeDrug.whiteTow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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

  // For drop Down Menu
  DropdownMenuItem<String> sectorDepartments(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      );

  // Show Date
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      // frist selected date
      initialDate: DateTime(DateTime.now().year - 50),
      // frist date to show
      firstDate: DateTime(DateTime.now().year - 101),
      lastDate: DateTime(DateTime.now().year),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        List<String> parts = selectedDate.toString().split(" ");
        NewDate = parts[0];
        // getting the year
        int selectedDateYear = selectedDate!.year;
        // getting the new date
        int newDate = selectedDateYear - DateTime.now().year;
        newAge = newDate.abs();
      });
    }
  }

  Future<void> validateData() async {
    firstName.text.isNotEmpty &&
            secondName.text.isNotEmpty &&
            emailTextEditingController.text.isNotEmpty &&
            passworTextEditingController.text.isNotEmpty &&
            Gender.values.isNotEmpty &&
            NewDate.isNotEmpty &&
            phoneNumber.text.isNotEmpty &&
            selectedCity!.isNotEmpty
        ? uploadToStorage()
        : displayDialog();
  }

  displayDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) {
        return errorDialog(
          message: "fill_up_the_form".tr().toString(),
        );
      },
    );
  }

  uploadToStorage() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "validating_data_please_wait".tr().toString(),
          );
        });
    // this is the function to start creating account
    _login();
  }

  String? currentUser;
  void _login() async {
    takeDrug.auth!
        .createUserWithEmailAndPassword(
            email: emailTextEditingController.text,
            password: passworTextEditingController.text)
        .then((auth) {
      currentUser = auth.user!.uid;
      saveUserInfoToFireStor(currentUser);
      // if error show
    }).catchError(
      (error) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (c) => errorDialog(
            message: error.toString(),
          ),
        );
      },
    );
  }

  Future saveUserInfoToFireStor(currentUser) async {
    await takeDrug.firebaseFirestore!
        .collection("users")
        .doc(currentUser.toString())
        .set(
      {
        "uid": currentUser.toString(),
        "firstName": firstName.text.trim(),
        "secondName": secondName.text.trim(),
        "email": emailTextEditingController.text.trim().toLowerCase(),
        "password": passworTextEditingController.text.trim(),
        "city": selectedCity!.trim().toString(),
        "age": newAge,
        "dateOfBrith": NewDate.trim().toString(),
        "phoneNumber": phoneNumber.text.trim(),
        "status": "active",
        "ImageURL": "",
        "gender": _selectedGender.name,
        "registedOn": DateFormatting.DateFormat('dd-mm-yyyy')
            .format(DateTime.now())
            .toString(),
        "type": "user",
      },
    ).then((value) {
      Navigator.pop(context);
      Route route = MaterialPageRoute(builder: (_) => const loginPage());
      Navigator.pushReplacement(context, route);
    });
  }
}
