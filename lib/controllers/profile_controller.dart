import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eemart/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImgPath = ''.obs;
  var profileImgLink = '';
  var isLoading = false.obs;

  // text fields
  var nameController = TextEditingController();
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();

  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (img == null) return;
      profileImgPath.value = img.path;
    } catch (e) {
      VxToast.show(context,
          msg: e.toString(), bgColor: redColor, textColor: whiteColor);
    }
  }

  uploadProfileImage(context) async {
    try {
      var filename = basename(profileImgPath.value);
      var destination = 'images/${currentUser!.uid}/$filename';
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(File(profileImgPath.value));
      profileImgLink = await ref.getDownloadURL();
    } catch (e) {
      VxToast.show(context,
          msg: e.toString(),
          textColor: whiteColor,
          bgColor: redColor,
          showTime: 10000);
    }
  }

  updateProfile({context, name, password, imageUrl}) async {
    try {
      // Wait for image upload to complete
      var store = firestore.collection(usersCollection).doc(currentUser!.uid);
      await store.set(
          {'name': name, 'password': password, 'imageURL': imageUrl},
          SetOptions(merge: true));
      isLoading(false);
    } catch (e) {
      VxToast.show(context,
          msg: e.toString(), textColor: whiteColor, bgColor: redColor);
    }
  }

  changeAuthPassword({email, password, newPassword}) async {
    final credential =
        EmailAuthProvider.credential(email: email, password: password);

    await currentUser!.reauthenticateWithCredential(credential).then((value) {
      currentUser!.updatePassword(newPassword);
    });
  }
}
