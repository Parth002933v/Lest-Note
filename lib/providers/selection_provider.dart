import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets_note/model/chat_model.dart';

class SelectionNotifier extends StateNotifier<List<NoteModel>> {
  SelectionNotifier() : super([]);

  bool select(NoteModel note) {
    print('call 1');

    // if provider has data

    if (state.contains(note)) {
      // If it is favourite it will remove
      state = state.where((stateNote) => stateNote != note).toList();

      print('removed');
      return state.isNotEmpty; // not exist
    } else {
      // if is is not favourite it will add it
      state = [...state, note];
      print("added");
      print(state);
      return state.isNotEmpty; // exist
    }

    // if provider is empty
  }

  bool clearTheState() {
    state.clear();

    return false;
  }
}

final selectionProvider =
    StateNotifierProvider<SelectionNotifier, List<NoteModel>>(
        (ref) => SelectionNotifier());

///--------------------------------------------------------------------------///
