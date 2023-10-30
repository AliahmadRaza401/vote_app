import 'dart:developer';

import 'package:alibhaiapp/services/admin_service.dart';
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Character ',
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
                            .where((element) => element['voteName']
                                .toString()
                                .toLowerCase()
                                .contains(e.toString().toLowerCase()))
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
                                        5, // number of items in each row
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
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CustomDialog(
                                                initalValue: data[index]
                                                    ['voteName'],
                                                singleIndex:
                                                    snapshot.data!.docs[index],
                                              );
                                            });
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

class CustomDialog extends StatefulWidget {
  String initalValue;
  QueryDocumentSnapshot singleIndex;
  CustomDialog(
      {super.key, required this.initalValue, required this.singleIndex});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  TextEditingController? _updatecontroller;

  //  snapshot.data!.docs[index].id,
  @override
  void initState() {
    _updatecontroller = TextEditingController(text: widget.initalValue);
    super.initState();
  }

  dialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.center, // To make the card compact
          children: <Widget>[
            const Text(
              'Update Character',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: _updatecontroller,
                onChanged: (value) {
                  setState(() {
                    _updatecontroller!.text = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
                onPressed: () async {
                  await VoteServices().updateUser(
                      _updatecontroller!.text, widget.singleIndex.id, context);
                },
                child: const Text('Update'))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
