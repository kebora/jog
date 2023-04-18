import 'package:boraweather/controllers/city_textfield_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restart_app/restart_app.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cityTextFieldController = CityTextFieldController();
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red[300],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.share_location_sharp,
                color: Colors.red[200],
              ),
              title: Text(
                "Current City: ${GetStorage().hasData("city") ? GetStorage().read("city") : "Nairobi"}",
              ),
              subtitle: const Text(
                "(Tap to Change the city name)",
                style: TextStyle(fontSize: 12),
              ),
              onTap: () => showDialog(
                context: context,
                builder: ((context) => AlertDialog(
                      title: const Text("Input a new city!"),
                      content: TextField(
                        onChanged:
                            cityTextFieldController.onCityTextFieldValueChanged,
                        decoration: const InputDecoration(
                          hintText: "E.g. Nairobi",
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'OK');
                            if (cityTextFieldController
                                .cityTextFieldValue.value.isNotEmpty) {
                              Restart.restartApp();
                            } else {
                              const GetSnackBar(
                                messageText: Text(
                                    "Cannot update value to blank! Try again!"),
                              );
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    )),
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.sunny,
                  color: Colors.red[200],
                ),
                title: const Text("Change Application Theme"),
                subtitle: const Text(
                  "Switch between light and dark themes.",
                  style: TextStyle(fontSize: 12),
                ),
                onTap: () {
                  //
                  Get.isDarkMode
                      ? GetStorage().write("theme", false)
                      : GetStorage().write("theme", true);
                  //
                  Get.changeTheme(
                    Get.isDarkMode
                        ? ThemeData(
                            colorScheme:
                                ColorScheme.fromSeed(seedColor: Colors.red),
                            useMaterial3: true,
                          )
                        : ThemeData.dark(useMaterial3: true),
                  );
                }),
            ListTile(
              leading: Icon(
                Icons.code,
                color: Colors.red[200],
              ),
              title: const Text("Open Source Contribution"),
              subtitle: const Text(
                "Your software does not have to be limited!\nClick here to access source code for free!",
                style: TextStyle(fontSize: 12),
              ),
              onTap: () {
                
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.red[200],
              ),
              title: const Text("Exit Application"),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Exit App?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Nah'),
                            ),
                            TextButton(
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                              child: const Text('Sure'),
                            ),
                          ],
                        ));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                "Jogging\nApp v1",
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w100,
                    color: Colors.black12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
