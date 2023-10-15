import 'dart:developer';

import 'package:alibhaiapp/admin/line_chart.dart';
import 'package:alibhaiapp/models/adminVoteAddModel.dart';
import 'package:alibhaiapp/services/shearedpref_service.dart';
import 'package:alibhaiapp/task/login.dart';
import 'package:alibhaiapp/utils/images.dart';
import 'package:alibhaiapp/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('vote').snapshots();

  List data = [];
  @override
  Widget build(BuildContext context) {
    var totalScore = 0;
    List<int> totalVoteList = [];
    List<DateTime> votingDatesList = [];
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        for (var item in snapshot.data!.docs) {
          totalScore += int.parse(item['totalVote'].toString());
          totalVoteList.add(int.parse(item['totalVote'].toString()));
          votingDatesList.add(item["votingDate"].toDate());
        }

        return SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),

                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  color: const Color.fromARGB(255, 213, 219, 222),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 0, right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Dashboard',
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  ShearedprefService.setUserLoggedIn(false);
                                  AppRoutes.pushAndRemoveUntil(
                                    context,
                                    PageTransitionType.fade,
                                    const Login(),
                                  );
                                },
                                icon: const Icon(Icons.logout))
                          ],
                        ),
                      ),
                      // total Sore
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.1,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Total Votes',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              height: 50,
                              // width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.amber.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  totalScore.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Top Character
                      topFiveCherecter(snapshot.data!.docs),
                      //  Character Popularity
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin:
                            const EdgeInsets.only(top: 30, right: 10, left: 10),
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 15,
                          bottom: 20,
                        ),
                        // height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(180, 100, 200, 200),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Character Popularity",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            characterPopularity(snapshot.data!.docs),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     Container(
                            //       height: 40,
                            //       width: 100,
                            //       margin: const EdgeInsets.only(top: 10, right: 10),
                            //       decoration: BoxDecoration(
                            //           color: Colors.white,
                            //           borderRadius: BorderRadius.circular(30)),
                            //       child: const Padding(
                            //         padding: EdgeInsets.all(8.0),
                            //         child: Text(
                            //           "Morning",
                            //           style: TextStyle(
                            //             fontSize: 20,
                            //             fontWeight: FontWeight.w500,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Container(
                            //       height: 40,
                            //       width: 110,
                            //       margin: EdgeInsets.only(top: 10, right: 10),
                            //       decoration: BoxDecoration(
                            //           color: Colors.white,
                            //           borderRadius: BorderRadius.circular(30)),
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Text(
                            //           "Afternoon",
                            //           style: TextStyle(
                            //             fontSize: 20,
                            //             fontWeight: FontWeight.w500,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      FadeIn(
                        child: LineChartSample1(
                          voteCounts: totalVoteList,
                          votingDates: votingDatesList,
                          // voteCounts: [
                          //   10,
                          //   20,
                          //   30,
                          //   25,
                          //   15,
                          //   40
                          // ], // Dummy vote counts
                          // votingDates: [
                          //   DateTime(2023, 10, 15, 8, 30),
                          //   DateTime(2023, 10, 15, 9, 0),
                          //   DateTime(2023, 10, 15, 10, 15),
                          //   DateTime(2023, 10, 15, 11, 0),
                          //   DateTime(2023, 10, 15, 12, 30),
                          //   DateTime(2023, 10, 15, 13, 0),
                          // ],
                        ),
                      ),
                      //  All vote
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "All Votes",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          // height: MediaQuery.of(context).size.height * 0.2,
                          // height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(168, 173, 200, 100),
                          ),
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]['voteName'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Divider(
                                      color: Colors.amber,
                                      thickness: 2,
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]['totalVote']
                                          .toString(),
                                    )
                                  ],
                                ),
                              );
                            },
                          )

                          // ListView(
                          //   children: snapshot.data!.docs
                          //       .map((DocumentSnapshot document) {
                          //     // AdminVoteAddModel data = document.data()! as AdminVoteAddModel;
                          //     Map<String, dynamic> data =
                          //         document.data()! as Map<String, dynamic>;
                          //     return Container(
                          //       decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(15)),
                          //       child: Column(
                          //         children: [
                          //           Text(data['voteName']),
                          //           Divider(
                          //             color: Colors.black,
                          //           ),
                          //           Text(data['totalVote'].toString())
                          //         ],
                          //       ),
                          //     );

                          //     // ListTile(
                          //     //   // title: Text(data.voteName.toString()),
                          //     //   // subtitle: Text(data.totalVote.toString()),
                          //     //   title: Text(data['voteName']),
                          //     //   subtitle: Text(data['voteId'].toString()),
                          //     //   leading: Text(data['totalVote'].toString()),
                          //     // );
                          //   }).toList(),
                          // )

                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Text(
                          //       "Vote Per Character",
                          //       style: TextStyle(
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ),
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //       children: [
                          //         Container(
                          //           margin: EdgeInsets.only(top: 10, right: 10),
                          //           decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.circular(30)),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Text(
                          //               "A",
                          //               style: TextStyle(
                          //                 fontSize: 20,
                          //                 fontWeight: FontWeight.w500,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         Container(
                          //           margin: EdgeInsets.only(top: 10, right: 10),
                          //           decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.circular(30)),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Text(
                          //               "B",
                          //               style: TextStyle(
                          //                 fontSize: 20,
                          //                 fontWeight: FontWeight.w500,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         Container(
                          //           margin: EdgeInsets.only(top: 10, right: 10),
                          //           decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.circular(30)),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Text(
                          //               "C",
                          //               style: TextStyle(
                          //                 fontSize: 20,
                          //                 fontWeight: FontWeight.w500,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         Container(
                          //           margin: EdgeInsets.only(top: 10, right: 10),
                          //           decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.circular(30)),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Text(
                          //               "D",
                          //               style: TextStyle(
                          //                 fontSize: 20,
                          //                 fontWeight: FontWeight.w500,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         Container(
                          //           margin: EdgeInsets.only(top: 10, right: 10),
                          //           decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.circular(30)),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Text(
                          //               "E",
                          //               style: TextStyle(
                          //                 fontSize: 20,
                          //                 fontWeight: FontWeight.w500,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //       children: [
                          //         Container(
                          //           margin: EdgeInsets.only(top: 10, right: 10),
                          //           decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.circular(30)),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Text(
                          //               "180",
                          //               style: TextStyle(
                          //                 fontSize: 20,
                          //                 fontWeight: FontWeight.w500,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         Container(
                          //           margin: EdgeInsets.only(top: 10, right: 10),
                          //           decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.circular(30)),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Text(
                          //               "76",
                          //               style: TextStyle(
                          //                 fontSize: 20,
                          //                 fontWeight: FontWeight.w500,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         Container(
                          //           margin: EdgeInsets.only(top: 10, right: 10),
                          //           decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.circular(30)),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Text(
                          //               "74",
                          //               style: TextStyle(
                          //                 fontSize: 20,
                          //                 fontWeight: FontWeight.w500,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         Container(
                          //           margin: EdgeInsets.only(top: 10, right: 10),
                          //           decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.circular(30)),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Text(
                          //               "90",
                          //               style: TextStyle(
                          //                 fontSize: 20,
                          //                 fontWeight: FontWeight.w500,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         Container(
                          //           margin: EdgeInsets.only(top: 10, right: 10),
                          //           decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.circular(30)),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Text(
                          //               "80",
                          //               style: TextStyle(
                          //                 fontSize: 20,
                          //                 fontWeight: FontWeight.w500,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),

                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }

  Widget topFiveCherecter(
    List<QueryDocumentSnapshot<Object?>> voteList,
  ) {
    voteList.sort((a, b) => int.parse(b['totalVote'].toString())
        .compareTo(int.parse(a['totalVote'].toString())));

    // Extract the top 5 names
    List top5Names = voteList.take(5).map((item) => item['voteName']).toList();
    return Container(
      margin: const EdgeInsets.only(top: 30, right: 10, left: 10),
      padding: const EdgeInsets.only(top: 15, left: 15),
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
          color: const Color.fromARGB(100, 3, 150, 204),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Top Five Character',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.only(top: 10, right: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int index = 0; index < top5Names.length; index++)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10), // Adjust the horizontal spacing
                    child: Text(
                      top5Names[index].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget characterPopularity(
    List<QueryDocumentSnapshot<Object?>> voteList,
  ) {
    print(voteList[0]['votingDate']);
    final morningVotes = voteList
        .where((character) => character["votingDate"].toDate().hour < 12)
        .toList();
    morningVotes.sort((a, b) => b['votingDate'].compareTo(a['votingDate']));

    String mVote =
        morningVotes.isNotEmpty ? morningVotes.first['voteName'] : "Not Added";

    // afternoonVotes
    // Filter for afternoon votes (e.g., votes from 12:00 PM to 6:00 PM)

    final afternoonVotes = voteList
        .where((character) =>
            character["votingDate"].toDate().hour >= 12 &&
            character["votingDate"].toDate().hour < 18)
        .toList();
    afternoonVotes.sort((a, b) => b['votingDate'].compareTo(a['votingDate']));

    String afterVote = afternoonVotes.isNotEmpty
        ? afternoonVotes.first['voteName']
        : "Not Added";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 80,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Morning',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 80,
                    height: 3,
                    color: Colors.amber,
                  ),
                ],
              ),
              Text('${mVote}'),
            ],
          ),
        ),
        Container(
          height: 80,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Afternoon',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 80,
                    height: 3,
                    color: Colors.amber,
                  ),
                ],
              ),
              Text('${afterVote}'),
            ],
          ),
        ),
      ],
    );
  }
}
