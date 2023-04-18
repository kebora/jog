class WeatherData {
  String city;
  String country;
  num temperature;
  num feelsLike;
  num windSpeed;
  String description;
  num precipitation;

  WeatherData({
    required this.city,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.windSpeed,
    required this.description,
    required this.precipitation,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['data'][0]['city_name'],
      country: json['data'][0]['country_code'],
      temperature: json['data'][0]['temp'],
      feelsLike: json['data'][0]['app_temp'],
      windSpeed: json['data'][0]['wind_spd'],
      precipitation: json['data'][0]['precip'],
      description: json['data'][0]['weather']['description'],
    );
  }
}
