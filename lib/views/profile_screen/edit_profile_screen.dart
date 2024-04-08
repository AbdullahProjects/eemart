import 'dart:io';
import 'package:eemart/consts/consts.dart';
import 'package:eemart/controllers/profile_controller.dart';
import 'package:eemart/widgets_common/bg_widget.dart';
import 'package:eemart/widgets_common/custom_textfield.dart';
import 'package:eemart/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Display User Image
          Obx(() {
            return controller.profileImgPath.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                : Image.file(
                    File(controller.profileImgPath.value),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make();
          }),
          10.heightBox,
          // Change Image option
          OurButton(
              title: "Change",
              textcolor: whiteColor,
              colour: redColor,
              onPress: () {
                controller.changeImage(context);
              }),
          const Divider(),
          20.heightBox,
          // Change Name and Password option
          CustomTextField(hint: nameHint, title: name, isPass: false),
          CustomTextField(hint: passwordhint, title: password, isPass: true),
          20.heightBox,
          // Save changes
          SizedBox(
              width: context.screenWidth - 60,
              child: OurButton(
                  title: "Save",
                  textcolor: whiteColor,
                  colour: redColor,
                  onPress: () {}))
        ],
        // whole container
      )
          .box
          .shadowSm
          .white
          .rounded
          .padding(const EdgeInsets.all(16))
          .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
          .make(),
    ));
  }
}
