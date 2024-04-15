import 'package:eemart/consts/consts.dart';
import 'package:eemart/order_screen/order_status.dart';

class orderPlaceDetails extends StatelessWidget {
  final dynamic data;
  const orderPlaceDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order details"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Column(
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
              color: Colors.yellow,
              icon: Icons.car_repair,
              showdone: data['order_on_delivery']),
          orderStatus(
              title: "Delivered",
              color: Colors.purple,
              icon: Icons.done_all_sharp,
              showdone: data['order_delivery']),
        ],
      ),
    );
  }
}
