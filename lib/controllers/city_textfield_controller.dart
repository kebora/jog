import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CityTextFieldController extends GetxController {
  var cityTextFieldValue = "".obs;

  void onCityTextFieldValueChanged(String value) async {
    cityTextFieldValue.value = value;
    await GetStorage().write("city", value);
  }
}
