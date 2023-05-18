import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Map<int, Color> _primaryColor = {
  50: const Color(0XFF1A3EC1),
  100: const Color(0XFF1A3EC1),
  200: const Color(0XFF1A3EC1),
  300: const Color(0XFF1A3EC1),
  400: const Color(0XFF1A3EC1),
  500: const Color(0XFF1A3EC1),
  600: const Color(0XFF1A3EC1),
  700: const Color(0XFF1A3EC1),
  800: const Color(0XFF1A3EC1),
  900: const Color(0XFF1A3EC1),
};

class takeDrug {
  // firebase
  static FirebaseAuth? auth;
  static FirebaseStorage? firebaseStorage;
  static SharedPreferences? sharedPreferences;
  static FirebaseFirestore? firebaseFirestore;

  //  Users
  static const String FristNameUser = "FristNameUser";
  static const String SecondNameUser = "SecondNameUser";
  static const String UserEmail = "UserEmail";
  static const String profileImageUser = "profileImageUser";

  // Admin
  static const String FristNameAdmin = "FristNameAdmin";
  static const String SecondNameAdmin = "SecondNameAdmin";
  static const String AdminEmail = "adminEmail";
  static const String profileImageAdmin = "profileImageAdmin";

  // Colors
  static Color PrimgaryColor = const Color(0xff85586F);
  static Color SecondaryColor = const Color(0xffD0B8A8);

  static Color thirdColor = const Color(0xffDFD3C3);
  static Color forthColor = const Color(0xffF8EDE3);

  static Color BlueColorLikeLogo = const Color(0xff008aff);

  static Color textFieldBackgroundColor = const Color(0xffB5D5FF);

  static final MaterialColor primaryNewColor =
      MaterialColor(const Color(0xff3F72AF).value, _primaryColor);

  static Color lightCayn = const Color(0Xff35D5C3);

  // the new colors
  static Color otherColor = const Color(0xff112D4E);
  static Color whiteOne = const Color(0xffF9F7F7);

  static Color whiteTow = const Color(0xffDBE2EF);
  static Color BackgroundColor = const Color(0xff3F72AF);
}
