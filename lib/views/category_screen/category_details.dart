import 'package:eemart/consts/consts.dart';
import 'package:eemart/controllers/product_controller.dart';
import 'package:eemart/views/category_screen/item_details.dart';
import 'package:eemart/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: title!.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        .padding(const EdgeInsets.symmetric(horizontal: 10))
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .roundedSM
                        .alignment(Alignment.center)
                        .make()),
              ),
            ),
            20.heightBox,
            Expanded(
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      mainAxisExtent: 250),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          imgP5,
                          width: 200,
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                        "Laptop 4GM"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        5.heightBox,
                        "\$400"
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
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .padding(const EdgeInsets.all(12))
                        .make()
                        .onTap(() {
                      Get.to(() => const ItemDetails(title: "Dummy Title"));
                    });
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
