import 'package:get/get.dart';

class DashboardController extends GetxController {
  var aiScore = 0.obs;
  var tokens = 0.obs;
  var isLoading = false.obs;

  List<Map<String, dynamic>> aiInsights = [
    {
      'title': 'Improve Your Footwork',
      'description': 'Work on lateral quickness drills',
      'drillUrl': 'https://example.com/drill1',
    },
    {
      'title': 'Increase Vertical Jump',
      'description': 'Plyometric exercises for power',
      'drillUrl': 'https://example.com/drill2',
    },
  ].obs;

  void refreshData() {
    isLoading.value = true;
    // TODO: Fetch dashboard data
    Future.delayed(const Duration(seconds: 1), () {
      aiScore.value = 78;
      tokens.value = 250;
      isLoading.value = false;
    });
  }
}
