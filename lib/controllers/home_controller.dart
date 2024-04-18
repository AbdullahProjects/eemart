import 'package:eemart/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // when homeController will start, then initialize the getUserName method to get user name;
  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  // for shifting navigation bar from one screen to another
  var currentNavIndex = 0.obs;

  // get username
  var username = '';
  getUserName() async {
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
  }

  // search button
  var searchController = TextEditingController();
}
