import 'package:hive_flutter/hive_flutter.dart';

import '../constant/hive_const.dart';

class HiveHelperOfNotes {
  static List<String> listOfnotes = [];
  static void addNotes(String text) async {
    listOfnotes.add(text);
    var box = Hive.box(notesBox);
    await box.put(notesBox, listOfnotes);
  }

  static void removeNotes(int index) async {
    listOfnotes.removeAt(index);
    var box = Hive.box(notesBox);
    await box.put(notesBox, listOfnotes);
  }

  static void getNotes(void Function() refresh) async {
    Future.delayed(Duration.zero).then((value) {
      listOfnotes = Hive.box(notesBox).get(notesBox);
      refresh();
    });
  }

  static void updateNotes(
      int index, String title, void Function() refresh) async {
    listOfnotes[index] = title;
    listOfnotes = Hive.box(notesBox).get(notesBox);
    refresh();
  }

  static void deleteAllData() async {
    listOfnotes.clear();
    var box = Hive.box(notesBox);
    await box.put(notesBox, listOfnotes);
  }
}
