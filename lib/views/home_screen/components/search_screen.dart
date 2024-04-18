import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eemart/consts/consts.dart';
import 'package:eemart/controllers/product_controller.dart';
import 'package:eemart/services/firestore_services.dart';
import 'package:eemart/views/category_screen/item_details.dart';
import 'package:eemart/widgets_common/loader.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    // product controller
    var controller = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
          future: FirestoreServices.searchProduct(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text(
                "No Products found!",
                style: TextStyle(color: darkFontGrey, fontFamily: semibold),
              ));
            } else {
              var searchData = snapshot.data!.docs;
              var searchFilteredData = searchData
                  .where((element) => element['p_name']
                      .toString()
                      .toLowerCase()
                      .contains(title!.toLowerCase()))
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 250),
                  children: searchFilteredData
                      .mapIndexed((currentValue, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                searchFilteredData[index]['p_imgs'][1],
                                width: 150,
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                              const Spacer(),
                              "${controller.shortenString(searchFilteredData[index]['p_name'])} "
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              5.heightBox,
                              "Rs. ${searchFilteredData[index]['p_price']}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make()
                            ],
                          )
                              .box
                              .white
                              .roundedSM
                              .outerShadowMd
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .padding(const EdgeInsets.all(12))
                              .make()
                              .onTap(() {
                            Get.to(() => ItemDetails(
                                  title:
                                      "${searchFilteredData[index]['p_name']}",
                                  data: searchFilteredData[index],
                                ));
                          }))
                      .toList(),
                ),
              );
            }
          }),
    );
  }
}
