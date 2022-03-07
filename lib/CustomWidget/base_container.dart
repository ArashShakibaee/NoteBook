import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_book/Database/note_model.dart';
import 'package:note_book/constants.dart';

final _pickColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.red.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pink.shade100,
  Colors.tealAccent.shade200,
];

class BaseContainer extends StatelessWidget {
  final Note note;
  final int index;

  const BaseContainer({Key? key, required this.index, required this.note})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = _pickColors[index % _pickColors.length];
    final time = DateFormat.yMMMd().format(note.time);

    return Card(
      color: color,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: kTextTimeStyle,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              note.title,
              style: kTitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
