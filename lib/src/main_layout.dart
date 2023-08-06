import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sidebar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  MainLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (Get.currentRoute != '/') {
            Get.back();
            return false;
          }
          return true;
        },
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Sidebar(),
            ),
            Expanded(
              flex: 8,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
