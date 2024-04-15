import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eemart/consts/consts.dart';
import 'package:eemart/services/firestore_services.dart';
import 'package:eemart/widgets_common/loader.dart';

class MessagesDetails extends StatelessWidget {
  const MessagesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Messages".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllMessages(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No messages yet!".text.color(darkFontGrey).makeCentered();
            } else {
              return Container();
            }
          }),
    );
  }
}
