import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/AdController.dart';

class AdmobScreen extends StatelessWidget {
  AdmobScreen({super.key});

  final AdController adController = Get.put(AdController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ads Management")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Banner Ad Switch
            Obx(
                  () => SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Banner Ad",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: adController.isBannerAdEnabled.value,
                activeColor: Colors.deepPurpleAccent,
                onChanged: (bool value) {
                  adController.isBannerAdEnabled.value = value;
                  adController.updateAdStatus(1, value); // Pass banner ad ID
                },
              ),
            ),
            SizedBox(height: 10),

            // Interstitial Ad Switch
            Obx(
                  () => SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Interstitial Ad",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: adController.isInterstitialAdEnabled.value,
                activeColor: Colors.deepPurpleAccent,
                onChanged: (bool value) {
                  adController.isInterstitialAdEnabled.value = value;
                  adController.updateAdStatus(2, value); // Pass interstitial ad ID
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
