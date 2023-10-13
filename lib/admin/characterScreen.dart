import 'dart:developer';

import 'package:alibhaiapp/admin/admin_service.dart';
import 'package:alibhaiapp/models/adminVoteAddModel.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AdminCharacterScreen extends StatefulWidget {
  const AdminCharacterScreen({super.key});

  @override
  State<AdminCharacterScreen> createState() => _AdminCharacterScreenState();
}

class _AdminCharacterScreenState extends State<AdminCharacterScreen> {
  TextEditingController voteName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            width: 325,
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'SF-Regular',
              ),
              // validator: validator,
              controller: voteName,
              onChanged: (value) {
                setState(() {
                  voteName.text = value;
                });
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.grey,
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 13,
                  horizontal: 12,
                ),
                hintText: 'Enter Character',
                hintStyle: TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                  fontFamily: 'SF-Regular',
                ),
              ),
              maxLines: 5,
            ),
          ),
          voteName.text.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                      onPressed: () async {
                        var uuid = const Uuid();
                        var voteId = uuid.v4();
                        log('voteId= $voteId');
                        await VoteServices().addVote(
                          voteId,
                          voteName.text,
                          context,
                        );
                        voteName.clear();
                      },
                      child: const Text('Add Character')),
                )
        ],
      ),
    ));
  }
}
