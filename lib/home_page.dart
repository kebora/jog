import 'package:boraweather/conclusion.dart';
import 'package:boraweather/constants.dart';
import 'package:boraweather/loading_page.dart';
import 'package:boraweather/model/weather_data.dart';
import 'package:boraweather/settings.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<WeatherData> fetchWeatherData(String apiKey) async {
  String city =
      GetStorage().hasData("city") ? GetStorage().read("city") : "Nairobi";
  final response = await http.get(Uri.parse(
      'https://api.weatherbit.io/v2.0/current?city=$city&key=$apiKey'));

  if (response.statusCode == 200) {
    return WeatherData.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception('Failed to load weather data');
  }
}

class _HomePageState extends State<HomePage> {
  late Future<WeatherData> weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = fetchWeatherData(myApiKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Jogging App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[300],
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SettingsPage(),
              ),
            ),
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder<WeatherData>(
          future: weatherData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              num windSpeed = snapshot.data!.windSpeed;
              num temperature = snapshot.data!.temperature;
              num precipitation = snapshot.data!.precipitation;
              String description = snapshot.data!.description;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.share_location_sharp,
                        color: Colors.red[200],
                      ),
                      title: Text(
                          "Current City: ${snapshot.data!.city},${snapshot.data!.country}"),
                      subtitle: const Text(
                        "(Change the city name in Settings)",
                        style: TextStyle(fontSize: 10),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text("Weather Description"),
                      subtitle: Text(
                        description,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    ListTile(
                      title: const Text("Temperature"),
                      subtitle: Text(
                        "$temperature Celsius",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    ListTile(
                      title: const Text("Precipitation"),
                      subtitle: Text(
                        "$precipitation",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    ListTile(
                      title: const Text("Wind Speed"),
                      subtitle: Text(
                        "$windSpeed m/s",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    ListTile(
                      title: const Text("Temp Feels like (Celsius)"),
                      subtitle: Text(
                        "${snapshot.data!.feelsLike}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text(
                          "Conclusion",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          Conclusion.jogDecision(windSpeed, temperature,
                              precipitation, description),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              if (snapshot.error.toString() ==
                  "type 'Null' is not a subtype of type 'num'") {
                return const InvalidCityName();
              }
              if (snapshot.error.toString() ==
                  "Failed host lookup: 'api.weatherbit.io'") {
                return const Refresh();
              }
              return LoadingPage(
                message: "${snapshot.error}",
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage(
                message: "Loading",
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const LoadingPage(
                message: "Critical Error Experienced. Close app and retry!",
              );
            } else {
              return const LoadingPage(
                message: "Unknown Error!",
              );
            }
          }),
    );
  }
}
