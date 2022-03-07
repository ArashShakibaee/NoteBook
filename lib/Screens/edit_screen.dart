import 'package:flutter/material.dart';
import 'package:note_book/CustomWidget/form_fields.dart';
import 'package:note_book/Database/note_database.dart';
import 'package:note_book/Database/note_model.dart';
import 'package:note_book/constants.dart';

class EditScreen extends StatefulWidget {
  final Note? note;

  const EditScreen({Key? key, this.note}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [saveButton()],
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FormTextFields(
                title: title,
                isImportant: isImportant,
                description: description,
                number: number,
                onChangedIsImportant: (isImportant) => setState(() {
                      this.isImportant = isImportant;
                    }),
                onChangedNumber: (number) => setState(() {
                      this.number = number;
                    }),
                onChangedTitle: (title) => setState(() {
                      this.title = title;
                    }),
                onChangedDescription: (description) => setState(() {
                      this.description = description;
                    })),
          )),
    );
  }

  Widget saveButton() {
    final isValid = title.isNotEmpty && description.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: ElevatedButton(
        onPressed: updateOrEdit,
        child: const Text('Save'),
        style: ElevatedButton.styleFrom(
            primary: isValid ? Colors.grey.shade800 : kCustomTeal),
      ),
    );
  }

  void updateOrEdit() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final isUpdating = widget.note != null;
      isUpdating ? await update() : await add();
      Navigator.of(context).pop();
    }
  }

  Future update() async {
    final note = widget.note!.copy(
      number: number,
      isImportant: isImportant,
      title: title,
      description: description,
    );
    await NoteDatabase.instance.updateNote(note);
  }

  Future add() async {
    final note = Note(
        number: number,
        isImportant: isImportant,
        title: title,
        time: DateTime.now(),
        description: description);
    await NoteDatabase.instance.createNote(note);
  }

}
