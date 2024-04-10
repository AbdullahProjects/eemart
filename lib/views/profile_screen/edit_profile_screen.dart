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
  // const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(() => Column(
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
                        : data["imageURL"] != "" &&
                                controller.profileImgPath.isEmpty
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
                    10.heightBox,
                    CustomTextField(
                        controller: controller.oldPassController,
                        hint: passwordhint,
                        title: oldpass,
                        isPass: true),
                    10.heightBox,
                    CustomTextField(
                        controller: controller.newPassController,
                        hint: passwordhint,
                        title: newpass,
                        isPass: true),
                    20.heightBox,
                    // Save changes button
                    // run loader, until changes not saved successfully
                    Obx(() => controller.isLoading.value
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
                                // handle case: if new image is not selected
                                if (controller
                                    .profileImgPath.value.isNotEmpty) {
                                  await controller.uploadProfileImage(context);
                                } else {
                                  controller.profileImgLink = data["imageURL"];
                                }

                                // handle case: if old password is matching or not
                                if (data["password"] ==
                                    controller.oldPassController.text) {
                                  await controller.changeAuthPassword(
                                      email: data["email"],
                                      password:
                                          controller.oldPassController.text,
                                      newPassword:
                                          controller.newPassController.text);

                                  await controller.updateProfile(
                                    context: context,
                                    name: controller.nameController.text,
                                    password: controller.newPassController.text,
                                    imageUrl: controller.profileImgLink,
                                  );
                                  VxToast.show(
                                    context,
                                    msg: "Updated",
                                    textColor: whiteColor,
                                    bgColor: redColor,
                                  );
                                } else {
                                  VxToast.show(
                                    context,
                                    msg: "Wrong Password",
                                    textColor: whiteColor,
                                    bgColor: redColor,
                                  );
                                  controller.isLoading(false);
                                }
                              },
                            ),
                          )),
                    // )
                  ],
                  // whole container
                ))
            .box
            .shadowSm
            .white
            .rounded
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .make(),
      ),
    );
  }
}
