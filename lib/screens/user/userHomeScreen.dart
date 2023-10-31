import 'package:alibhaiapp/services/admin_service.dart';
import 'package:alibhaiapp/screens/Authentication/login.dart';
import 'package:alibhaiapp/screens/user/profileScreen.dart';
import 'package:alibhaiapp/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../services/auth_services.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  List<bool> itemSelected =
      List.generate(1000, (index) => false); // Assuming 9 items

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('vote').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 213, 219, 222),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 0, right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '',
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  AppRoutes.push(
                                      context,
                                      PageTransitionType.fade,
                                      // const Login(),
                                      UserProfileScreen());
                                },
                                icon: const Icon(Icons.person)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Vote for your favourite Character',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'PlusJakartaSans-Bold',
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.amber,
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // number of items in each row
                            mainAxisSpacing: 8.0, // spacing between rows
                            crossAxisSpacing: 8.0, // spacing between columns
                          ),
                          itemBuilder: (context, index) {
                            // return Text("data");

                            return GestureDetector(
                              onTap: () async {
                                if (itemSelected[index] == false) {
                                  setState(() {
                                    itemSelected[index] = !itemSelected[index];
                                  });

                                  int total = int.parse(snapshot
                                          .data!.docs[index]['totalVote']
                                          .toString()) +
                                      1;

                                  print('total: ${total}');

                                  await VoteServices().SelectVoteByUser(
                                      snapshot.data!.docs[index].id,
                                      total.toString(),
                                      context);

                                  await Future.delayed(Duration(seconds: 1));

                                  setState(() {
                                    itemSelected[index] = !itemSelected[index];
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                // margin: const EdgeInsets.symmetric(
                                //     vertical: 10, horizontal: 15),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: !itemSelected[index]
                                          ? Colors.white
                                          : Color.fromARGB(168, 173, 200, 100)),
                                  color: !itemSelected[index]
                                      ? Colors.white
                                      : Color.fromARGB(168, 173, 200, 100)
                                          .withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  snapshot.data!.docs[index]['voteName'],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
