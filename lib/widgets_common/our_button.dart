import 'package:eemart/consts/consts.dart';

Widget OurButton(
    {required String title,
    required Color textcolor,
    required Color colour,
    required onPress}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: colour, padding: const EdgeInsets.all(12)),
    onPressed: onPress,
    child: title.text.color(textcolor).fontFamily(bold).make(),
  );
}
