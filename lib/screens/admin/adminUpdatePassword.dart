import 'dart:developer';
import 'package:alibhaiapp/provider/auth_provider.dart';
import 'package:alibhaiapp/services/shearedpref_service.dart';
import 'package:alibhaiapp/services/auth_services.dart';
import 'package:alibhaiapp/screens/Authentication/singUp.dart';
import 'package:alibhaiapp/widgets/app_toast.dart';
import 'package:alibhaiapp/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../Authentication/login.dart';
import 'adminBottomBar.dart';

class AdminPasswordChangeScreen extends StatefulWidget {
  AdminPasswordChangeScreen({Key? key}) : super(key: key);

  @override
  State<AdminPasswordChangeScreen> createState() =>
      _AdminPasswordChangeScreenState();
}

class _AdminPasswordChangeScreenState extends State<AdminPasswordChangeScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode pasFocusNode = FocusNode();
  FocusNode confirmpasFocusNode = FocusNode();

  late AuthProvider authProvider;

  bool pass = true;
  bool cpass = true;
  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    bool loading = Provider.of<AuthProvider>(context).loading;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 219, 222),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            AppRoutes.pop(context);
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Update Password',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                ShearedprefService.setUserLoggedIn(false);
                ShearedprefService.setUserTpe('');
                AppRoutes.pushAndRemoveUntil(
                  context,
                  PageTransitionType.fade,
                  const Login(),
                );
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.disabled,
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeIn(
                    child: customInputField(
                        passwordController,
                        pasFocusNode,
                        "Password",
                        MultiValidator([
                          authProvider.requiredValidator,
                        ]),
                        isPassword: pass, onPressed: () {
                      setState(() {
                        pass = !pass;
                      });
                    }),
                  ),
                  const SizedBox(height: 20),
                  FadeIn(
                    child: customInputField(
                        confirmPasswordController,
                        confirmpasFocusNode,
                        "Confirm Password",
                        MultiValidator([
                          authProvider.requiredValidator,
                        ]),
                        isPassword: cpass, onPressed: () {
                      setState(() {
                        cpass = !cpass;
                      });
                    }),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: loading == true
                        ? const Center(child: CircularProgressIndicator())
                        : FadeInUp(
                            child: GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (passwordController.text.toString() ==
                                      confirmPasswordController.text
                                          .toString()) {
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .isLoading(true);
                                    ShearedprefService.setAdminPassword(
                                        passwordController.text);
                                    AppToast(
                                        'Password Changed Successfully', false);

                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .isLoading(false);
                                    AppRoutes.pushAndRemoveUntil(
                                      context,
                                      PageTransitionType.fade,
                                      const AdminBottomNavigationBarScreen(),
                                    );
                                  } else {
                                    AppToast(
                                        'Password not match to the confirm password',
                                        true);
                                  }
                                } else {
                                  AppToast('Please Validate First', true);
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Update Password',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
