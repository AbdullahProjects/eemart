import 'package:eemart/consts/consts.dart';
import 'package:eemart/consts/lists.dart';
import 'package:eemart/controllers/auth_controller.dart';
import 'package:eemart/views/auth_screen/signup_screen.dart';
import 'package:eemart/views/home_screen/home.dart';
import 'package:eemart/widgets_common/applogo_widget.dart';
import 'package:eemart/widgets_common/bg_widget.dart';
import 'package:eemart/widgets_common/custom_textfield.dart';
import 'package:eemart/widgets_common/our_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Login to $appname".text.white.fontFamily(bold).size(18).make(),
              15.heightBox,
              Column(
                children: [
                  CustomTextField(
                      hint: emailhint,
                      title: email,
                      isPass: false,
                      controller: controller.emailController),
                  CustomTextField(
                      hint: passwordhint,
                      title: password,
                      isPass: true,
                      controller: controller.passwordController),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPass.text.make())),
                  5.heightBox,
                  OurButton(
                      title: login,
                      textcolor: whiteColor,
                      colour: redColor,
                      onPress: () async {
                        await controller
                            .loginMethod(context: context)
                            .then((value) {
                          if (value != null) {
                            VxToast.show(context,
                                msg: "Logged in successfully",
                                bgColor: redColor,
                                textColor: whiteColor);
                            Get.offAll(() => const Home());
                          }
                        });
                      }).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  OurButton(
                      title: signup,
                      textcolor: redColor,
                      colour: lightGolden,
                      onPress: () {
                        Get.to(() => const SignUpScreen());
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: lightGrey,
                                child: Image.asset(
                                  socialIconsList[index],
                                  width: 30,
                                ),
                              ),
                            )),
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
