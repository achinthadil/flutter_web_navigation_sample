// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Navigation App',
//       initialRoute: '/',
//       getPages: [
//         GetPage(
//           name: '/',
//           page: () => HomeView(),
//         ),
//       ],
//       defaultTransition: Transition.noTransition,
//     );
//   }
// }
//
// class HomeViewNavigation {
//   HomeViewNavigation._();
//
//   static const home = '/home';
//   static const homeDetail = '/home/detail';
//   static const patients = '/patients';
//   static const patientDetail = '/patients/detail';
// }
//
// class HomeView extends StatelessWidget {
//   HomeView({super.key});
//
//   final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           const PersistentSidebar(),
//           Expanded(
//             child: Navigator(
//               key: _navigatorKey,
//               initialRoute: HomeViewNavigation.home,
//               onGenerateRoute: (routes) {
//                 debugPrint("😤😤😤 ${routes.name}");
//                 switch (routes.name) {
//                   case HomeViewNavigation.home:
//                     return GetPageRoute(
//                       routeName: HomeViewNavigation.home,
//                       page: () => const HomeScreen(),
//                     );
//                   case HomeViewNavigation.homeDetail:
//                     return GetPageRoute(
//                       routeName: HomeViewNavigation.homeDetail,
//                       page: () => const HomeDetailScreen(),
//                     );
//                   case HomeViewNavigation.patients:
//                     return GetPageRoute(
//                       routeName: HomeViewNavigation.patients,
//                       page: () => const PatientsScreen(),
//                     );
//                   case HomeViewNavigation.patientDetail:
//                     return GetPageRoute(
//                       routeName: HomeViewNavigation.patientDetail,
//                       page: () => const PatientDetailScreen(),
//                     );
//                   default:
//                     return null;
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class PersistentSidebar extends StatelessWidget {
//   const PersistentSidebar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       height: MediaQuery.sizeOf(context).height,
//       decoration: BoxDecoration(color: Colors.amber[100]),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: () => Get.toNamed(HomeViewNavigation.home),
//             child: const Text('Home'),
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () => Get.toNamed(HomeViewNavigation.patients),
//             child: const Text('Patients'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () => Get.offNamed(HomeViewNavigation.homeDetail),
//         child: const Text('Go to Home Detail Screen'),
//       ),
//     );
//   }
// }
//
// class HomeDetailScreen extends StatelessWidget {
//   const HomeDetailScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Home Detail Screen'),
//     );
//   }
// }
//
// class PatientsScreen extends StatelessWidget {
//   const PatientsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           Expanded(
//             child: Center(
//               child: ElevatedButton(
//                 onPressed: () => Get.offNamed(HomeViewNavigation.patientDetail),
//                 child: const Text('Go to PatientDetail Screen'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class PatientDetailScreen extends StatelessWidget {
//   const PatientDetailScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Patient Detail Screen'),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const NestedNavigation());
}

class NestedNavigation extends StatelessWidget {
  const NestedNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Nested Navigation - BNB',
      theme: ThemeData(primarySwatch: Colors.blue),
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomeViewWrapper(),
        ),
      ],
      initialRoute: '/',
    );
  }
}

class HomeViewNavigation {
  HomeViewNavigation._();

  static const id = 0;

  static const home = '/home';
  static const detail = '/home/detail';
}

class HomeViewWrapper extends StatelessWidget {
  const HomeViewWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // SIDEBAR
        Container(
          width: 200,
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.amber[100]),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.offNamed(
                      '/home',
                      id: HomeViewNavigation.id,
                    );
                  },
                  child: const Text('Home')),
              ElevatedButton(
                  onPressed: () {
                    Get.offNamed(
                      '/settings',
                      id: HomeViewNavigation.id,
                    );
                  },
                  child: const Text('Settings'))
            ],
          ),
        ),
        // NAVIGATOR
        Expanded(
          child: Navigator(
            key: Get.nestedKey(HomeViewNavigation.id),
            onGenerateRoute: (settings) {
              debugPrint("😏😏😏 ${settings.name}");
              if (settings.name == '/settings') {
                return GetPageRoute(
                  routeName: '/settings',
                  page: () => const SettingsScreen(),
                );
              } else if (settings.name == HomeViewNavigation.detail) {
                return GetPageRoute(
                  routeName: HomeViewNavigation.detail,
                  page: () =>
                      const HomeScreen(id: HomeViewNavigation.id, first: false),
                );
              } else {
                return GetPageRoute(
                  routeName: HomeViewNavigation.home,
                  page: () =>
                      const HomeScreen(id: HomeViewNavigation.id, first: true),
                );
              }
            },
          ),
        )
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  final int? id;
  final bool first;

  const HomeScreen({Key? key, this.id, required this.first}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (first) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Home'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Get.toNamed(HomeViewNavigation.detail, id: HomeViewNavigation.id),
          child: const Icon(Icons.chevron_right),
        ),
        body: const Center(child: Text('Home Page')),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Detail'),
        ),
        body: const Center(child: Text('Detail Page')),
      );
    }
  }
}

class SettingsScreen extends StatelessWidget {
  final int? id;
  const SettingsScreen({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Settings'),
      ),
      body: const Center(child: Text('Settings Page')),
    );
  }
}
