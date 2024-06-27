import 'package:get/get.dart';
import 'package:mobile_semt3/model/user.dart';

import '../event/eventpref.dart';

class CUser extends GetxController {
  Rx<User> _user = User(0, '', '', '', '', '').obs;
  User get user => _user.value;
  void getUser() async {
    User? user = await EventPref.getUser();
    if (user != null) {
      _user.value = user;
    }
  }
}
