import 'package:boraweather/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  //initialize getStorage()
  await GetStorage.init();
  //initialize the values if not available.
  if ({GetStorage().read("theme")}.isEmpty) {
    await GetStorage().write("theme", false);
  }
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Jogging App',
      theme: GetStorage().read("theme") == false
          ? ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
              useMaterial3: true,
            )
          : ThemeData.dark(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
