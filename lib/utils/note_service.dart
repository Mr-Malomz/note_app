import 'package:appwrite/appwrite.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/utils/setup.dart';

class NoteService {
  Client client = Client();
  Database? db;

  NoteService() {
    _init();
  }

  //initialize the application
  _init() async {
    client
        .setEndpoint(AppConstant().endpoint)
        .setProject(AppConstant().projectId);

    db = Database(client);
  }

  Future<List<Note>> getAllNotes() async {
    try {
      var data =
          await db?.listDocuments(collectionId: AppConstant().collectionId);
      var noteList =
          data?.documents.map((note) => Note.fromJson(note.data)).toList();
      return noteList!;
    } catch (e) {
      throw Exception('Error getting list notes');
    }
  }

  Future createNote(String title, String note) async {
    try {
      Note newNote = Note(note: note, title: title);
      var data = await db?.createDocument(
        collectionId: AppConstant().collectionId,
        documentId: 'unique()',
        data: newNote.toJson(),
      );
      return data;
    } catch (e) {
      throw Exception('Error creating note');
    }
  }

  Future<Note> getANote(String id) async {
    try {
      var data = await db?.getDocument(
          collectionId: AppConstant().collectionId, documentId: id);
      var note = data?.convertTo((doc) => Note.fromJson(doc));
      return note!;
    } catch (e) {
      throw Exception('Error getting note');
    }
  }

  Future updateNote(String title, String note, String id) async {
    try {
      Note updateNote = Note(note: note, title: title);
      var data = await db?.updateDocument(
        collectionId: AppConstant().collectionId,
        documentId: id,
        data: updateNote.toJson(),
      );
      return data;
    } catch (e) {
      throw Exception('Error creating note');
    }
  }

  Future deleteNote(String id) async {
    try {
      var data = await db?.deleteDocument(
          collectionId: AppConstant().collectionId, documentId: id);
      return data;
    } catch (e) {
      throw Exception('Error getting note');
    }
  }
}
