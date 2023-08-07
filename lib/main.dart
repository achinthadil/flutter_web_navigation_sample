// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Navigation App',
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomeView(),
        ),
        GetPage(name: '/detail', page: () => const DetailScreen()),
        GetPage(name: '/patients', page: () => const PatientsScreen()),
        GetPage(
          name: '/patient/:id',
          page: () => const PatientDataScreen(),
        ),
      ],
      initialBinding: BindingsBuilder(() {
        Get.put<PatientController>(PatientController());
      }),
      defaultTransition: Transition.noTransition,
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          PersistentSidebar(),
          Expanded(child: HomeScreen()),
        ],
      ),
    );
  }
}

class PersistentSidebar extends StatelessWidget {
  const PersistentSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => Get.offNamed('/'),
          child: const Text('Home'),
        ),
        ElevatedButton(
          onPressed: () => Get.offNamed('/patients'),
          child: const Text('Patients'),
        ),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/detail'),
        child: const Text('Go to Detail Screen'),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          PersistentSidebar(),
          Expanded(
            child: Center(child: Text('Detail Screen')),
          ),
        ],
      ),
    );
  }
}

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const PersistentSidebar(),
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: () => Get.toNamed(
                  '/patient/123',
                ), // For patient with ID 123
                child: const Text('Go to PatientData Screen with ID'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PatientDataScreen extends GetView<PatientController> {
  const PatientDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patientId = Get.parameters['id'] ?? ''; // Extract ID from the URL
    return Scaffold(
      body: Row(
        children: [
          const PersistentSidebar(),
          Expanded(
            child: Center(
              child: Text('PatientData Screen for Patient ID: $patientId'),
            ),
          ),
        ],
      ),
    );
  }
}

class PatientController extends GetxController {
  RxString patientId = ''.obs;

  void setPatientId(String id) {
    patientId.value = id;
  }
}
