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

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoply/core/service/firestore_user.dart';
import 'package:shoply/model/user_model.dart';
import 'package:shoply/utils/enum.dart';
import 'package:shoply/utils/image_functions.dart';
import 'package:shoply/view/Explore_tab_view/explore_tab_view.dart';
import 'package:shoply/view/auth/login_screen/login_screen.dart';
import 'package:shoply/view/control_view.dart';
import 'package:shoply/view/home_Screen.dart';

class AuthViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  static AuthViewModel get instance => Get.find();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // get authenticated user data
  User get authUser => _auth.currentUser!;
  // String? email, password, name;
  final email = TextEditingController();
  final password = TextEditingController();
  String? name;
  final Rx<User?> _user = Rx<User?>(null);

  String get user => _user.value?.email ?? '';

  // get isAuthenticated user
  bool get isAuthenticated => _auth.currentUser != null;

  UserModel? _cachedUserModel;
  Uint8List? pickedImage;

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
    update();
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

  pickImage(String pickType) async {
    Uint8List? temp;
    if (pickType == 'gallery') {
      temp = await ImageFunctions.galleryPicker();
    } else if (pickType == 'camera') {
      temp = await ImageFunctions.cameraPicker();
    }
    if (temp != null) {
      pickedImage = temp;
      update();
    }
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

      await _auth.signInWithCredential(credential).then((user) async {
        await saveUser(user);
        await fetchUserData();
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
      //start loading
      _loading.value = true;
      update();
      await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      await fetchUserData();
      //Get.offAll(ExploreTabView());
      Get.offAll(ControlView());

      _loading.value = false;
    } on FirebaseAuthException catch (e) {
      _loading.value = false;
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
      _loading.value = false;
      print('signIn error: $e'); // Print general error information
      Get.snackbar(
        'Error login account',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    update();
  }

  void createAccountWithEmailAndPassword() async {
    try {
      //start loading
      _loading.value = true;
      update();
      if (email != null && password != null) {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
        saveUser(userCredential);
        Get.offAll(LoginScreen());

        _loading.value = false;
      } else {
        _loading.value = false;
        Get.snackbar(
          'Error',
          'Email and Password cannot be null',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _loading.value = false;
      print('createAccount error: $e');
      Get.snackbar(
        'Error register account',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    update();
  }

  Future<void> saveUser(UserCredential user) async {
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
    // Clear the text controllers
    email.clear();
    password.clear();
    Get.offAll(() => LoginScreen());
  }

  // Future<void> registerAdmin() async {
  //   try {
  //     _loading.value = true;
  //     update();
  //     // register user with email and password
  //     await _auth.createUserWithEmailAndPassword(
  //         email: 'admin@example.com', password: 'admin123');
  //
  //     // create admin record in firestore
  //     await FireStoreUser().addUserToFireStore(UserModel(
  //       userId: _auth.currentUser?.uid ?? '',
  //       email: 'admin@example.com',
  //       name: 'Admin',
  //       picture: '',
  //       role: AppRole.admin,
  //     ));
  //
  //     _loading.value = false;
  //
  //     //redirect
  //     FireStoreUser().screenRedirect();
  //   } catch (e) {
  //     _loading.value = false;
  //     Get.snackbar(
  //       'Error register account',
  //       e.toString(),
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  //   update();
  // }
}
