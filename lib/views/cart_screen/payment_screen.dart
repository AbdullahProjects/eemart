import 'package:eemart/consts/consts.dart';
import 'package:eemart/consts/lists.dart';
import 'package:eemart/controllers/cart_controller.dart';
import 'package:eemart/views/home_screen/home.dart';
import 'package:eemart/widgets_common/loader.dart';
import 'package:eemart/widgets_common/our_button.dart';
import 'package:get/get.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // cart controller
    var controller = Get.find<CartController>();

    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 8, right: 3, left: 3),
            child: Obx(() => SizedBox(
                  height: 55,
                  // button; continue to payment method
                  child: controller.placingOrder.value
                      ? Center(child: loadingIndicator())
                      : OurButton(
                          title: "Place my order",
                          textcolor: whiteColor,
                          colour: redColor,
                          onPress: () async {
                            await controller.placeMyOrder(
                                orderPaymentMethod:
                                    paymentMethods[controller.paymentIndex.value],
                                totalAmount: controller.totalP.value);
                            await controller.clearCart();
                            VxToast.show(context,
                                msg: "Order placed successfully");
                            Get.offAll(() => const Home());
                          })),
            )),
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              // payment method list
              children: List.generate(paymentMethodList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.all(3),
                    margin: const EdgeInsets.only(bottom: 8),
                    // container decoration
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 3,
                            color: controller.paymentIndex.value == index
                                ? redColor
                                : Colors.transparent,
                            style: BorderStyle.solid)),

                    // Image and Checkbox inside stack
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        // Image =======
                        Image.asset(
                          paymentMethodList[index],
                          width: double.infinity,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.4)
                              : Colors.transparent,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        // checkbox =====
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.2,
                                child: Checkbox(
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    value: true,
                                    onChanged: (value) {}),
                              )
                            : Container(),
                        // title ======
                        Positioned(
                            bottom: 5,
                            right: 10,
                            child: paymentMethods[index]
                                .text
                                .white
                                .fontFamily(semibold)
                                .size(16)
                                .make()
                                .box
                                .color(lightGreen)
                                .padding(const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 5))
                                .roundedSM
                                .make())
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      );
  }
}
