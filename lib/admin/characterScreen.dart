import 'dart:developer';

import 'package:alibhaiapp/admin/admin_service.dart';
import 'package:alibhaiapp/models/adminVoteAddModel.dart';
import 'package:alibhaiapp/provider/auth_provider.dart';
import 'package:alibhaiapp/task/singUp.dart';
import 'package:alibhaiapp/widgets/app_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminCharacterScreen extends StatefulWidget {
  const AdminCharacterScreen({super.key});

  @override
  State<AdminCharacterScreen> createState() => _AdminCharacterScreenState();
}

class _AdminCharacterScreenState extends State<AdminCharacterScreen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('vote').snapshots();

  TextEditingController voteName = TextEditingController();
  TextEditingController searchCont = TextEditingController();

  FocusNode pasFocusNode = FocusNode();
  FocusNode searFocusNode = FocusNode();

  List charList = [];
  List searchList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 213, 219, 222),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: customInputField(voteName, pasFocusNode,
                            "Add Char", MultiValidator([]),
                            onPressed: () {}),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (voteName.text.isNotEmpty) {
                            var uuid = const Uuid();
                            var voteId = uuid.v4();
                            log('voteId= $voteId');
                            await VoteServices().addVote(
                              voteId,
                              voteName.text,
                              context,
                            );
                            voteName.clear();
                          } else {
                            AppToast("Char Required", true);
                          }
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
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: customInputField(
                      searchCont,
                      searFocusNode,
                      "Search Char",
                      MultiValidator([]),
                      onPressed: () {},
                      onChanged: (e) {
                        print(charList.length);
                        searchList = charList
                            .where((element) =>
                                element['voteName'].toString().toLowerCase() ==
                                e.toString().toLowerCase())
                            .toList();
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(Icons.info),
                      Text("  On Tap on any character for Update"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.info),
                      Text("  Long press on any character for delection"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
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

                      List data =
                          searchCont.text.isEmpty ? charList : searchList;

                      return searchCont.text.isNotEmpty && searchList.isEmpty
                          ? Center(
                              child: Text("No Data"),
                            )
                          : SingleChildScrollView(
                              child: Container(
                                // color: Colors.amber,
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                child: GridView.builder(
                                  itemCount: data.length,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        4, // number of items in each row
                                    mainAxisSpacing:
                                        8.0, // spacing between rows
                                    crossAxisSpacing:
                                        8.0, // spacing between columns
                                  ),
                                  itemBuilder: (context, index) {
                                    // return Text("data");

                                    return GestureDetector(
                                      onLongPress: () async {
                                        await VoteServices().deleteChar(
                                            snapshot.data!.docs[index].id,
                                            context);

                                        AppToast(
                                            "Char Deleted Successfully", true);
                                      },
                                      onTap: () async {
                                        // if (itemSelected[index] == false) {
                                        //   setState(() {
                                        //     itemSelected[index] = !itemSelected[index];
                                        //   });

                                        //   int total = int.parse(snapshot
                                        //           .data!.docs[index]['totalVote']
                                        //           .toString()) +
                                        //       1;

                                        //   print('total: ${total}');

                                        //   await VoteServices().SelectVoteByUser(
                                        //       snapshot.data!.docs[index].id,
                                        //       total.toString(),
                                        //       context);

                                        //   await Future.delayed(Duration(seconds: 2));

                                        //   setState(() {
                                        //     itemSelected[index] = !itemSelected[index];
                                        //   });
                                        // }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        // margin: const EdgeInsets.symmetric(
                                        //     vertical: 10, horizontal: 15),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2, color: Colors.white),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          data[index]['voteName'],
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                    },
                  ),

                  // SizedBox(
                  //   width: 325,
                  //   child: TextFormField(
                  //     textCapitalization: TextCapitalization.sentences,
                  //     style: const TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 14,
                  //       fontFamily: 'SF-Regular',
                  //     ),
                  //     // validator: validator,
                  //     controller: voteName,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         voteName.text = value;
                  //       });
                  //     },
                  //     keyboardType: TextInputType.text,
                  //     decoration: InputDecoration(
                  //       fillColor: Colors.grey,
                  //       border: InputBorder.none,
                  //       focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(5),
                  //           ),
                  //           borderSide: BorderSide.none),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(
                  //           Radius.circular(5),
                  //         ),
                  //         borderSide: BorderSide.none,
                  //       ),
                  //       errorBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(
                  //           Radius.circular(5),
                  //         ),
                  //         borderSide: BorderSide.none,
                  //       ),
                  //       filled: true,
                  //       contentPadding: EdgeInsets.symmetric(
                  //         vertical: 13,
                  //         horizontal: 12,
                  //       ),
                  //       hintText: 'Enter Character',
                  //       hintStyle: TextStyle(
                  //         color: Colors.green,
                  //         fontSize: 14,
                  //         fontFamily: 'SF-Regular',
                  //       ),
                  //     ),
                  //     maxLines: 5,
                  //   ),
                  // ),

                  // voteName.text.isEmpty
                  //     ? const SizedBox()
                  //     : Padding(
                  //         padding: const EdgeInsets.symmetric(vertical: 10),
                  //         child: ElevatedButton(
                  //             onPressed: () async {
                  //               var uuid = const Uuid();
                  //               var voteId = uuid.v4();
                  //               log('voteId= $voteId');
                  //               await VoteServices().addVote(
                  //                 voteId,
                  //                 voteName.text,
                  //                 context,
                  //               );
                  //               voteName.clear();
                  //             },
                  //             child: const Text('Add Character')),
                  //       )
                ],
              ),
            ),
          ),
        ));
  }
}
