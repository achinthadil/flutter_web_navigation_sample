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
      defaultTransition: Transition.noTransition,
    );
  }
}

class HomeViewNavigation {
  HomeViewNavigation._();

  static const id = 0;

  static const home = '/home';
  static const detail = '/home/detail';

  static const settings = '/settings';
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(
                      HomeViewNavigation.home,
                      id: HomeViewNavigation.id,
                    );
                  },
                  child: const Text('Home')),
              ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(
                      HomeViewNavigation.settings,
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
              if (settings.name == HomeViewNavigation.settings) {
                return GetPageRoute(
                  routeName: HomeViewNavigation.settings,
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
        backgroundColor: Colors.orange,
        title: const Text('Settings'),
      ),
      body: const Center(child: Text('Settings Page')),
    );
  }
}
