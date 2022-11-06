import 'package:currencyapp/Models/Auth_Models/User_Models.dart';
import 'package:currencyapp/View/Screens/Auth_Screens/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../View/Screens/Coins_Screen.dart';

class Auth_Provider extends ChangeNotifier{
  FirebaseAuth login_auth = FirebaseAuth.instance;
  FirebaseFirestore database = FirebaseFirestore.instance;
  GoogleSignIn googleSignIn=GoogleSignIn();
  UserModel user = UserModel(name: '', email: "", userId: "",image: "");
  bool obscure_text = true;

  void login({ required String email ,required String password})async{
    try{
    await login_auth.signInWithEmailAndPassword(email: email, password: password);
    Get.offAll(Coins_Screen());
    }
    catch(e){
      Get.snackbar("login error", e.toString(),snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red);
    }
  }

  void register({required String email ,required String password,required String name})async{
    try{
    await login_auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      print(value);
      saveuser(value, name,email);
    });
    Get.offAll(Coins_Screen());
    }
    catch(e){
      Get.snackbar("Sign up error", e.toString(),snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red);

    }
  }

  void logout()async{
    await login_auth.signOut();
    Get.to(LoginScreen());
  }

  void googlesignin()async{
    final GoogleSignInAccount? googleuser = await googleSignIn.signIn();

    GoogleSignInAuthentication google = await googleuser!.authentication;

    var credintal=GoogleAuthProvider.credential(idToken:google.idToken ,accessToken: google.accessToken);
    await login_auth.signInWithCredential(credintal).then((value) {
      saveuser(value, "","");
      Get.offAll(Coins_Screen());
    });
  }

  void saveuser(UserCredential user,String name,String email)async{
    UserModel userModel = UserModel(name: name==""?user.user!.displayName!:name,email:user.user!.email!,image: "", userId: user.user!.uid);
     database.collection("users").doc(user.user!.uid).set(userModel.toJson()).then((value) {
     }).catchError((error){print(error);});
  }
  getuser()async{
    await database.collection('users').doc(login_auth.currentUser!.uid).get().then((value) {
      user = UserModel.fromJson(value.data()!);
      notifyListeners();
    });
  }

  void password(){
    obscure_text=!obscure_text;
    notifyListeners();
  }
}