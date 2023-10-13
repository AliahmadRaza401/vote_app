// // ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

// import 'dart:math';

// import 'package:alibhaiapp/task/auth_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';

// class AuthServices {
//   static var errorMessage;

//   //SignIn
//   static signIn(BuildContext context, String email, String password) async {
//     final auth = FirebaseAuth.instance;
//     AuthProvider _authProvider =
//         Provider.of<AuthProvider>(context, listen: false);
//     _authProvider.isLoading(true);
//     try {
//       await auth
//           .signInWithEmailAndPassword(email: email, password: password)
//           .then((uid) => {
//                 AppRoutes.pushAndRemoveUntil(
//                   context,
//                   PageTransitionType.fade,
//                   MyNavigationBarScreen(),
//                 ),
//                 MyMotionToast.success(
//                   context,
//                   "Welcome",
//                   'LogIn Success',
//                 ),
//                 _authProvider.isLoading(false),
//               });
//     } on FirebaseAuthException catch (error) {
//       switch (error.code) {
//         case "invalid-email":
//           errorMessage = "Your email address is invalid.";
//           break;
//         case "wrong-password":
//           errorMessage = "Your password is wrong.";
//           break;
//         case "user-not-found":
//           errorMessage = "User with this email doesn't exist.";
//           break;
//         case "user-disabled":
//           errorMessage = "User with this email has been disabled.";
//           break;
//         case "too-many-requests":
//           errorMessage = "Too many requests";
//           break;
//         case "operation-not-allowed":
//           errorMessage = "Signing in with Email and Password is not enabled.";
//           break;
//         default:
//           errorMessage = "your password or email address is invalid";
//       }
//       _authProvider.isLoading(false);

//       // // GeneralDialogs.showOopsDialog(context, errorMessage);
//       MyMotionToast.error(
//         context,
//         "UnAuthorized",
//         errorMessage,
//       );
//       return "false";
//     }
//   }

//   // SignUp-----------------------------------------
//   static Future signUp(
//     BuildContext context,
//     String email,
//     String pass,
//   ) async {
//     final _auth = FirebaseAuth.instance;
//     AuthProvider _authProvider =
//         Provider.of<AuthProvider>(context, listen: false);
//     _authProvider.isLoading(true);
//     try {
//       print("User Creating_______________________");

//       await _auth
//           .createUserWithEmailAndPassword(email: email, password: pass)
//           .then((value) => {
//                 print("User Created_______________________"),
//                 _authProvider.isLoading(false),
//                 AppRoutes.pushAndRemoveUntil(
//                     context, PageTransitionType.fade, Login()),
//                 MyMotionToast.success(
//                   context,
//                   "Succeess",
//                   'User Created Successfully',
//                 ),
//               })
//           .catchError((e) {
//         print('catchError e: $e');
//         MyMotionToast.error(
//           context,
//           "Error",
//           e!.message,
//         );

//         _authProvider.isLoading(false);
//       });
//     } on FirebaseAuthException catch (error) {
//       switch (error.code) {
//         case "invalid-email":
//           errorMessage = "Your email address is invalid";
//           break;
//         case "wrong-password":
//           errorMessage = "Your password is wrong.";
//           break;
//         case "user-not-found":
//           errorMessage = "User with this email doesn't exist.";
//           break;
//         case "user-disabled":
//           errorMessage = "User with this email has been disabled.";
//           break;
//         case "too-many-requests":
//           errorMessage = "Too many requests";
//           break;
//         case "operation-not-allowed":
//           errorMessage = "Signing in with Email and Password is not enabled.";
//           break;
//         default:
//           errorMessage = "An undefined Error happened.";
//       }

//       _authProvider.isLoading(false);
//       MyMotionToast.error(
//         context,
//         "Oops!",
//         errorMessage,
//       );
//     }
//   }

//   static getUserFromGoogle(BuildContext context) async {
//     try {
//       print("Google SignIn__________________");
//       FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//       User? user;

//       final GoogleSignIn googleSignIn = GoogleSignIn();

//       final GoogleSignInAccount? googleSignInAccount =
//           await googleSignIn.signIn();
//       print("Google SignIn__________________1");

//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//             await googleSignInAccount.authentication;

//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken,
//         );
//         print("Google SignIn__________________2");

//         try {
//           final UserCredential userCredential =
//               await firebaseAuth.signInWithCredential(credential);
//           print("Google SignIn__________________3");

//           user = userCredential.user;
//           debugPrint('user:______________ $user');
//           AppRoutes.pushAndRemoveUntil(
//               context, PageTransitionType.fade, Login());
//         } on FirebaseAuthException catch (e) {
//           if (e.code == 'account-exists-with-different-credential') {
//             // KSnackBar().errorSnackBar("The account already exists with a different credential");
//           } else if (e.code == 'invalid-credential') {
//             // KSnackBar().errorSnackBar("Error occurred while accessing credentials. Try again.");
//           }
//           return "error";
//         } catch (e) {
//           // KSnackBar().errorSnackBar("Error occurred using Google Sign In. Try again.");
//           return "error";
//         }
//       } else {
//         print("Google SignIn__________________error");

//         return "error";
//       }
//     } catch (e) {
//       print("catch error: $e");
//       // KSnackBar().errorSnackBar("Error occurred using Google Sign In. Try again.");
//       return "error";
//     }
//   }

//   // static postDetailsToFirestore(
//   //     BuildContext context,
//   //     fullName,
//   //     email,
//   //     password,
//   //     mobileNumber,
//   //     dp,
//   //     vDp,
//   //     vehicleCompany,
//   //     vehicleNumber,
//   //     vehicleRegNumber,
//   //     vehicleDesign,
//   //     vehicleChassisNumber) async {
//   //   final _auth = FirebaseAuth.instance;
//   //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   //   User? user = _auth.currentUser;
//   //   AuthProvider _authProvider =
//   //       Provider.of<AuthProvider>(context, listen: false);

//   //   var userImage =
//   //       await FirebaseServices.imageUpload(dp, email.toString(), context);
//   //   var vehicleImage =
//   //       await FirebaseServices.imageUpload(vDp, email.toString(), context);
//   //   DriverModel driverModel = DriverModel(
//   //     fullName: fullName,
//   //     email: email,
//   //     password: password,
//   //     mobileNumber: mobileNumber,
//   //     dp: userImage.toString(),
//   //     vDp: vehicleImage.toString(),
//   //     vehicleCompany: vehicleCompany,
//   //     vehicleNumber: vehicleNumber,
//   //     vehicleRegNumber: vehicleRegNumber,
//   //     vehicleDesign: vehicleDesign,
//   //     vehicleChassisNumber: vehicleChassisNumber,
//   //     orderCount: 0,
//   //     status: 'pending',
//   //     wallet: 0,
//   //     level: 1,
//   //   );

//   //   await firebaseFirestore.collection("drivers").doc(user!.uid).set({
//   //     'id': user.uid,
//   //     'fullName': fullName,
//   //     'email': email,
//   //     'password': password,
//   //     'mobileNumber': mobileNumber,
//   //     'dp': userImage.toString(),
//   //     'vDp': vehicleImage.toString(),
//   //     'vehicleCompany': vehicleCompany,
//   //     'vehicleNumber': vehicleNumber,
//   //     'vehicleRegNumber': vehicleRegNumber,
//   //     'vehicleDesign': vehicleDesign,
//   //     'vehicleChassisNumber': vehicleChassisNumber,
//   //     'rating': 5.0,
//   //     'level': 1,
//   //     'wallet': 0,
//   //     'orderCount': 0,
//   //     'status': "pending",
//   //     'createdAt': DateTime.now(),
//   //   }).then((value) {
//   //     _authProvider.isLoading(false);
//   //     showBottomSheetForDriver(context);

//   //     // AppRoutes.push(context, LoginPage());
//   //     _authProvider.carDesignController.clear();
//   //     _authProvider.carDesignController.clear();
//   //     _authProvider.chassisNumberController.clear();
//   //     _authProvider.companyController.clear();
//   //     _authProvider.emailController.clear();
//   //     _authProvider.engineController.clear();
//   //     _authProvider.nameController.clear();
//   //     _authProvider.passwordController.clear();
//   //     _authProvider.phoneNumberController.clear();
//   //     _authProvider.pinCodeController.clear();
//   //     _authProvider.registrationNumberController.clear();

//   //     MyMotionToast.success(
//   //       context,
//   //       "Success".tr,
//   //       'Account created successfully :) '.tr,
//   //     );
//   //   }).catchError((e) {
//   //     print('e: $e');
//   //     MyMotionToast.error(
//   //       context,
//   //       "Oops!".tr,
//   //       'Some thing went wrong Please try again later'.tr,
//   //     );
//   //   });
//   // }
// }

// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'dart:developer';
import 'package:alibhaiapp/models/adminVoteAddModel.dart';
import 'package:alibhaiapp/task/motion_toast.dart';
import 'package:alibhaiapp/widgets/app_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VoteServices {
  static var errorMessage;
// Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('vote');

  Future<void> addVote(
    String voteId,
    String voteName,
    BuildContext context,
  ) {
    // Call the user's CollectionReference to add a new user
    return users.add({
      'voteName': voteName.toUpperCase(),
      'votingDate': DateTime.now(),
      'totalVote': 0,
      'voteId': voteId,
    }).then((value) {
      AppToast('Vote  Added', true);
    }).catchError((error) {
      AppToast('Vote Not Added', false);
    });
  }

  Future<void> SelectVoteByUser(
    String docID,
    String totalVote,
    BuildContext context,
  ) {
    // Call the user's CollectionReference to add a new user
    return FirebaseFirestore.instance.collection('vote').doc(docID).update({
      'votingDate': DateTime.now(),
      'totalVote': totalVote,
    }).then((value) {
      AppToast('Vote Submitted', true);
    }).catchError((error) {
      AppToast('Vote Not Submitted', false);
    });
  }
  //SignIn
  // static signIn(BuildContext context, String email, String password) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   AdminProvider adminProvider =
  //       Provider.of<AdminProvider>(context, listen: false);
  //   adminProvider.isLoading(true);
  //   try {
  //     await auth
  //         .signInWithEmailAndPassword(email: email, password: password)
  //         .then((uid) => {
  //               if (email == 'admin@gmail.com' || password == 'admin12')
  //                 {
  //                   log('Admin Side '),
  //                   ShearedprefService.setUserTpe('admin'),
  //                   ShearedprefService.setUserIDStore(uid.user!.uid),
  //                   ShearedprefService.setUserLoggedIn(true),
  //                   AppRoutes.pushAndRemoveUntil(
  //                     context,
  //                     PageTransitionType.fade,
  //                     const AdminBottomNavigationBarScreen(),
  //                   ),
  //                 }
  //               else
  //                 {
  //                   log('User Side '),
  //                   ShearedprefService.setUserTpe('user'),
  //                   ShearedprefService.setUserIDStore(uid.user!.uid),
  //                   ShearedprefService.setUserLoggedIn(true),
  //                   AppRoutes.pushAndRemoveUntil(
  //                     context,
  //                     PageTransitionType.fade,
  //                     const UserHomeScreen(),
  //                   ),
  //                 },
  //               MyMotionToast.success(
  //                 context,
  //                 "Welcome",
  //                 'LogIn Success',
  //               ),
  //               _authProvider.isLoading(false),
  //             });
  //   } on FirebaseAuthException catch (error) {
  //     switch (error.code) {
  //       case "invalid-email":
  //         errorMessage = "Your email address is invalid.";
  //         break;
  //       case "wrong-password":
  //         errorMessage = "Your password is wrong.";
  //         break;
  //       case "user-not-found":
  //         errorMessage = "User with this email doesn't exist.";
  //         break;
  //       case "user-disabled":
  //         errorMessage = "User with this email has been disabled.";
  //         break;
  //       case "too-many-requests":
  //         errorMessage = "Too many requests";
  //         break;
  //       case "operation-not-allowed":
  //         errorMessage = "Signing in with Email and Password is not enabled.";
  //         break;
  //       default:
  //         errorMessage = "your password or email address is invalid";
  //     }
  //     _authProvider.isLoading(false);

  //     // // GeneralDialogs.showOopsDialog(context, errorMessage);
  //     MyMotionToast.error(
  //       context,
  //       "UnAuthorized",
  //       errorMessage,
  //     );
  //     return "false";
  //   }
  // }
}
