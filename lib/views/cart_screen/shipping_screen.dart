import 'package:eemart/consts/consts.dart';
import 'package:eemart/controllers/cart_controller.dart';
import 'package:eemart/views/cart_screen/payment_screen.dart';
import 'package:eemart/widgets_common/custom_textfield.dart';
import 'package:eemart/widgets_common/our_button.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // cart controller
    var controller = Get.find<CartController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 8, right: 3, left: 3),
          child: SizedBox(
            height: 55,
            // button; continue to payment method
            child: OurButton(
                title: "Continue",
                textcolor: whiteColor,
                colour: redColor,
                onPress: () {
                  // form handling ===============================================================
                  if (controller.addressController.text.length > 10) {
                    if (controller.cityController.text.length >= 2) {
                      if (controller.stateController.text.length >= 2) {
                        if (controller.postalCodeController.text.length >= 6 &&
                            controller.postalCodeController.text.length <= 8) {
                          if (controller.phoneController.text.length == 12 || controller.phoneController.text.length == 11) {
                            Get.to(() => const PaymentDetails());
                          } else {
                            VxToast.show(context,
                                msg: "Please enter right Phone Number",
                                showTime: 3000);
                          }
                        } else {
                          VxToast.show(context,
                              msg: "Please enter right Postal Code",
                              showTime: 3000);
                        }
                      } else {
                        VxToast.show(context,
                            msg: "Please enter right State", showTime: 3000);
                      }
                    } else {
                      VxToast.show(context,
                          msg: "Please enter right City", showTime: 3000);
                    }
                  } else {
                    VxToast.show(context,
                        msg: "Please enter complete Address", showTime: 3000);
                  }
                }),
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // text fields; address, city, state, postal code, phone ================================
              CustomTextField(
                  hint: "Address",
                  isPass: false,
                  title: "Address",
                  controller: controller.addressController),
              CustomTextField(
                  hint: "e.g., Pakistan",
                  isPass: false,
                  title: "City",
                  controller: controller.cityController),
              CustomTextField(
                  hint: "e.g., Punjab",
                  isPass: false,
                  title: "State",
                  controller: controller.stateController),
              CustomTextField(
                  hint: "Postal Code",
                  isPass: false,
                  title: "Postal Code",
                  controller: controller.postalCodeController),
              CustomTextField(
                  hint: "e.g., 03xx-1234567",
                  isPass: false,
                  title: "Phone",
                  controller: controller.phoneController),
            ],
          ),
        ),
      ),
    );
  }
}
