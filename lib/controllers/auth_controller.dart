// created for handling all authentication related task
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eemart/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // text controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredentiall;

    try {
      await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context,
          msg: e.toString(), bgColor: redColor, textColor: whiteColor);
    }
    return userCredentiall;
  }

  // sign-up method
  Future<UserCredential?> signUpMethod({context, email, password}) async {
    UserCredential? userCredentiall;

    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context,
          msg: e.toString(), bgColor: redColor, textColor: whiteColor);
    }
    return userCredentiall;
  }

  // store data method
  storeUserData({name, password, email}) async {
    DocumentReference store = firestore.collection(usersCollection).doc();

    store.set(
        {'name': name, 'password': password, 'email': email, 'imageURL': ''});
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
