import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          child: Text("Home"),
          onPressed: () {
            Get.offNamed('/'); // for home
          },
        ),
        TextButton(
          child: Text("Patients"),
          onPressed: () {
            Get.offNamed('/patients'); // for patients
          },
        ),
      ],
    );
  }
}
