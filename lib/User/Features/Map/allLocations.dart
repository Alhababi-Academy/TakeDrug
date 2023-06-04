import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:take_drug/User/Features/Map/hosplitalsAndPharmacy/hospitals.dart';
import 'package:take_drug/User/Features/Map/hosplitalsAndPharmacy/pharmacies.dart';

class allLocaitons extends StatefulWidget {
  @override
  _allLocaitons createState() => _allLocaitons();
}

class _allLocaitons extends State<allLocaitons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(),
        title: Text(
          "All Locations".tr().toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 30.0),
          child: GridView.count(
            padding: const EdgeInsets.all(15),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            primary: false,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                onTap: () {
                  Route route = MaterialPageRoute(builder: (_) => hospitals());
                  Navigator.push(context, route);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.view_agenda,
                        color: takeDrug.BackgroundColor,
                        size: 33,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Hospitals".tr().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: takeDrug.BackgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Route route = MaterialPageRoute(builder: (_) => pharmacies());
                  Navigator.push(context, route);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_pharmacy,
                        color: takeDrug.BackgroundColor,
                        size: 33,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Pharmacy".tr().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: takeDrug.BackgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
