import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('privacy_policy'.tr().toString()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "show_details".tr().toString(),
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Text(
                "show_details".tr().toString(),
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "we_take_your_privacy".tr().toString(),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "user_right".tr().toString(),
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "more_About_your_right".tr().toString(),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
