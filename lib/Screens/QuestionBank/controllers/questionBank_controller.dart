import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';

import '../../../api/api_url.dart';
import '../../../utils/app_color.dart';
import '../viewModel/AnswerList.dart';
import '../viewModel/questionList.dart';

class QuestionBankController extends GetxController{

  var selectedIndex = 0.obs;
  var selectedOption = ''.obs;
  final selectedCategoriesText = ''.obs;


  var isLoading = false.obs;
  var errorMessage = "".obs;
  var answerList = <AnswerGroupResponseModel>[].obs;
  var questionList = <QuestionResponseModel>[].obs;


  TextEditingController textController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController optionsController = TextEditingController();
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

  var answerOptionsControllers = <TextEditingController>[].obs;

  void deleteCampaign() {

    print("Campaign deleted");
    Get.snackbar("Deleted", "Campaign has been deleted successfully",
        backgroundColor: AppColor.greenColor, colorText: AppColor.whiteColor);
  }

  @override
  void onInit() {
    super.onInit();
    fetchAnswerGroups();
    fetchQuestionGroups();
  }

  Future<void> fetchAnswerGroups({int page = 1, int limit = 10}) async {
    try {
      isLoading(true);
      errorMessage("");

      final queryParams = {
        'pageNumber': page.toString(),
        'pageSize': limit.toString(),
      };
      final fullUrl = Uri.parse(ApiUrl.answerChoiceList).replace(queryParameters: queryParams);
      print("Fetching Answer Groups → $fullUrl");
      print("Headers → ${ApiUrl.dioClient.getHeaders(true)}");

      final response = await ApiUrl.dioClient.get(
        url: ApiUrl.answerChoiceList,
        queryParameters: queryParams,
        isAuthRequired: true,
      );

      if (response != null) {
        final model = AnswerListModel.fromJson(response);
        answerList.value = model.result?.answerGroupResponseModel ?? [];

        print("Fetched Answer Groups:");
        answerList.forEach((item) {
          print(
              "ID: ${item.answerChoiceGroupId}, "
                  "Name: ${item.answerChoiceGroupName}, "
                  "Category: ${item.categories}, "
                  "Modified On: ${item.modifiedOn}");
        });
      } else {
        errorMessage("Something went wrong: Response is null");
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future <void> fetchQuestionGroups({int page = 1, int limit = 10})async{
  try {
    isLoading(true);
    errorMessage("");

    final queryParams = {
      'pageNumber': page.toString(),
      'pageSize': limit.toString(),
    };
    final fullUrl = Uri.parse(ApiUrl.questionList).replace(queryParameters: queryParams);
    print("Fetching Answer Groups → $fullUrl");
    print("Headers → ${ApiUrl.dioClient.getHeaders(true)}");

    final response = await ApiUrl.dioClient.get(
      url: ApiUrl.questionList,
      queryParameters: queryParams,
      isAuthRequired: true,
    );

    if (response != null) {
      final model = QuestionListModel.fromJson(response);
      questionList.value = model.result?.questionResponseModel ?? [];

      print("Fetched Answer Groups:");
      questionList.forEach((item) {
        print(
            "ID: ${item.questionId}, "
                "Name: ${item.questionText}, "
                "Category: ${item.categories}, "
                "Modified On: ${item.modifiedOn}");
      });
    } else {
      errorMessage("Something went wrong: Response is null");
    }
  } catch (e) {
    errorMessage(e.toString());
  } finally {
    isLoading(false);
  }
}

}
