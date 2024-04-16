import 'package:eemart/consts/consts.dart';
import 'package:eemart/controllers/product_controller.dart';
import 'package:eemart/order_screen/order_place_details.dart';
import 'package:eemart/order_screen/order_status.dart';
import 'package:get/get.dart';
// for formatting time
import 'package:intl/intl.dart' as intl;

class orderPlaceDetails extends StatelessWidget {
  final dynamic data;
  const orderPlaceDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order details"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              orderStatus(
                  title: "Placed",
                  color: redColor,
                  icon: Icons.done,
                  showdone: data['order_placed']),
              orderStatus(
                  title: "Confirmed",
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  showdone: data['order_confirmed']),
              orderStatus(
                  title: "On Delivery",
                  color: const Color.fromARGB(255, 231, 209, 6),
                  icon: Icons.car_repair,
                  showdone: data['order_on_delivery']),
              orderStatus(
                  title: "Delivered",
                  color: Colors.purple,
                  icon: Icons.done_all_sharp,
                  showdone: data['order_delivery']),
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlacedDetailsRow(
                      title1: "Order Code",
                      title2: "Shipping Method",
                      d1: data['order_code'],
                      d2: data['shipping_method']),
                  orderPlacedDetailsRow(
                      title1: "Order Date",
                      title2: "Payment Method",
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format((data['order_data'].toDate())),
                      d2: data['payment_method']),
                  orderPlacedDetailsRow(
                    title1: "Payment Status",
                    title2: "Delivery Status",
                    d1: "Unpaid",
                    d2: "Order Placed",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                            "${data['order_by_postalCode']}".text.make()
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: "Rs. ${data['total_amount']}"
                                    .text
                                    .size(16)
                                    .color(redColor)
                                    .fontFamily(semibold)
                                    .make(),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ).box.white.outerShadowMd.make(),
              // const Divider(),
              20.heightBox,
              "Ordered Products"
                  .text
                  .size(17)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered(),
              10.heightBox,

              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlacedDetailsRow(
                          title1: controller
                              .shortenString2(data['orders'][index]['title']),
                          title2: "Rs. ${data['orders'][index]['tprice']}",
                          d1: "${data['orders'][index]['qty']}x",
                          d2: "Refundable"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: 30,
                          height: 20,
                          color: Color(data['orders'][index]['color']),
                        ),
                      ),
                      10.heightBox
                    ],
                  );
                }).toList(),
              )
                  .box
                  .white
                  .outerShadowMd
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),

              20.heightBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "SUB TOTAL"
                        .text
                        .size(16)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                    "Rs. ${data['total_amount']}".text.color(redColor).make()
                  ],
                ),
              ),
              10.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
