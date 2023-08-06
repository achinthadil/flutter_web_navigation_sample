import 'package:flutter/material.dart';

import '../sidebar.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients Screen'),
      ),
      drawer: Sidebar(),
      body: const Center(
        child: Text('Welcome to the Patients Screen'),
      ),
    );
  }
}
