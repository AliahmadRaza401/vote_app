import 'package:alibhaiapp/provider/auth_provider.dart';
import 'package:alibhaiapp/task/fb_Con.dart';
import 'package:alibhaiapp/task/singUp.dart';
import 'package:alibhaiapp/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode pasFocusNode = FocusNode();

  late AuthProvider authProvider;

  bool pass = true;
  bool cpass = true;
  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    // emailFocusNode.addListener(() {
    //   setState(() {});
    // });
    // pasFocusNode.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    emailController.dispose();
    pasFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = Provider.of<AuthProvider>(context).loading;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FadeInDown(
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.0.h),
                    child: Image.asset(
                      "assets/pic/ll.png",
                      height: 60.h,
                      width: 60.h,
                    ),
                  ),
                ),
                FadeInUp(
                  child: Column(
                    children: [
                      customInputField(
                        emailController,
                        emailFocusNode,
                        "Email",
                        MultiValidator([
                          authProvider.requiredValidator,
                          authProvider.emailValidator,
                        ]),
                      ),
                      SizedBox(height: 12.0),
                      customInputField(
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
                      const SizedBox(height: 20.0),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text("If you don't have an account? ",
                      //         style: TextStyle(fontWeight: FontWeight.bold)),
                      //     GestureDetector(
                      //       onTap: () {
                      //         AppRoutes.push(context,
                      //             PageTransitionType.rightToLeft, SignupPage());
                      //       },
                      //       child: Text(
                      //         "Register",
                      //         style: TextStyle(
                      //             color: Colors.blue,
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Center(
                  child: loading == true
                      ? Center(child: CircularProgressIndicator())
                      : FadeInUp(
                          child: GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                AuthServices.signIn(
                                    context,
                                    emailController.text,
                                    passwordController.text);
                              } else {
                                print("validaet");
                              }
                            },
                            child: Container(
                              width: double.infinity, // Set the desired width
                              height: 50, // Set the desired height
                              decoration: BoxDecoration(
                                color: Colors.blue, // Button color
                                borderRadius: BorderRadius.circular(
                                    10.0), // Border radius
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(0.5),
                                //     spreadRadius: 2,
                                //     blurRadius: 5,
                                //     offset: Offset(0, 2),
                                //   ),
                                // ],
                              ),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white, // Text color
                                    fontSize: 18.0, // Text font size
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
    );
  }
}
