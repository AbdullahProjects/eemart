import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eemart/consts/consts.dart';
import 'package:eemart/services/firestore_services.dart';
import 'package:eemart/widgets_common/loader.dart';
import 'package:eemart/order_screen/orders_details.dart';
import 'package:get/get.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllOrders(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No orders yet!".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: "${index + 1}"
                          .text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .xl
                          .make(),
                      title: data[index]['order_code']
                          .toString()
                          .text
                          .fontFamily(semibold)
                          .color(redColor)
                          .make(),
                      subtitle: data[index]['total_amount']
                          .toString()
                          .numCurrency
                          .text
                          .fontFamily(bold)
                          .make(),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded,
                            color: darkFontGrey),
                        onPressed: () {
                          Get.to(() => orderPlaceDetails(data: data[index]));
                        },
                      ),
                    );
                  });
            }
          }),
    );
  }
}
