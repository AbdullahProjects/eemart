import 'package:eemart/consts/consts.dart';

Widget DetailCart({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.color(darkFontGrey).size(16).fontFamily(semibold).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make()
    ],
  )
      .box
      .white
      .roundedSM
      .width(width)
      .height(80)
      .padding(const EdgeInsets.all(4))
      .make();
}
