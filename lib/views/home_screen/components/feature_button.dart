import 'package:eemart/consts/consts.dart';
import 'package:eemart/views/category_screen/category_details.dart';
import 'package:get/get.dart';

Widget FeaturedButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .width(200)
      .padding(const EdgeInsets.all(4))
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .roundedSM
      .shadowMd
      .outerShadowSm
      .white
      .make()
      .onTap(() {
    Get.to(() => CategoryDetails(title: title));
  });
}
