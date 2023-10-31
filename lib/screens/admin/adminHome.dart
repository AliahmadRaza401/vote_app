import 'dart:developer';

import 'package:alibhaiapp/screens/admin/adminUpdatePassword.dart';
import 'package:alibhaiapp/screens/admin/line_chart.dart';
import 'package:alibhaiapp/models/adminVoteAddModel.dart';
import 'package:alibhaiapp/services/shearedpref_service.dart';
import 'package:alibhaiapp/screens/Authentication/login.dart';
import 'package:alibhaiapp/utils/images.dart';
import 'package:alibhaiapp/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';

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
                      header(),
                      totalVote(totalScore),
                      topFiveCherecter(snapshot.data!.docs),
                      charcPopularity(snapshot.data!.docs),
                      VoteChart(
                        docs: snapshot.data!.docs,
                      ),
                      allVoteList(snapshot.data!.docs),
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

  Widget header() {
    return Container(
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
                AppRoutes.push(
                    context,
                    PageTransitionType.fade,
                    // const Login(),
                    AdminPasswordChangeScreen());
              },
              icon: const Icon(Icons.settings))

        ],
      ),
    );
  }

  Widget totalVote(totalScore) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.1,
      margin: const EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total Votes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
    );
  }

  Widget charcPopularity(docs) {
    return Container(
      width: MediaQuery.of(context).size.width,

      padding: EdgeInsets.symmetric(
          vertical: 20), // height: MediaQuery.of(context).size.height * 0.2,
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
          findcharacterPopularity(docs),
        ],
      ),
    );
  }

  Widget topFiveCherecter(
    List<QueryDocumentSnapshot<Object?>> voteList,
  ) {
    voteList.sort((a, b) => int.parse(b['totalVote'].toString())
        .compareTo(int.parse(a['totalVote'].toString())));

    // Extract the top 5 names
    List top5Names = voteList.take(5).map((item) => item['voteName']).toList();
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        bottom: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
          color: const Color.fromARGB(100, 3, 150, 204),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text(
            'Top Five Character',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
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

  Widget findcharacterPopularity(
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
          width: 130,
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
          width: 130,
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

  Widget allVoteList(docs) {
    return Column(
      children: [
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
              vertical: 15,
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            // height: MediaQuery.of(context).size.height * 0.2,
            // height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(168, 173, 200, 100),
            ),
            child: GridView.builder(
              itemCount: docs.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0),
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  // width: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.5),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              )),
                          child: Text(
                            docs[index]['voteName'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            docs[index]['totalVote'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            )),

        //  ListView.builder(
        //   itemCount: docs.length,
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemBuilder: (context, index) {
        //     return Container(
        //       margin:
        //           const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        //       padding: const EdgeInsets.symmetric(vertical: 5),
        //       width: 30,
        //       decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.circular(15)),
        //       child: Column(
        //         children: [
        //           Text(
        //             docs[index]['voteName'],
        //             style: TextStyle(fontWeight: FontWeight.bold),
        //           ),
        //           const Divider(
        //             color: Colors.amber,
        //             thickness: 2,
        //           ),
        //           Text(
        //             docs[index]['totalVote'].toString(),
        //           )
        //         ],
        //       ),
        //     );
        //   },
        // )),
      ],
    );
  }
}
