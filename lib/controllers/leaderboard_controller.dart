import 'package:get/get.dart';

class LeaderboardController extends GetxController {
  var isLoading = false.obs;
  var selectedSport = 'all'.obs;
  var selectedPosition = 'all'.obs;

  var leaderboardData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadLeaderboard();
  }

  void loadLeaderboard() {
    isLoading.value = true;
    // TODO: Load leaderboard data
    Future.delayed(const Duration(seconds: 1), () {
      leaderboardData.value = [
        {
          'rank': 1,
          'name': 'Alex Johnson',
          'score': 95,
          'tier': 'platinum',
          'sport': 'football',
          'position': 'QB',
          'tokens': 1200,
        },
        {
          'rank': 2,
          'name': 'Sarah Davis',
          'score': 92,
          'tier': 'gold',
          'sport': 'basketball',
          'position': 'PG',
          'tokens': 1100,
        },
        {
          'rank': 3,
          'name': 'Mike Wilson',
          'score': 88,
          'tier': 'gold',
          'sport': 'football',
          'position': 'RB',
          'tokens': 950,
        },
      ];
      isLoading.value = false;
    });
  }

  void filterBySport(String sport) {
    selectedSport.value = sport;
    loadLeaderboard();
  }

  void filterByPosition(String position) {
    selectedPosition.value = position;
    loadLeaderboard();
  }
}
