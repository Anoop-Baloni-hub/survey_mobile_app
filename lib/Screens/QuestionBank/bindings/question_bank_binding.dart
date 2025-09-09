import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controllers/questionBank_controller.dart';
import '../repository/question_repository.dart';

class QuestionBankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionRepository>(() => QuestionRepository());
    Get.lazyPut<QuestionBankController>(
          () => QuestionBankController(Get.find<QuestionRepository>()),
    );
  }
}