import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_book/Database/note_database.dart';
import 'package:note_book/Database/note_model.dart';
import 'package:note_book/Screens/edit_screen.dart';

class DetailsScreen extends StatefulWidget {
  final int noteId;

  const DetailsScreen({Key? key, required this.noteId}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Note note;
  bool isLoading = false;

  Future refreshNote() async {
    setState(() {
      isLoading == true;
    });
    note = await NoteDatabase.instance.readOnlyOnceNote(widget.noteId);
    setState(() {
      isLoading == false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [editButton(), deleteButton()],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.height,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Text(note.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            Text(
              DateFormat.yMMMd().format(note.time),
              style: const TextStyle(color: Colors.white38),
            ),
            Text(
              note.description,
              style: const TextStyle(color: Colors.white70, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget editButton() {
    return IconButton(
        onPressed: () async {
          if (isLoading) return;
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditScreen(note: note)));
          refreshNote();
        },
        icon: const Icon(Icons.edit));
  }

  Widget deleteButton() {
    return IconButton(
        onPressed: () async {
          await NoteDatabase.instance.deleteNote(widget.noteId);
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.delete_forever),
      color: Colors.red.shade800,
    );
  }
}
