// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       initialRoute: '/',
//       getPages: [
//         GetPage(name: '/', page: () => HomeView()),
//         GetPage(name: '/detail', page: () => DetailScreen()),
//         GetPage(name: '/patients', page: () => PatientsScreen()),
//         GetPage(
//             name: '/patient/:id',
//             page: () => PatientDataScreen(),
//             binding: PatientBinding()),
//       ],
//     );
//   }
// }
//
// // class HomeView extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Row(
// //         children: [
// //           PersistentSidebar(),
// //           Expanded(
// //               child: Navigator(
// //             key: Get.key,
// //             onGenerateRoute: (settings) {
// //               switch (settings.name) {
// //                 case '/':
// //                   return MaterialPageRoute(builder: (_) => HomeScreen());
// //                 case '/detail':
// //                   return MaterialPageRoute(builder: (_) => DetailScreen());
// //                 case '/patients':
// //                   return MaterialPageRoute(builder: (_) => PatientsScreen());
// //                 case '/patient/:id':
// //                   String? id = settings.arguments as String?;
// //                   return MaterialPageRoute(
// //                       builder: (_) => PatientDataScreen(id: id ?? 'Unknown'));
// //
// //                 default:
// //                   return MaterialPageRoute(builder: (_) => HomeScreen());
// //               }
// //             },
// //           )),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// class HomeView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           PersistentSidebar(),
//           Expanded(child: HomeScreen()),
//         ],
//       ),
//     );
//   }
// }
//
// class PersistentSidebar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             Get.offNamed('/'); // This will navigate and update the URL
//           },
//           child: Text('Home'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             Get.offNamed('/patients'); // This will navigate and update the URL
//           },
//           child: Text('Patients'),
//         ),
//       ],
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('Home Screen'),
//           ElevatedButton(
//             onPressed: () {
//               Get.toNamed('/detail');
//             },
//             child: Text('Go to Detail Screen'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DetailScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Detail Screen'),
//     );
//   }
// }
//
// class PatientsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('Patients Screen'),
//           ElevatedButton(
//             onPressed: () {
//               Get.toNamed('/patient/123'); // Example with patient id '123'
//             },
//             child: Text('Go to PatientData Screen with ID'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class PatientDataScreen extends GetView<PatientController> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('PatientData Screen for Patient ID: ${controller.patientId}'),
//     );
//   }
// }
//
// // class NavigationController extends GetxController {
// //   var currentRoute = '/'.obs;
// // }
//
// class PatientBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(PatientController());
//   }
// }
//
// class PatientController extends GetxController {
//   String get patientId => Get.parameters['id'] ?? 'Unknown';
// }
