import 'package:eemart/consts/consts.dart';
import 'package:eemart/consts/lists.dart';
import 'package:eemart/controllers/product_controller.dart';
import 'package:eemart/views/home_screen/components/feature_product.dart';
import 'package:eemart/widgets_common/our_button.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: controller
              .shortenString(title!)
              .text
              .color(darkFontGrey)
              .fontFamily(bold)
              .make(),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.favorite_outline))
          ],
        ),
        body: Column(
          children: [
            // item detail ================================================================================
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Swiper
                        VxSwiper.builder(
                            autoPlay: true,
                            height: 350,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1.0,
                            itemCount: data['p_imgs'].length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                data['p_imgs'][index],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            }),
                        10.heightBox,
                        // product name
                        title!.text
                            .size(16)
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make(),
                        10.heightBox,
                        // product rating
                        VxRating(
                          isSelectable: false,
                          value: double.parse(data['p_rating']),
                          onRatingUpdate: (value) {},
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          count: 5,
                          size: 25,
                          maxRating: 5,
                        ),
                        10.heightBox,
                        // product price
                        "${data['p_price']}"
                            .numCurrency
                            .text
                            .color(redColor)
                            .size(18)
                            .fontFamily(bold)
                            .make(),
                        10.heightBox,
                        // product seller details
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  "Seller"
                                      .text
                                      .white
                                      .fontFamily(semibold)
                                      .make(),
                                  5.heightBox,
                                  "${data['p_seller']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make()
                                ],
                              ),
                            ),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.message_rounded,
                                color: darkFontGrey,
                              ),
                            )
                          ],
                        )
                            .box
                            .height(60)
                            .color(textfieldGrey)
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .make(),
                        20.heightBox,
                        // product further details : Color, quantity, price
                        Obx(
                          () => Column(
                            children: [
                              // row 1: product color
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Color"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ),
                                  Row(
                                    children: List.generate(
                                        data['p_colors'].length,
                                        (index) => Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                VxBox()
                                                    .size(40, 40)
                                                    .color(Color(
                                                            data['p_colors']
                                                                [index])
                                                        .withOpacity(1.0))
                                                    .roundedFull
                                                    .margin(const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4))
                                                    .make()
                                                    .onTap(() {
                                                  controller
                                                      .changeColorIndex(index);
                                                }),
                                                Visibility(
                                                    visible: index ==
                                                        controller
                                                            .colorIndex.value,
                                                    child: const Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            )),
                                  )
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                              // row 2: product quantity
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Quantity"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ),
                                  Row(children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.decreaseQuantity();
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.remove)),
                                    controller.quantity.value.text
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increaseQuantity(
                                              int.parse(data['p_quantity']));
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.add)),
                                    10.widthBox,
                                    "(${data['p_quantity']} available)"
                                        .text
                                        .color(textfieldGrey)
                                        .make()
                                  ]),
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                              // row 3: product price
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Total Price"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ),
                                  "${controller.totalPrice.value}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .size(16)
                                      .fontFamily(bold)
                                      .make()
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                            ],
                          ).box.white.roundedSM.shadowMd.make(),
                        ),

                        20.heightBox,
                        // description
                        "Description"
                            .text
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make(),
                        10.heightBox,
                        "${data['p_desc']}".text.color(darkFontGrey).make(),
                        10.heightBox,
                        const Divider(),
                        // view more details
                        ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              itemDetailButtonList.length,
                              (index) => ListTile(
                                    title: itemDetailButtonList[index]
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    trailing: const Icon(Icons.arrow_forward),
                                  )),
                        ),

                        20.heightBox,
                        // product you may also like
                        "Products you may also like"
                            .text
                            .size(16)
                            .fontFamily(bold)
                            .color(darkFontGrey)
                            .make(),

                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                6,
                                (index) => FeaturedProduct(
                                    title: featuredProducts[index],
                                    price: featuredProductsPrices[index],
                                    icon: featuredProductsImg[index])),
                          ),
                        )
                      ],
                    )))),

            // Add to Cart : Button ============================================================
            SizedBox(
              width: double.infinity,
              height: 60,
              child: OurButton(
                  title: "Add to Cart",
                  textcolor: whiteColor,
                  colour: redColor,
                  onPress: () {
                    controller.addToCart(
                      context: context,
                      title: data['p_name'],
                      img: data['p_imgs'][0],
                      sellername: data['p_seller'],
                      color: data['p_colors'][controller.colorIndex.value],
                      qty: controller.quantity.value,
                      tprice: controller.totalPrice.value,
                    );
                    VxToast.show(context, msg: "Added to Cart");
                  }),
            ),
            5.heightBox
          ],
        ),
      ),
    );
  }
}
