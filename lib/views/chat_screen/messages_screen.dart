import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eemart/consts/consts.dart';
import 'package:eemart/services/firestore_services.dart';
import 'package:eemart/views/chat_screen/chat_screen.dart';
import 'package:eemart/widgets_common/loader.dart';
import 'package:get/get.dart';

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
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: const Color.fromARGB(255, 230, 228, 228),
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => const ChatScreen(), arguments: [
                                    data[index]['friend_name'],
                                    data[index]['toId']
                                  ]);
                                },
                                leading: const CircleAvatar(
                                  backgroundColor: redColor,
                                  child: Icon(
                                    Icons.person,
                                    color: whiteColor,
                                  ),
                                ),
                                title: "${data[index]['friend_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                subtitle:
                                    "${data[index]['last_msg']}".text.make(),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
