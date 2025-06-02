import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:streaming_app/screens/home_screen.dart";
import "package:streaming_app/screens/login_screen.dart";

class AuthController extends GetxController {
  final email = "".obs;
  final isLoggedIn = false.obs;

  Future<void> login(String userEmail, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", userEmail);
    await prefs.setString("mot de passe", password);
    email.value = userEmail;
    isLoggedIn.value = true;
    Get.off(() => HomePage());
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString("email");
    if (savedEmail != null) {
      email.value = savedEmail;
      isLoggedIn.value = true;
      Get.off(() => HomePage());
    } else {
      Get.off(() => LoginPage());
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.off(() => LoginPage());
  }
}
