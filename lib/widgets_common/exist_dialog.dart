import 'package:eemart/consts/consts.dart';
import 'package:eemart/widgets_common/our_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.size(18).fontFamily(bold).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit?"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OurButton(
                title: "Yes",
                textcolor: whiteColor,
                colour: redColor,
                onPress: () {
                  SystemNavigator.pop();
                }),
            OurButton(
                title: "No",
                textcolor: whiteColor,
                colour: redColor,
                onPress: () {
                  Navigator.pop(context);
                })
          ],
        )
      ],
    ).box.padding(const EdgeInsets.all(12)).color(lightGrey).roundedSM.make(),
  );
}
