import 'package:alibhaiapp/models/adminVoteAddModel.dart';
import 'package:alibhaiapp/utils/images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('vote').snapshots();
  var totalScore = 0;
  @override
  Widget build(BuildContext context) {
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
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                color: Color.fromARGB(255, 213, 219, 222),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 40, right: 100),
                      child: Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
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
                                vertical: 8, horizontal: 10),
                            height: 50,
                            // width: 70,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(53, 55, 15, 8),
                                borderRadius: BorderRadius.circular(20)),
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
                    Container(
                      margin: EdgeInsets.only(top: 30, right: 10, left: 10),
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(180, 100, 200, 200),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Character Popularity",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 40,
                                width: 100,
                                margin: EdgeInsets.only(top: 10, right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Morning",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 110,
                                margin: EdgeInsets.only(top: 10, right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Afternoon",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //  All vote
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
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Text(snapshot.data!.docs[index]['voteName']),
                                  const Divider(color: Colors.black),
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
        );
      },
    ));
  }

  Widget topFiveCherecter(
    List<QueryDocumentSnapshot<Object?>> voteList,
  ) {
    voteList.sort((a, b) => b['totalVote'].compareTo(a['totalVote']));

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
                      style: TextStyle(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
