import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/component/page/consult/feedback/feedback_state.dart';

class FeedBackController extends GetxController {
  FeedBackState state = FeedBackState();

  FeedBackController() {
    ApiService().getFeedbackList().then((value) => {
          if (value['code'] == Api.success) {state.feeds.value = value['data']}
        });
  }
}
