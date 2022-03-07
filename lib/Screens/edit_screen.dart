import 'package:flutter/material.dart';
import 'package:note_book/Database/note_model.dart';
class EditScreen extends StatefulWidget {
  final Note note;
  const EditScreen({Key? key,required this.note}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
