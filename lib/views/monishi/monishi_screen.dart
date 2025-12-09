import 'package:flutter/material.dart';
import 'package:flutter_quotes_admin_app/controller/monishi_controller.dart';
import 'package:flutter_quotes_admin_app/views/monishi/monishi_add_edit_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../constant/utils/api_url.dart';

class MonishiScreen extends StatelessWidget {
  MonishiScreen({super.key});

  final MonishiController controller = Get.put(MonishiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Monishi Management")),

        body:       Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.monishiList.isEmpty) {
            return Center(child: Text("No Data"));
          }

          return ListView.separated(

            itemCount: controller.monishiList.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final monishi = controller.monishiList[index];

              final url = "${ApiUrl.monishi_image_url}${monishi.image!}";

              print(monishi.image);


              print(url);



              return ListTile(

                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    url,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (c, o, s) => Icon(Icons.error),
                  ),
                ),



                title: Text(monishi.name ?? "No Name"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: (){

                        Get.to(MonishiAddEditScreen(monishi: monishi));


                    }, icon: Icon(Icons.edit,color: Colors.blue,)),
                    IconButton(onPressed: (){
                      controller.deleteMonishi(monishi.id!);
                    }, icon: Icon(Icons.delete,color: Colors.red,)),
                  ],
                ),


              );
            },
          );
        }),


        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(MonishiAddEditScreen());

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
