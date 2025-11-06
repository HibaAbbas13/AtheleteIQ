import 'package:athleteiq/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

class FilmEvaluationController extends GetxController {
  var isUploading = false.obs;
  var isEvaluating = false.obs;
  var currentStep = 0.obs;

  var evaluationResult = {}.obs;

  void uploadFilm(String url) {
    isUploading.value = true;
    currentStep.value = 1;

    // TODO: Implement film upload logic
    Future.delayed(const Duration(seconds: 3), () {
      isUploading.value = false;
      startEvaluation();
    });
  }

  void startEvaluation() {
    isEvaluating.value = true;
    currentStep.value = 1;

    // TODO: Implement AI evaluation logic
    Future.delayed(const Duration(seconds: 4), () {
      evaluationResult.value = {
        'score': 82,
        'feedback': 'Great effort! Focus on positioning and decision making.',
        'drillSuggestion': 'Work on defensive positioning drills',
        'tokensEarned': 15,
      };
      currentStep.value = 2;
      isEvaluating.value = false;

      // Update dashboard with new score and tokens
      final dashboardController = Get.find<DashboardController>();
      dashboardController.aiScore.value = evaluationResult['score'] as int;
      dashboardController.tokens.value +=
          evaluationResult['tokensEarned'] as int;
    });
  }

  void resetEvaluation() {
    currentStep.value = 0;
    evaluationResult.value = {};
    isUploading.value = false;
    isEvaluating.value = false;
  }
}
