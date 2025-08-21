import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';

class QuestionBankController extends GetxController{

  var selectedIndex = 0.obs;
  var selectedOption = ''.obs;
  final selectedCategoriesText = ''.obs;
  TextEditingController textController = TextEditingController();
  TextEditingController choice1Controller = TextEditingController();
  TextEditingController choice2Controller = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  final optionsList =<String> [
    'Boolean',
    'Single Choice',
    'Multiple Choice',
    'Rainking',
    'Date',
    'Numeric',
    'Integer',
    'Image',
    'Slider',
    'Likert Scale',
    'Rating Scale',
    'Matrix Question',
    'Star Type Rating',
    'Overall Experience'
  ].obs;

  final categoryList = <String, bool>{
    'Mortgage': false,
    'Real State': false,
  }.obs;

}