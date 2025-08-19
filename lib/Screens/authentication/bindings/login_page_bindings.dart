import 'package:get/get.dart';
import '../controllers/login_page_controller.dart';

class LoginPageBindings extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<LoginPageController>(() => LoginPageController());
}
