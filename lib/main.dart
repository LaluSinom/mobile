import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mobile_semt3/view/dashboard/dashboard.dart';
import 'event/eventpref.dart';
import 'view/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: EventPref.getUser(),
        builder: (context, snapshot) {
          // jika username belum login
          if (snapshot.data == null) {
            return Login();
          }
          // jika sudah login
          return DashBoard();
        },
      ),
    );
  }
}
