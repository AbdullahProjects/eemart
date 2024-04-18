import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eemart/consts/consts.dart';
import 'package:eemart/controllers/product_controller.dart';
import 'package:eemart/services/firestore_services.dart';
import 'package:eemart/views/category_screen/item_details.dart';
import 'package:eemart/widgets_common/bg_widget.dart';
import 'package:eemart/widgets_common/loader.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategory(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();
  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: whiteColor,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: widget.title!.text.fontFamily(bold).white.make(),
          ),
          body: Column(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      controller.subcat.length,
                      (index) => "${controller.subcat[index]}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make()
                              .box
                              .white
                              .height(50)
                              .padding(
                                  const EdgeInsets.symmetric(horizontal: 10))
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .roundedSM
                              .alignment(Alignment.center)
                              .make()
                              .onTap(() {
                            switchCategory("${controller.subcat[index]}");
                            setState(() {});
                          })),
                ),
              ),
              20.heightBox,
              StreamBuilder(
                  stream: productMethod,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(child: Center(child: loadingIndicator()));
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: "No products found in this category"
                              .text
                              .color(darkFontGrey)
                              .makeCentered(),
                        ),
                      );
                    } else {
                      var data = snapshot.data!.docs;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      mainAxisExtent: 250),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      data[index]['p_imgs'][0],
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.fill,
                                    ),
                                    controller
                                        .shortenString(data[index]['p_name'])
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    5.heightBox,
                                    "${data[index]['p_price']}"
                                        .numCurrency
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
                                    .outerShadowSm
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .padding(const EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  // check product is in wishlist or not
                                  controller.checkIfFav(data[index]);
                                  // going towards item details
                                  Get.to(() => ItemDetails(
                                        title: "${data[index]['p_name']}",
                                        data: data[index],
                                      ));
                                });
                              }),
                        ),
                      );
                    }
                  }),
            ],
          )),
    );
  }
}
