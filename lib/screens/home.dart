import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/screens/manage_note.dart';
import 'package:note_app/utils/color.dart';
import 'package:note_app/utils/note_service.dart';
import 'package:note_app/widgets/card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note>? notes;
  bool _isLoading = false;
  bool _isError = false;

  @override
  void initState() {
    _getNoteList();
    super.initState();
  }

  _getNoteList() {
    setState(() {
      _isLoading = true;
    });
    NoteService().getAllNotes().then((value) {
      setState(() {
        notes = value;
        _isLoading = false;
      });
    }).catchError((_) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: AppColor.primary,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColor.primary,
            ))
          : _isError
              ? const Center(
                  child: Text(
                    'Error loading notes',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: notes?.length,
                  itemBuilder: (context, index) {
                    return NoteCard(note: notes![index]);
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ManageNote(
                title: 'Create Note',
                isEdit: false,
              ),
            ),
          );
        },
        backgroundColor: AppColor.primary,
        tooltip: 'Create Note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
