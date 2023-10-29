import 'package:alibhaiapp/provider/auth_provider.dart';
import 'package:alibhaiapp/task/fb_Con.dart';
import 'package:alibhaiapp/task/singUp.dart';
import 'package:alibhaiapp/widgets/app_toast.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
  Widget build(BuildContext context) {
    bool loading = Provider.of<AuthProvider>(context).loading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text('Update Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FadeInUp(
                child: Column(
                  children: [
                    const SizedBox(height: 12.0),
                    customInputField(
                        passwordController,
                        pasFocusNode,
                        " Update Password",
                        MultiValidator([
                          authProvider.requiredValidator,
                        ]),
                        isPassword: pass, onPressed: () {
                      setState(() {
                        pass = !pass;
                      });
                    }),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
              Center(
                child: loading == true
                    ? const Center(child: CircularProgressIndicator())
                    : FadeInUp(
                        child: GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              AuthServices.changePassword(
                                  context, passwordController.text);
                            } else {
                              print("validaet");
                              AppToast("Error", false);
                            }
                          },
                          child: Container(
                            width: double.infinity, // Set the desired width
                            height: 50, // Set the desired height
                            decoration: BoxDecoration(
                              color: Colors.blue, // Button color
                              borderRadius:
                                  BorderRadius.circular(10.0), // Border radius
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
                                'Update Password',
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
    );
  }
}
