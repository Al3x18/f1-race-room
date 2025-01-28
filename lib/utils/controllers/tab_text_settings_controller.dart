import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabTextSettingsController extends GetxController {
  Rx<bool> shortTabText = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedValue();
  }

  Future<void> loadSavedValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    shortTabText.value = prefs.getBool('shortTabText') ?? true;
  }

  void setShortTabText(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('shortTabText', value);
    shortTabText.value = value;
  }
}
