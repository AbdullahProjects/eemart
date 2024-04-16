import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eemart/consts/consts.dart';
import 'package:eemart/services/firestore_services.dart';
import 'package:eemart/widgets_common/loader.dart';

class WishlistDetails extends StatelessWidget {
  const WishlistDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlists".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getWishlist(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No wishlist yet!".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Image.network(
                        "${data[index]['p_imgs'][0]}",
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                      title: "${data[index]['p_name']}"
                          .text
                          .fontFamily(semibold)
                          .size(16)
                          .make(),
                      subtitle: "${data[index]['p_price']}"
                          .numCurrency
                          .text
                          .size(14)
                          .color(redColor)
                          .fontFamily(semibold)
                          .make(),
                      trailing: const Icon(
                        Icons.favorite,
                        color: redColor,
                      ).onTap(() async {
                        await firestore
                            .collection(productsCollection)
                            .doc(data[index].id)
                            .set({
                          'p_wishlist':
                              FieldValue.arrayRemove([currentUser!.uid])
                        }, SetOptions(merge: true));
                      }),
                    );
                  });
            }
          }),
    );
  }
}
