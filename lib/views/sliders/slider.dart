import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/utils/api_url.dart';
import '../../constant/utils/app_color.dart';
import '../../controller/slider_controller.dart';
import '../../widgets/custom_button.dart';

class SliderScreen extends StatelessWidget {
  SliderScreen({super.key});

  final SliderController sliderController = Get.put(SliderController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Slider Management")),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [

              /// PICK IMAGE
              Obx(() {
                return GestureDetector(
                  onTap: sliderController.bannerPick,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.primary),
                      image: sliderController.pickImage.value.path.isNotEmpty
                          ? DecorationImage(
                          image: FileImage(sliderController.pickImage.value),
                          fit: BoxFit.cover)
                          : null,
                    ),
                    child: sliderController.pickImage.value.path.isEmpty
                        ? Center(child: Icon(Icons.image, size: 50))
                        : null,
                  ),
                );
              }),

              SizedBox(height: 20),

              /// ADD BUTTON
              CustomButton(
                text: "Add Slider",
                onTap: sliderController.addSlider,
              ),

              SizedBox(height: 40),

              /// SLIDER LIST
              Obx(() {
                if (sliderController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (sliderController.imageList.isEmpty) {
                  return Center(child: Text("No Slider Found"));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: sliderController.imageList.length,
                  itemBuilder: (context, index) {
                    final slider = sliderController.imageList[index];
                    final imageUrl =
                        "${ApiUrl.slider_image_url}${slider.image}";

                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              imageUrl,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Positioned(
                            right: 10,
                            top: 10,
                            child: Column(
                              children: [
                                /// EDIT
                                GestureDetector(
                                  onTap: () {
                                    sliderController.pickForUpdate(
                                      slider.id.toString(),
                                      slider.image.toString(),
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.edit, color: Colors.blue),
                                  ),
                                ),

                                SizedBox(height: 10),

                                /// DELETE
                                GestureDetector(
                                  onTap: () {
                                    sliderController.deleteImageSlider(
                                      slider.id.toString(),
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.delete,
                                        color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
