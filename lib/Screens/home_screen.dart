import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:note_book/CustomWidget/base_container.dart';
import 'package:note_book/Database/note_database.dart';
import 'package:note_book/Database/note_model.dart';
import 'package:note_book/Screens/detail_screen.dart';
import '../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  late List<Note> notes;

  Future refreshNotes() async {
    setState(() {
      isLoading == true;
    });
    notes = await NoteDatabase.instance.readAllNotes();
    setState(() {
      isLoading == false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    super.dispose();
    NoteDatabase.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: kAppbarTextStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 25,
              ))
        ],
      ),
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: kCustomAmber,
                  secondRingColor: kCustomGreen,
                  thirdRingColor: kCustomRed,
                  size: 25),
            )
          : notes.isEmpty
              ? const Center(
                  child: Text(
                    'NoteBook is Empty',
                    textAlign: TextAlign.center,
                    style: kEmptyNoteBookError,
                  ),
                )
              : buildNotes(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          refreshNotes();
        },
        backgroundColor: kCustomTeal,
        elevation: 8,
        splashColor: Colors.black54,
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildNotes() {
    return StaggeredGridView.countBuilder(
        itemCount: notes.length,
        crossAxisCount: 4,
        crossAxisSpacing: 4,
        mainAxisSpacing: 8,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        itemBuilder: (context, index) {
          final note = notes[index];
          return GestureDetector(
            onTap: ()async{
              await Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen(noteId: note.id!,)));
              refreshNotes();
              },
            child: BaseContainer(index: index, note: note),
          );
        });
  }
}
