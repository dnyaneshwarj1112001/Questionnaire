import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import 'package:flutterquationnaireapp/core/constants/AppStrgs.dart';
import 'package:flutterquationnaireapp/core/constants/Appcolors.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    controller.loadProfile();

    return Scaffold(
      backgroundColor: Appcolors.backgroundGrey,
      appBar: AppBar(
        title: const Text(AppStrigs.myProfile),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              Center(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Appcolors.avatarBackground,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Appcolors.info,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      AppStrigs.welcome,
                      style: TextStyle(
                        color: Appcolors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.currentPositionUser.value.isNotEmpty
                          ? controller.currentPositionUser.value
                          : AppStrigs.guestUser,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      Icons.assignment_turned_in,
                      AppStrigs.totalFilled,
                      controller.totalSubmissions.value.toString(),
                      Appcolors.success,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      Icons.verified_user,
                      AppStrigs.accountStatus,
                      "Active",
                      Appcolors.info,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              const Text(
                AppStrigs.submissionHistory,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Appcolors.appBarForeground,
                ),
              ),
              const SizedBox(height: 12),

              controller.submissionHistory.isEmpty
                  ? Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Center(
                          child: Text(
                            AppStrigs.noSubmissionHistory,
                            style: TextStyle(
                              color: Appcolors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.submissionHistory.length,
                      itemBuilder: (context, index) {
                        final submission = controller.submissionHistory[index];

                        final String title = submission.questionnaireTitle;
                        final String dateTime = submission.submittedAt;
                        final String lat = submission.latitude.toString();
                        final String long = submission.longitude.toString();

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Appcolors.successLight,
                              child: const Icon(
                                Icons.check,
                                color: Appcolors.success,
                              ),
                            ),
                            title: Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "${AppStrigs.datePrefix} $dateTime\n${AppStrigs.locationPrefix} $lat, $long",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Appcolors.textSecondary,
                                ),
                              ),
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    AppStrigs.logout,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolors.danger,
                    foregroundColor: Appcolors.cwhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Get.defaultDialog(
                      title: AppStrigs.logout,
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Appcolors.appBarForeground,
                      ),
                      middleText: AppStrigs.logoutConfirm,
                      middleTextStyle: const TextStyle(
                        fontSize: 14,
                        color: Appcolors.textDisabled,
                      ),
                      backgroundColor: Appcolors.cwhite,
                      radius: 18,
                      barrierDismissible: false,
                      textCancel: AppStrigs.cancel,
                      textConfirm: AppStrigs.logout,
                      cancelTextColor: Appcolors.textDisabled,
                      confirmTextColor: Appcolors.cwhite,
                      buttonColor: Appcolors.danger,
                      onConfirm: () {
                        Get.back();
                        controller.logout();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Appcolors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
