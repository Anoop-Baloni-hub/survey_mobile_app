import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:survey_app/Screens/Campaign/controllers/campaign_controller.dart';


class CampaignBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<CampaignController>(() => CampaignController());
}