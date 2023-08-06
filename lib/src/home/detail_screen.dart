import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sidebar.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = Get.parameters['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen $id'),
      ),
      drawer: Sidebar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}
