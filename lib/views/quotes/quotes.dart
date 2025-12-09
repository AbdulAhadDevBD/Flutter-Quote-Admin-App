import 'package:flutter/material.dart';
import 'package:flutter_quotes_admin_app/constant/utils/app_color.dart';
import 'package:flutter_quotes_admin_app/controller/quotes_controller.dart';
import 'package:flutter_quotes_admin_app/views/quotes/add_quotes.dart';
import 'package:flutter_quotes_admin_app/views/quotes/update_quotes.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class QuotesScreen extends StatelessWidget {
   QuotesScreen({super.key});

  final QuotesController controller = Get.put(QuotesController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        title: Text("Quotes Management"),
      ),

      body: Padding(
          padding: EdgeInsets.all(10),
        child: Obx((){

          if(controller.isLoading.value) {
            return Center(child: CircularProgressIndicator(),);
          }

          if(controller.quotesList.isEmpty){
            return Center(child: Text("No Quotes Found"),);
          }

          return ListView.separated(
              itemBuilder: (context,index){
                final quotes = controller.quotesList[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    
                      title: Text(
                        quotes.quoteText ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          quotes.categoryName ?? "",
                          style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      trailing: Column(

                        children: [
                          Expanded(
                            child: IconButton(
                              onPressed: () {

                                Get.to(() => UpdateQuotesScreen(
                                  quote: quotes,
                                ));
                              },
                              icon: Icon(Icons.edit),
                              color: Colors.blue,
                              tooltip: "Edit Quote",
                            ),
                          ),

                          SizedBox(height: 20,),


                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                controller.deleteQuote(quotes.id.toString());
                              },
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              tooltip: "Delete Quote",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              },
              separatorBuilder: (context,snapshot){
                return SizedBox(height: 10,);
              },
              itemCount: controller.quotesList.length,

          );
        }),
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
      
        Get.to(AddQuotesScreen());
      }, child: Icon(Icons.add),),

    );


  }
}
