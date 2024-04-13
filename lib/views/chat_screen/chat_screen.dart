import 'package:eemart/consts/consts.dart';
import 'package:eemart/controllers/chats_controller.dart';
import 'package:eemart/views/chat_screen/components/sender_message.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    // var controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Chatting with Seller"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView(
              children: [senderMessage(), senderMessage()],
            )),
            10.heightBox,

            // button;
            Row(
              children: [
                // text field;
                Expanded(
                    child: TextFormField(
                  controller: controller.msgController,
                  decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey))),
                )),
                // send button;
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.grey,
                    ))
              ],
            )
                .box
                .height(80)
                .padding(const EdgeInsets.all(12))
                .margin(const EdgeInsets.only(bottom: 8))
                .make()
          ],
        ),
      ),
    );
  }
}
