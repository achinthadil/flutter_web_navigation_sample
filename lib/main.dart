import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Navigation App',
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomeView(),
        ),
        GetPage(name: '/detail', page: () => DetailScreen()),
        GetPage(name: '/patients', page: () => PatientsScreen()),
        GetPage(
          name: '/patient/:id',
          page: () => PatientDataScreen(),
        ),
      ],
      initialBinding: BindingsBuilder(() {
        Get.put<PatientController>(PatientController());
      }),
    );
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => Get.offNamed('/'),
          child: Text('Home'),
        ),
        ElevatedButton(
          onPressed: () => Get.offNamed('/patients'),
          child: Text('Patients'),
        ),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/detail'),
        child: Text('Go to Detail Screen'),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          PersistentSidebar(),
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: () =>
                    Get.toNamed('/patient/123'), // For patient with ID 123
                child: Text('Go to PatientData Screen with ID'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PatientDataScreen extends GetView<PatientController> {
  @override
  Widget build(BuildContext context) {
    final patientId = Get.parameters['id'] ?? ''; // Extract ID from the URL
    return Scaffold(
      body: Row(
        children: [
          PersistentSidebar(),
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
