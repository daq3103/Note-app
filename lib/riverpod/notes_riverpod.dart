import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/riverpod/note_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteListNotifier extends StateNotifier<List<Note>> {
  NoteListNotifier(this._databaseHelper) : super([]) {
    _databaseHelper.getAllNote().then((value) => state = value);
  }
  getLstNote() {
    _databaseHelper.getAllNote().then((value) => state = value);
  }

  final DatabaseHelper _databaseHelper;
// add note
  void addNote(Note note) async {
    state = [...state, note];
    await _databaseHelper.insert(note);
  }

// select note
  selectNote(Note note) {
    return state.firstWhere((e) => e.idNote == note.idNote);
  }

// update note
  void updateNote(Note note) async {
    state = state.map((e) => e.idNote == note.idNote ? note : e).toList();
    await _databaseHelper.update(note);
  }

// remove note
  void remove(Note note) async {
    state = state.where((element) => element.idNote != note.idNote).toList();
    await _databaseHelper.remove(note);
  }
}

final noteListNotifierProvider =
    StateNotifierProvider<NoteListNotifier, List<Note>>(
        (ref) => NoteListNotifier(ref.watch(databaseHelperProvider)));
