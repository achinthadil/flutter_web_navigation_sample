// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
// import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';

void main() {
  // usePathUrlStrategy();
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
          name: '/patients/:id',
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
    return Container(
      width: 200,
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(color: Colors.amber[100]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Get.offNamed('/'),
            child: const Text('Home'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Get.offNamed('/patients'),
            child: const Text('Patients'),
          ),
        ],
      ),
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
                  '/patients/123',
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Breadcrumb(),
                Center(
                  child: Text('PatientData Screen for Patient ID: $patientId'),
                ),
                const SizedBox.shrink(),
              ],
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

class Breadcrumb extends StatelessWidget {
  List<String> getBreadcrumbsFromUrl() {
    String url = Get.currentRoute; // Get current route with GetX

    // Split the URL by '/' and remove empty segments
    List<String> segments =
        url.split('/').where((segment) => segment.isNotEmpty).toList();

    // Map each segment to its human-readable counterpart
    segments = segments.map((segment) {
      if (segment.contains('patients') &&
          segments.indexOf(segment) == segments.length - 1) {
        return 'Patients ${Get.parameters['id'] ?? ''}';
      }
      return segment.capitalizeFirst!;
    }).toList();

    return [
      'Dashboard',
      ...segments
    ]; // Add 'Dashboard' as the starting breadcrumb
  }

  @override
  Widget build(BuildContext context) {
    List<String> breadcrumbs = getBreadcrumbsFromUrl();

    return Row(
      children: breadcrumbs.map((crumb) {
        return Row(
          children: <Widget>[
            Text(crumb),
            if (crumb != breadcrumbs.last) ...[
              Icon(Icons.arrow_forward_ios,
                  size: 12), // Arrow icon or something similar
            ]
          ],
        );
      }).toList(),
    );
  }
}
