import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/riverpod/note_db.dart';
import 'package:riverpod/riverpod.dart';

class NoteListNotifier extends StateNotifier<List<Note>> {
  NoteListNotifier(this._databaseHelper) : super([]) {
    _databaseHelper.getAllNote().then((value) => state = value);
  }
  final DatabaseHelper _databaseHelper;
// add note 
  void addNote(Note note) async {
    state = [...state, note];
    await _databaseHelper.insert(note);
  }
}

final noteListNotifierProvider =
    StateNotifierProvider<NoteListNotifier, List<Note>>(
        (ref) => NoteListNotifier(ref.watch(databaseHelperProvider)));
