import 'package:alibhaiapp/task/auth_provider.dart';
import 'package:alibhaiapp/task/fb_Con.dart';
import 'package:alibhaiapp/task/login.dart';
import 'package:alibhaiapp/task/motion_toast.dart';
import 'package:alibhaiapp/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode pasFocusNode = FocusNode();

  FocusNode cpasFocusNode = FocusNode();
  late AuthProvider authProvider;
  bool _isChecked = false;

  bool pass = true;
  bool cpass = true;
  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    emailFocusNode.addListener(() {
      setState(() {});
    });
    pasFocusNode.addListener(() {
      setState(() {});
    });
    cpasFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    pasFocusNode.dispose();
    cpasFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = Provider.of<AuthProvider>(context).loading;

    Color labelColor = emailFocusNode.hasFocus ? Colors.green : Colors.grey;
    Color pasColor = pasFocusNode.hasFocus ? Colors.green : Colors.grey;

    Color cPasColor = cpasFocusNode.hasFocus ? Colors.green : Colors.grey;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FadeInDown(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.0.h),
                      child: Image.asset(
                        "assets/pic/logo_t.jpeg",
                        height: 60.h,
                        width: 60.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 120.0.h),
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
                        SizedBox(height: 16.0),
                        customInputField(cPasswordController, cpasFocusNode,
                            "Confirm Password", authProvider.passwordValidator,
                            isPassword: cpass, onPressed: () {
                          setState(() {
                            cpass = !cpass;
                          });
                        }),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("If you don't have an account? ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () {
                                AppRoutes.push(context,
                                    PageTransitionType.rightToLeft, Login());
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100.0.h),
                  FadeInUp(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Accept Terms and Conditions",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            Checkbox(
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value ?? false;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Center(
                          child: loading == true
                              ? Center(child: CircularProgressIndicator())
                              : GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      String password = passwordController.text;
                                      String confirmPassword =
                                          cPasswordController.text;

                                      if (password == confirmPassword) {
                                        AuthServices.signUp(
                                            context,
                                            emailController.text,
                                            passwordController.text);
                                      } else {
                                        print('Passwords do not match');

                                        MyMotionToast.error(
                                          context,
                                          "Oops!",
                                          "Passwords do not match",
                                        );
                                      }
                                    } else {
                                      print("validaet");
                                    }
                                  },
                                  child: Container(
                                    width: double
                                        .infinity, // Set the desired width
                                    height: 50, // Set the desired height
                                    decoration: BoxDecoration(
                                      color: Colors.blue, // Button color
                                      // Button color
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
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Colors.white, // Text color
                                          fontSize: 18.0, // Text font size
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ],
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

Widget customInputField(
  TextEditingController controller,
  FocusNode focusNode,
  String label,
  String? Function(String?)? validator, {
  bool? isPassword,
  Function()? onPressed,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    // autocorrect: true,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    focusNode: focusNode,
    obscureText: isPassword == null
        ? false
        : isPassword, // Set obscureText to true for password fields
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? Colors.green : Colors.grey,
        ),
        hintText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusNode.hasFocus ? Colors.green : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusNode.hasFocus ? Colors.green : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: isPassword == null
            ? SizedBox()
            : IconButton(
                icon: Icon(
                  isPassword == false ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: onPressed,
              )),
  );
}
