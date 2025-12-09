import 'package:flutter/material.dart';
import 'package:flutter_quotes_admin_app/constant/utils/app_color.dart';
import 'package:flutter_quotes_admin_app/controller/monishi_quotes_controller.dart';
import 'package:flutter_quotes_admin_app/views/monishi/monishi_quote_add_delete_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';


class MonishiQuotesScreen extends StatelessWidget {
   MonishiQuotesScreen({super.key});

  final MonishiQuotesController quotesController = Get.put(MonishiQuotesController());

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      appBar: AppBar(
        title: Text("Monishi Quotes Management"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Obx(() {

          if(quotesController.loading.value){
            return Center(child: CircularProgressIndicator(),);
          }
          if(quotesController.monihsiQuotesList.isEmpty){
            return Center(child: Text('No Monishi List'),);
          }


          return      ListView.separated(
            itemCount: quotesController.monihsiQuotesList.length,
            itemBuilder: (context,index){

              final list = quotesController.monihsiQuotesList[index];

              return ListTile(
                leading: CircleAvatar(backgroundColor:AppColor.primary,
                    child: Text("${index+1}",style: TextStyle(color: Colors.white),),),
                title: Text(list.quote!),
                subtitle: Text(list.monishiName!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {

                          Get.to(() => MonishiQuoteAddDeleteScreen(
                             quotes: list,
                          ));
                        },
                        icon: Icon(Icons.edit),
                        color: Colors.blue,
                        tooltip: "Edit Quote",
                      ),


                      IconButton(
                        onPressed: () {
                          quotesController.deleteQuote(list.id!);
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        tooltip: "Delete Quote",
                      ),
                    ],

              ),

              );


            }, separatorBuilder: (BuildContext context, int index) {
              return Divider();
          },
          );
        })
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(MonishiQuoteAddDeleteScreen());
        },
        child: Icon(Icons.add),
      ),

    );


  }
}
