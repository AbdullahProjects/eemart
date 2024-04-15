import 'package:eemart/consts/consts.dart';

Widget orderStatus({icon, color, title, showdone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    )
        .box
        .border(color: color)
        .roundedSM
        .padding(const EdgeInsets.all(4))
        .make(),
    title: "__________".text.make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(darkFontGrey).size(14).make(),
          showdone
              ? const Icon(
                  Icons.done,
                  color: redColor,
                )
              : Container()
        ],
      ),
    ),
  );
}
