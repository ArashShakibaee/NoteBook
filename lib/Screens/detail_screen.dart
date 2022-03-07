import 'package:flutter/material.dart';
import 'package:note_book/Database/note_model.dart';

class DetailsScreen extends StatefulWidget {
  final int noteId;
  const DetailsScreen({Key? key , required this.noteId}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
