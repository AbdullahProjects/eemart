import 'package:eemart/consts/consts.dart';
import 'package:eemart/views/profile_screen/components/detail_Card.dart';
import 'package:eemart/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // edit profile button
            const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                )).onTap(() {}),
            10.heightBox,
            // user details section
            Row(
              children: [
                Image.asset(
                  imgProfile2,
                  width: 80,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make(),
                5.widthBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Dummy user".text.fontFamily(semibold).white.make(),
                      5.heightBox,
                      "customer@eg.com".text.white.make()
                    ],
                  ),
                ),
                5.widthBox,
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 1)),
                    onPressed: () {},
                    child: "Logout".text.fontFamily(semibold).white.make())
              ],
            ),
            // cards
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DetailCart(
                    width: context.screenWidth / 3.5,
                    count: "00",
                    title: "in your cart"),
                DetailCart(
                    width: context.screenWidth / 3.5,
                    count: "56",
                    title: "your wishlist"),
                DetailCart(
                    width: context.screenWidth / 3.5,
                    count: "2390",
                    title: "your orders")
              ],
            ),
            //
            20.heightBox,
          ],
        ),
      )),
    ));
  }
}
