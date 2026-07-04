import 'package:flutterquationnaireapp/core/constants/AppStrgs.dart';
import 'package:flutterquationnaireapp/data/models/user_model.dart';
import 'package:flutterquationnaireapp/data/models/submission_model.dart';
import 'package:flutterquationnaireapp/data/repositories/auth_repository.dart';
import 'package:flutterquationnaireapp/data/repositories/submission_repositories.dart';
import 'package:flutterquationnaireapp/routes/app_routes.dart';
import 'package:flutterquationnaireapp/utilities/appsnackbar.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository _repository = AuthRepository();
  final SubmissionRepository _submissionRepository = SubmissionRepository();

  RxBool isLoggedIn = false.obs;
  RxBool isFormValid = false.obs;
  RxBool isLoginValid = false.obs;

  RxString currentPositionUser = ''.obs;
  RxInt totalSubmissions = 0.obs;

  RxList<SubmissionModel> submissionHistory = <SubmissionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  void loadProfile() {
    isLoggedIn.value = _repository.isLoggedIn();

    if (isLoggedIn.value) {
      currentPositionUser.value = _repository.getCurrentUserPhone();

      totalSubmissions.value = _submissionRepository.getSubmissionCount(
        currentPositionUser.value,
      );
      submissionHistory.assignAll(
        _submissionRepository.getSubmissionsByPhone(currentPositionUser.value),
      );
    } else {
      currentPositionUser.value = "";
      totalSubmissions.value = 0;
      submissionHistory.clear();
    }
  }

  Future<void> registerUser(
    String phone,
    String password,
    String confirmPassword,
  ) async {
    bool success = await _repository.registerUser(phone, password);
    if (success) {
      AppSnackbar.success(
        AppStrigs.registrationSuccessful,
        AppStrigs.accountcreated,
      );
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed(AppRoutes.login);
      });
    } else {
      AppSnackbar.error(AppStrigs.error, "User already exists.");
    }
  }

  Future<void> loginUser(String phone, String password) async {
    if (phone.isEmpty || password.isEmpty) {
      AppSnackbar.error(AppStrigs.error, AppStrigs.pleasefillallthefields);
      return;
    }

    UserModel? user = _repository.getUser(phone);
    if (user == null) {
      AppSnackbar.error(AppStrigs.error, AppStrigs.userNotfound);
      return;
    }

    if (user.password != password) {
      AppSnackbar.error(AppStrigs.error, AppStrigs.incorrectpassword);
      return;
    }

    await _repository.saveLoginSession(phone);
    loadProfile();
    AppSnackbar.success(AppStrigs.successful, AppStrigs.welcomeback);
    Get.offNamed(AppRoutes.home);
  }

  Future<void> logout() async {
    await _repository.logout();
    isLoggedIn.value = false;
    currentPositionUser.value = "";
    totalSubmissions.value = 0;
    submissionHistory.clear();
    AppSnackbar.success("Logged Out", "Session cleared successfully");
    Get.offAllNamed(AppRoutes.login);
  }

  void validateForm(String phone, String password, String confirmPassword) {
    isFormValid.value =
        phone.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword;
  }

  void validateLoginForm(String phone, String password) {
    isLoginValid.value = phone.isNotEmpty && password.isNotEmpty;
  }
}
