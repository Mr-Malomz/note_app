import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/utils/setup.dart';

class NoteService {
  Client client = Client();
  Account? account;
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

  Future<List<Note>?> getAllNotes() async {
    try {
      var resp =
          await db?.listDocuments(collectionId: AppConstant().collectionId);
      var noteList =
          resp?.documents.map((note) => Note.fromJson(note.data)).toList();
      print(noteList);
      return noteList;
    } catch (e) {
      throw Exception('Error getting list notes');
    }
  }

  Future createNote(String title, String note) async {
    try {
      var data = await db?.createDocument(
          collectionId: AppConstant().collectionId,
          documentId: 'unique()',
          data: {
            'title': title,
            'note': note,
          });
      return data;
    } catch (e) {
      throw Exception('Error creating note');
    }
  }

  
}
