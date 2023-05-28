import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('about_us'.tr().toString()),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              "about_us_devlooper".tr().toString(),
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'we_beleive_in_idaes'.tr().toString(),
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "we_ecnourge".tr().toString(),
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
