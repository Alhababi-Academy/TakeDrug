import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/firebase_options.dart';
import 'package:take_drug/services/notificationsServices.dart';
import 'package:take_drug/splashScreen/splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await NotificationService.initializeNotification();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  takeDrug.auth = FirebaseAuth.instance;
  takeDrug.firebaseFirestore = FirebaseFirestore.instance;
  takeDrug.firebaseStorage = FirebaseStorage.instance;
  takeDrug.sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primaryColor: takeDrug.PrimgaryColor, // custom primary color
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: takeDrug.primaryNewColor),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: takeDrug.whiteOne,
          ), // custom text color
        ),
      ),
      home: const splashScreen(),
    );
  }
}
