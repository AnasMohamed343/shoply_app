// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shoply/core/service/firestore_user.dart';
// import 'package:shoply/model/user_model.dart';
// import 'package:shoply/view/auth/login_screen/login_screen.dart';
// import 'package:shoply/view/home_Screen.dart';
//
// class AuthViewModel extends GetxController {
//   GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   //FacebookLogin _facebookLogin = FacebookLogin();
//   String? email, password, name;
//   Rx<User?> _user = Rx<User>(FirebaseAuth.instance.currentUser!);
//   //Rx<User> _user = Rx<User>();
//   String get user => _user.value?.email ?? '';
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     _user.bindStream(_auth.authStateChanges());
//   }
//
//   @override
//   void onReady() {
//     // TODO: implement onReady
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     // TODO: implement onClose
//     super.onClose();
//   }
//
//   void googleSignInMethod() async {
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//     print(googleUser);
//
//     final GoogleSignInAuthentication googleSignInAuthentication =
//         await googleUser!.authentication;
//
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleSignInAuthentication.accessToken,
//       idToken: googleSignInAuthentication.idToken,
//     );
//
//     await _auth.signInWithCredential(credential).then((user) {
//       saveUser(user);
//       Get.offAll(HomeScreen());
//     });
//   }
//
//   void signInWithEmailAndPassword() async {
//     try {
//       await _auth.signInWithEmailAndPassword(
//           email: email ?? '', password: password ?? '');
//       Get.offAll(HomeScreen());
//     } catch (e) {
//       print('signIn error: $e');
//       Get.snackbar(
//         'Error login account',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   // void createAccountWithEmailAndPassword() async {
//   //   try {
//   //     await _auth
//   //         .createUserWithEmailAndPassword(
//   //             email: email ?? '', password: password ?? '')
//   //         .then((user) async {
//   //       saveUser(user);
//   //     });
//   //     Get.offAll(LoginScreen());
//   //   } catch (e) {
//   //     print('createAccount error: $e');
//   //     Get.snackbar(
//   //       'Error register account',
//   //       e.toString(),
//   //       snackPosition: SnackPosition.BOTTOM,
//   //       backgroundColor: Colors.red,
//   //       colorText: Colors.white,
//   //     );
//   //   }
//   // }
//   void createAccountWithEmailAndPassword() async {
//     try {
//       if (email != null && password != null) {
//         UserCredential userCredential =
//             await _auth.createUserWithEmailAndPassword(
//           email: email!,
//           password: password!,
//         );
//         saveUser(userCredential);
//         Get.offAll(LoginScreen());
//       } else {
//         Get.snackbar(
//           'Error',
//           'Email and Password cannot be null',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       print('createAccount error: $e');
//       Get.snackbar(
//         'Error register account',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   void saveUser(UserCredential user) async {
//     await FireStoreUser().addUserToFireStore(UserModel(
//       userId: user.user?.uid ?? '',
//       email: user.user?.email ?? '',
//       name: name == null ? user.user?.displayName ?? '' : name ?? '',
//       picture: '',
//     ));
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoply/core/service/firestore_user.dart';
import 'package:shoply/model/user_model.dart';
import 'package:shoply/view/Explore_tab_view/explore_tab_view.dart';
import 'package:shoply/view/auth/login_screen/login_screen.dart';
import 'package:shoply/view/home_Screen.dart';

class AuthViewModel extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? email, password, name;
  Rx<User?> _user = Rx<User?>(null);

  String get user => _user.value?.email ?? '';

  UserModel? _cachedUserModel;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    if (_auth.currentUser != null) {
      fetchUserData();
    }
  }

  Future<void> fetchUserData() async {
    _cachedUserModel =
        await FireStoreUser().getUser(_auth.currentUser?.uid ?? '');
  }

  UserModel get userModel {
    if (_cachedUserModel == null) {
      fetchUserData();
    }
    return _cachedUserModel ??
        UserModel(
          userId: _user.value?.uid ?? '',
          email: _user.value?.email ?? '',
          name: _user.value?.displayName ?? '',
          picture: _user.value?.photoURL ?? '',
        );
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   _user.bindStream(_auth.authStateChanges());
  // }

  void googleSignInMethod() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    print(googleUser);

    if (googleUser != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await _auth.signInWithCredential(credential).then((user) {
        saveUser(user);
        Get.offAll(ExploreTabView());
      });
    }
  }

  //
  // void signInWithEmailAndPassword() async {
  //   try {
  //     await _auth.signInWithEmailAndPassword(
  //       email: email ?? '',
  //       password: password ?? '',
  //     );
  //     Get.offAll(HomeScreen());
  //   } catch (e) {
  //     print('signIn error: $e');
  //     Get.snackbar(
  //       'Error login account',
  //       e.toString(),
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }
  void signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email ?? '',
        password: password ?? '',
      );
      Get.offAll(ExploreTabView());
    } on FirebaseAuthException catch (e) {
      print('signIn error: $e'); // Print detailed error information
      if ((e.code == 'user-not-found') || (e.code == 'wrong-password')) {
        Get.snackbar(
          'wrong email or password',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error login account',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('signIn error: $e'); // Print general error information
      Get.snackbar(
        'Error login account',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void createAccountWithEmailAndPassword() async {
    try {
      if (email != null && password != null) {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );
        saveUser(userCredential);
        Get.offAll(LoginScreen());
      } else {
        Get.snackbar(
          'Error',
          'Email and Password cannot be null',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('createAccount error: $e');
      Get.snackbar(
        'Error register account',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void saveUser(UserCredential user) async {
    await FireStoreUser().addUserToFireStore(UserModel(
      userId: user.user?.uid ?? '',
      email: user.user?.email ?? '',
      name: name ?? user.user?.displayName ?? '',
      picture: '',
    ));
  }

  void signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    Get.offAll(LoginScreen());
  }
}
