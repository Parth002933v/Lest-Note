import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets_note/model/chat_model.dart';

class SelectionNotifier extends StateNotifier<List<NoteModel>> {
  SelectionNotifier(super.state);

  bool select(NoteModel note) {
    // if provider has data
    if (state.contains(note)) {
      // If it is favourite it will remove
      state =
          state.where((stateNote) => stateNote.noteID != note.noteID).toList();

      return state.isNotEmpty; // not exist
    } else {
      // if is is not favourite it will add it
      state = [...state, note];

      return state.isNotEmpty; // exist
    }
  }

  bool clearTheState() {
    state.clear();
    return false;
  }
}

StateNotifierProvider<SelectionNotifier, List<NoteModel>> selectionProvider =
    StateNotifierProvider<SelectionNotifier, List<NoteModel>>(
        (ref) => SelectionNotifier([]));

///--------------------------------------------------------------------------///
