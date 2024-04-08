import 'package:eemart/consts/consts.dart';
import 'package:eemart/consts/lists.dart';
import 'package:eemart/views/home_screen/components/feature_product.dart';
import 'package:eemart/widgets_common/our_button.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  const ItemDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline))
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
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              imgFc6,
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
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        size: 25,
                        stepInt: true,
                      ),
                      10.heightBox,
                      // product price
                      "\$35,000"
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
                                "Seller".text.white.fontFamily(semibold).make(),
                                5.heightBox,
                                "In House Brands"
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
                      Column(
                        children: [
                          // row 1: product color
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                    3,
                                    (index) => VxBox()
                                        .size(40, 40)
                                        .color(Vx.randomPrimaryColor)
                                        .roundedFull
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 4))
                                        .make()),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          // row 2: product quantity
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Quantity".text.color(textfieldGrey).make(),
                              ),
                              Row(children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.remove)),
                                "0"
                                    .text
                                    .color(darkFontGrey)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add)),
                                10.widthBox,
                                "(0 available)".text.color(textfieldGrey).make()
                              ])
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
                              "\$0.00"
                                  .text
                                  .color(redColor)
                                  .size(16)
                                  .fontFamily(bold)
                                  .make()
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.roundedSM.shadowMd.make(),

                      10.heightBox,
                      // description
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      "This is a dummy item description text."
                          .text
                          .color(darkFontGrey)
                          .make(),

                      10.heightBox,
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
                onPress: () {}),
          ),
          5.heightBox
        ],
      ),
    );
  }
}
