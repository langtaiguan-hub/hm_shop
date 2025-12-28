import 'package:get/get.dart';

class UserController extends GetxController {
  // 定义一个变量来存储用户信息 .obs 表示可观察的变量 被监听了
  var userInfo = <String, dynamic>{'nickName': ''}.obs;

  // 更新用户信息
  void updateUserInfo(Map<String, dynamic> data) {
    userInfo.value = data;
  }
}
