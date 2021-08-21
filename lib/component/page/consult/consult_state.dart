import 'package:get/get.dart';

class ConsultState {
  RxMap consult;

  ///时间倒计时默认 50min
  RxInt countdown;

  ConsultState() {
    consult = {}.obs;
    countdown = 100.obs;
  }
}
