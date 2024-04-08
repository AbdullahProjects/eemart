import 'package:eemart/consts/consts.dart';

Widget FeaturedProduct({String? title, String? price, icon}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image.asset(
        icon,
        width: 150,
        fit: BoxFit.fill,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
      10.heightBox,
      price!.text.color(redColor).fontFamily(bold).size(16).make()
    ],
  )
      .box
      .white
      .roundedSM
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .padding(const EdgeInsets.all(8))
      .make();
}
