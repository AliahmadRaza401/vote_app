import 'package:alibhaiapp/slideablewidget.dart';
import 'package:alibhaiapp/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: imageLiust.length,
                    itemBuilder: (context, i) {
                      

                      return singleElement(
              context,
              imageLiust[i],
              'Red Komodo 6K',
              'Milano, Lombardia, Italia',
              '250€',
              'giorno',
              'Disponibile Adesso');
              //          Slidable(
              //                 key: UniqueKey(),
              //                 endActionPane: ActionPane(
              //                   extentRatio: 0.2,
              //                   motion: const ScrollMotion(),
              //                   children: [
              //                     Padding(
              //                       padding:
              //                           EdgeInsets.only(top: 15, left: 15),
              //                       child: InkWell(
              //                         onTap: () {
              //                           principalQuotes.deleteTODOItem(todoCat);
              //                           toast(
              //                               context: context,
              //                               msg: "Quote deleted successfully");
              //                           Provider.of<PrincipalQuotesProvider>(
              //                                   context,
              //                                   listen: false)
              //                               .getTODOItem();
              //                         },
              //                         child: Container(
              //                             height: ismobile! ? 40.h : 60.h,
              //                             width: ismobile! ? 40.h : 60.h,
              //                             decoration: BoxDecoration(
              //                               color: Colors.red,
              //                               borderRadius:
              //                                   BorderRadius.circular(10.r),
              //                             ),
              //                             child: Icon(
              //                               Icons.delete,
              //                               size: ismobile! ? null : 25.r,
              //                               color: Colors.white,
              //                             )),
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //                 child:  
              //                 singleElement(
              // context,
              // 'assets/pic/1.png',
              // 'Red Komodo 6K',
              // 'Milano, Lombardia, Italia',
              // '250€',
              // 'giorno',
              // 'Disponibile Adesso')
              //               );
         
          // singleElement(context),
          // singleElement(context),
          // singleElement(context),
          // singleElement(context),
          // singleElement(context),
  })],
      ),
    );
  }
}
