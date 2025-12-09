import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdController extends GetxController {
  RxBool isBannerAdEnabled = false.obs;
  RxBool isInterstitialAdEnabled = false.obs;

  /// Update server when switch is toggled
  Future<void> updateAdStatus(int id, bool isActive) async {
    try {
      final response = await http.post(
        Uri.parse("https://programmingpulse.xyz/quotes_app_api/api/v1/ads/update_banner_ad_status.php"),
        body: {
          "id": id.toString(),
          "is_active": isActive ? "1" : "0",
        },
      );

      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        Get.snackbar("Success", "Ad status updated successfully");
      } else {
        Get.snackbar("Error", data['message'] ?? "Update failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Update failed: $e");
    }
  }
}
