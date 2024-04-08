import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eemart/consts/consts.dart';
import 'package:eemart/consts/lists.dart';
import 'package:eemart/controllers/auth_controller.dart';
import 'package:eemart/controllers/profile_controller.dart';
import 'package:eemart/services/firestore_services.dart';
import 'package:eemart/views/auth_screen/login_screen.dart';
import 'package:eemart/views/profile_screen/components/detail_Card.dart';
import 'package:eemart/views/profile_screen/edit_profile_screen.dart';
import 'package:eemart/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
                stream: FirestoreServices.getUser(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    );
                  } else {
                    // storing user data
                    // var data = snapshot.data!.docs[0];

                    return SafeArea(
                        child: Column(
                      children: [
                        // edit profile button
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              )).onTap(() {
                            Get.to(() => const EditProfile());
                          }),
                        ),
                        // user details section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
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
                                    "Dummy Text"
                                        .text
                                        .fontFamily(semibold)
                                        .white
                                        .make(),
                                    5.heightBox,
                                    "customer@egx.com".text.white.make()
                                  ],
                                ),
                              ),
                              5.widthBox,
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Colors.white, width: 1)),
                                  onPressed: () async {
                                    await Get.put(AuthController())
                                        .signOutMethod(context);
                                    Get.offAll(() => const LoginScreen());
                                  },
                                  child: "Logout"
                                      .text
                                      .fontFamily(semibold)
                                      .white
                                      .make())
                            ],
                          ),
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
                        // buttons list
                        ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: Image.asset(
                                      profileButtonIcon[index],
                                      width: 22,
                                    ),
                                    title: profileButtonList[index]
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    color: lightGrey,
                                  );
                                },
                                itemCount: profileButtonList.length)
                            .box
                            .white
                            .rounded
                            .shadowSm
                            .margin(const EdgeInsets.all(12))
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .make()
                            .box
                            .color(redColor)
                            .make()
                      ],
                    ));
                  }
                })));
  }
}
