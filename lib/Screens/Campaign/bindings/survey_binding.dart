
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:survey_app/Screens/Campaign/controllers/new_survey_controller.dart';

class SurveyBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<NewSurveyController>(() => NewSurveyController());
}