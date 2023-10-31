import 'package:alibhaiapp/screens/admin/adminUpdatePassword.dart';
import 'package:alibhaiapp/screens/admin/update_password.dart';
import 'package:alibhaiapp/screens/Authentication/login.dart';
import 'package:alibhaiapp/screens/Authentication/singUp.dart';
import 'package:alibhaiapp/widgets/app_toast.dart';
import 'package:alibhaiapp/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:page_transition/page_transition.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  TextEditingController voteName = TextEditingController();
  TextEditingController searchCont = TextEditingController();

  FocusNode pasFocusNode = FocusNode();
  FocusNode searFocusNode = FocusNode();

  List charList = [];
  List searchList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 219, 222),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Users ',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: customInputField(
                        searchCont,
                        searFocusNode,
                        "Search User",
                        MultiValidator([]),
                        onPressed: () {},
                        onChanged: (e) {
                          print(charList.length);
                          searchList = charList
                              .where((element) => element['name']
                                  .toString()
                                  .toLowerCase()
                                  .contains(e.toString().toLowerCase()))
                              .toList();
                          setState(() {});
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        AppRoutes.push(
                            context, PageTransitionType.fade, SignupPage());
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // shape: BoxShape.circle,
                            color: Colors.blue
                            //  Color.fromARGB(168, 173, 200, 100),
                            ),
                        child: Text(
                          "+",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }

                    charList = snapshot.data!.docs.toList();

                    List data = searchCont.text.isEmpty ? charList : searchList;

                    return searchCont.text.isNotEmpty && searchList.isEmpty
                        ? Center(
                            child: Text("No Data"),
                          )
                        : ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              ListView.builder(
                                itemCount: data.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  // return Text("data");

                                  return ListTile(
                                    leading: Icon(Icons.person_3),
                                    trailing: IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(
                                                  snapshot.data!.docs[index].id)
                                              .delete();
                                        },
                                        icon: Icon(
                                          Icons.delete_forever_rounded,
                                          color: Colors.redAccent,
                                        )),
                                    title: Text(
                                      data[index]['name'],
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    subtitle: Text(
                                      data[index]['email'],
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
