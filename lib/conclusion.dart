class Conclusion {
  static String jogDecision(
    num windspeed,
    num temp,
    num precipitation,
    String description,
  ) {
    if (windspeed < 10.0) {
      if (precipitation == 0) {
        if (temp <= 20) {
          return "You can jog, perfect conditions detected.";
        } else {
          return "You can jog, but stay hydrated and avoid prolonged exposure to the Sun.";
        }
      } else {
        return "Precipitation levels are not 0. Check whether there is any $description before proceeding!";
      }
    } else {
      return "The winds might be too strong for a jog. Check before proceeding!";
    }
  }
}
