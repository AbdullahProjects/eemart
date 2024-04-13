// created for handling all authentication related task
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eemart/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  // login text controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  // chats controller

  // login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      currentUser = userCredential.user;
    } on FirebaseAuthException catch (e) {
      VxToast.show(context,
          msg: e.toString(), bgColor: redColor, textColor: whiteColor);
    }
    return userCredential;
  }

  // sign-up method
  Future<UserCredential?> signUpMethod({context, email, password}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      currentUser = userCredential.user;
    } on FirebaseAuthException catch (e) {
      VxToast.show(context,
          msg: e.toString(), bgColor: redColor, textColor: whiteColor);
    }
    return userCredential;
  }

  // store data method
  storeUserData({name, password, email}) async {
    if (currentUser != null) {
      DocumentReference store =
          firestore.collection(usersCollection).doc(currentUser!.uid);
      // Set the user data with the correct uid
      await store.set({
        'name': name,
        'password': password,
        'email': email,
        'imageURL': '',
        'id': currentUser!.uid,
        'cart_count': "00",
        'order_count': "00",
        'wishlist_count': "00",
      });
    }
  }

  // signout method
  signOutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context,
          msg: e.toString(), bgColor: redColor, textColor: whiteColor);
    }
  }
}
