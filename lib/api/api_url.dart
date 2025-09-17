import 'api_services.dart';

class ApiUrl {
  const ApiUrl._();

  static final DioClient  dioClient = DioClient();

  static String domain = 'https://surveyapp-backend-staging.azurewebsites.net/';
  static String midUrl = 'api/';

  static String get baseUrl => domain + midUrl;

  static createAPIUrl(String endPoint) => baseUrl + endPoint;

  static String get login => createAPIUrl('account/login');
  static String get answerChoiceList => createAPIUrl('answer-choice-group');
  static String get questionList => createAPIUrl('question');
  static String get addQuestion => createAPIUrl('question');
  static String get inviteUser => createAPIUrl('user/get-invited-user');
  static String get onBoardUser => createAPIUrl('user/get-onboarded-user');
  static String get newUser => createAPIUrl('user');
  static String get campaign => createAPIUrl('campaign');
  static String get answerType => createAPIUrl('answer-type');
  static String get saveSurveyDescription => createAPIUrl('survey/save-survey-description');
  static String get updateSurveyQuestion => createAPIUrl('survey/update-survey-question');
  static String get getquestionsList => createAPIUrl('survey/get-questions');


}
