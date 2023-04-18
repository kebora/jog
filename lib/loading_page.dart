import 'package:boraweather/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(
            height: 10,
          ),
          CircularProgressIndicator(
            color: Colors.red[200],
          ),
        ],
      ),
    );
  }
}

class InvalidCityName extends StatelessWidget {
  const InvalidCityName({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.red[200],
              size: 40,
            ),
            const Text(
              "City Name is Invalid!",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.circle,
                color: Colors.red[200],
              ),
              title: const Text(
                "Software might not be able to detect initials in the name.",
                style: TextStyle(fontSize: 13),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.circle,
                color: Colors.red[200],
              ),
              title: const Text(
                "Check that the name is well spelt.",
                style: TextStyle(fontSize: 13),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(
                  const SettingsPage(),
                );
              },
              child: const Text("Try again"),
            )
          ],
        ),
      ),
    );
  }
}
