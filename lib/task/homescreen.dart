import 'package:alibhaiapp/slideablewidget.dart';
import 'package:alibhaiapp/utils/images.dart';
import 'package:flutter/material.dart';

class HomeScreenTask extends StatefulWidget {
  const HomeScreenTask({super.key});

  @override
  State<HomeScreenTask> createState() => _HomeScreenTaskState();
}

class _HomeScreenTaskState extends State<HomeScreenTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: imageLiust.length,
        itemBuilder: (context, i) {
          return singleElement(
            context,
            imageLiust[i],
            'Red Komodo 6K',
            'Milano, Lombardia, Italia',
            '250€',
            'giorno',
            'Disponibile Adesso',
          );
        },
      ),
    );
  }
}
