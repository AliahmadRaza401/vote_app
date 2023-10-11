import 'package:alibhaiapp/utils/textwidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Widget singleElement(
  BuildContext context,
  String? imagevalue,
  String? text1,
  String? text2,
  String? text3,
  String? text4,
  String? text5,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Container(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
      ),
      child: Expanded(
        flex: 6,
        child: SizedBox(
          // height: 40.h,
          width: MediaQuery.sizeOf(context).width,
          child: Slidable(
              dragStartBehavior: DragStartBehavior.start,
              useTextDirection: false,
              closeOnScroll: false,
              key: UniqueKey(),
              endActionPane: ActionPane(
                extentRatio: 0.35,
                motion: const ScrollMotion(),
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () {
                        // dayTrackerProvider.deleteTODOItem(wholeindex);
                      },
                      child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.airplane_ticket_sharp,
                            color: Colors.white,
                            size: 20,
                          )),
                    ),
                  ),
                ],
              ),
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    // height: 40.h,
                    // padding: EdgeInsets.only(top: 15, bottom: 15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // color: Colors.pink,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            width: MediaQuery.sizeOf(context).width * 0.5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: Colors.black,
                                image: DecorationImage(
                                    image: AssetImage(imagevalue!))),
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: text(text: text1!, size: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: text(
                                    text: text2!, size: 15, color: Colors.grey),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    text(text: text3!, size: 15),
                                    const Text(' / ',
                                        style: TextStyle(color: Colors.black)),
                                    text(
                                        text: text4!,
                                        size: 15,
                                        color: Colors.grey),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: text(
                                  text: text5!,
                                  size: 15,
                                  color: text5 == 'Disponibile Adesso'
                                      ? Colors.blue
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          // Spacer()
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    ),
  );
}
