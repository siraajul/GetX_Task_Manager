import 'package:get/get.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/utility/auth_utility.dart';

class UpdateProfileController extends GetxController {
  bool _profileUpdateInProgress = false;

  bool get profileUpdateInProgress => _profileUpdateInProgress;

  void getUpdateState() {
    update();
  }

  Future<bool> updateProfile(
      String firstName, String lastName, String mobile, String password) async {
    _profileUpdateInProgress = true;
    update();
    final Map<String, dynamic> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "photo": ""
    };
    if (password.isNotEmpty && password.length >= 5) {
      requestBody['password'] = password;
    }

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.profileUpdate, requestBody);
    _profileUpdateInProgress = false;
    update();
    if (response.isSuccess) {
      UserData userData = AuthUtility.userInfo.data!;
      userData.firstName = firstName;
      userData.lastName = lastName;
      userData.mobile = mobile;
      AuthUtility.updateUserInfo(userData);
      return true;
    } else {
      return false;
    }
  }
}
