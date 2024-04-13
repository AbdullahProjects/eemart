import '../../../consts/consts.dart';

Widget senderMessage() {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
        color: redColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20))),
    child: Column(
      children: [
        "Assalam o Alikum, How are you brother. Hope you are fine. Acha yar ma na ya product order karni ha. Iss ka elawa kon sa colours ha ap pass"
            .text
            .white
            .size(16)
            .make(),
        10.heightBox,
        "11:45 PM".text.color(whiteColor.withOpacity(0.6)).make()
      ],
    ),
  );
}
