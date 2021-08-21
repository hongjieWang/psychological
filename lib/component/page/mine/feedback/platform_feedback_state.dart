import 'package:get/get.dart';
import 'package:standard_app/base/api_service.dart';

class PlatformFeedbackState {
  RxMap feedback;
  RxList feedbackList;
  PlatformFeedbackState() {
    ///获取意见反馈类型
    feedback = {"title": "点击选择问题类型", "id": "01"}.obs;
    feedbackList = [].obs;

    ///获取意见反馈类型
    ApiService().getFeedbackList().then((value) => {
          print(value),
          if (value['code'] == 200)
            {
              test(value).forEach((element) {
                feedbackList.add({
                  "title": "${element['feedbackTypeName']}",
                  "id": "${element['feedbackTypeId']}"
                });
              }),
            }
        });
  }

  List test(value) {
    return value['data'].toList();
  }
}
