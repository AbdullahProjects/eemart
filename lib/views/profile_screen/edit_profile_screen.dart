import 'dart:io';
import 'package:eemart/consts/consts.dart';
import 'package:eemart/controllers/profile_controller.dart';
import 'package:eemart/widgets_common/bg_widget.dart';
import 'package:eemart/widgets_common/custom_textfield.dart';
import 'package:eemart/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  final dynamic data;
  const EditProfile({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Display User Image
            // logic
            // if imageURL in database and controller image path is empty
            data["imageURL"] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                  // if imageURL is not empty but controller image path is empty
                : data["imageURL"] != "" && controller.profileImgPath.isEmpty
                    ? Image.network(
                        data["imageURL"],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                      // if both are empty
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
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
            CustomTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false),
            CustomTextField(
                controller: controller.passController,
                hint: passwordhint,
                title: password,
                isPass: true),
            20.heightBox,
            // Save changes button
            // run loader, until changes not saved successfully
            controller.isLoading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: OurButton(
                        title: "Save",
                        textcolor: whiteColor,
                        colour: redColor,
                        onPress: () async {
                          controller.isLoading(true);
                          await controller.uploadProfileImage();
                          await controller.updateProfile(
                              name: controller.nameController.text,
                              password: controller.passController.text,
                              imageUrl: controller.profileImgLink);
                          VxToast.show(context,
                              msg: "Updated",
                              textColor: whiteColor,
                              bgColor: redColor);
                        }))
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
      ),
    ));
  }
}
