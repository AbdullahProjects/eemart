import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance; // for Firebase Authentication
FirebaseFirestore firestore = FirebaseFirestore.instance; // for interaction with Firebase Cloud Database
User? currentUser = auth.currentUser; // for getting current user that is signed-in or login-in

// collections
const usersCollection = "users";
