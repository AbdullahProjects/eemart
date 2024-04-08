import 'package:eemart/consts/consts.dart';
import 'package:eemart/controllers/auth_controller.dart';
import 'package:eemart/views/home_screen/home.dart';
import 'package:eemart/widgets_common/applogo_widget.dart';
import 'package:eemart/widgets_common/bg_widget.dart';
import 'package:eemart/widgets_common/custom_textfield.dart';
import 'package:eemart/widgets_common/our_button.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  // text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "$signup to $appname".text.white.fontFamily(bold).size(18).make(),
              15.heightBox,
              Obx(
                () => Column(
                  children: [
                    CustomTextField(
                        hint: nameHint,
                        title: name,
                        controller: nameController,
                        isPass: false),
                    CustomTextField(
                        hint: emailhint,
                        title: email,
                        controller: emailController,
                        isPass: false),
                    CustomTextField(
                        hint: passwordhint,
                        title: password,
                        controller: passwordController,
                        isPass: true),
                    CustomTextField(
                        hint: passwordhint,
                        title: retypePassword,
                        controller: passwordRetypeController,
                        isPass: true),
                    Row(
                      children: [
                        Checkbox(
                            checkColor: redColor,
                            value: isCheck,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            }),
                        Expanded(
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: "I agree to the ",
                                style: TextStyle(
                                    fontFamily: regular, color: fontGrey)),
                            TextSpan(
                                text: termsAndConditions,
                                style: TextStyle(
                                    fontFamily: regular, color: redColor)),
                            TextSpan(
                                text: " & ",
                                style: TextStyle(
                                    fontFamily: regular, color: fontGrey)),
                            TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                    fontFamily: regular, color: redColor))
                          ])),
                        )
                      ],
                    ),
                    10.heightBox,
                    // condition; whether Circle progress indicator or Button will show
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : OurButton(
                            title: signup,
                            textcolor: whiteColor,
                            colour: isCheck == true ? redColor : lightGrey,
                            onPress: () async {
                              if (isCheck != false) {
                                // enable circular progress indicator before starting loading process
                                controller.isLoading(true);
                                try {
                                  await controller
                                      .signUpMethod(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context,
                                  )
                                      .then((value) {
                                    return controller.storeUserData(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                    );
                                  }).then((value) {
                                    VxToast.show(context,
                                        msg: "Logged in successfully",
                                        bgColor: redColor,
                                        textColor: whiteColor);
                                    Get.offAll(() => const Home());
                                  });
                                } catch (e) {
                                  auth.signOut();
                                  VxToast.show(context, msg: e.toString());
                                  controller.isLoading(false);
                                }
                              }
                            }).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: alreadyHaveAccount,
                          style: TextStyle(fontFamily: bold, color: fontGrey)),
                      TextSpan(
                          text: login,
                          style: TextStyle(fontFamily: bold, color: redColor))
                    ])).onTap(() {
                      Get.back();
                    }),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
