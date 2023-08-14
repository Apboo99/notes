import 'package:flutter/material.dart';
import 'package:foodest/const.dart';
import 'package:foodest/notes/hive_help/hive_helper.dart';
import 'package:flutter/cupertino.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _Notes_screenState();
}

IconData _light_mode = Icons.wb_sunny;
IconData _dark_mode = Icons.nights_stay;
bool _mode = true;
ThemeData _lightMode =
    ThemeData(primarySwatch: Colors.amber, brightness: Brightness.light);

ThemeData _darkMode =
    ThemeData(primarySwatch: Colors.red, brightness: Brightness.dark);

class _Notes_screenState extends State<NotesScreen> {
  @override
  void initState() {
    HiveHelperOfNotes.getNotes(_refresh);
    super.initState();
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final _textFieldController = TextEditingController();
    final _textFieldControllerUpdate = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: const Text(
                    ' هل تريد حذف جميع ملاحظاتك ؟',
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      child: const Text(
                        'لا',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    MaterialButton(
                      child: const Text(
                        'نعم',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        HiveHelperOfNotes.deleteAllData();
                        _refresh();

                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(
            CupertinoIcons.delete,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: width * .23),
          child: texting(
              text: "Notes",
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _mode == true ? _lightMode : _dark_mode;
              setState(() {
                _mode = !_mode;
              });
            },
            icon: Icon(_mode ? _dark_mode : _light_mode),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: const Text(
                    'أدخل ملاحظاتك هنا ',
                    style: TextStyle(fontSize: 25),
                  ),
                  content: TextField(
                    controller: _textFieldController,
                    decoration:
                        const InputDecoration(hintText: "أكتب هنا من فضلك"),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      child: const Text(
                        'إلغاء',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    MaterialButton(
                      child: const Text(
                        'حفظ',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        if (_textFieldController.text.isNotEmpty) {
                          HiveHelperOfNotes.addNotes(_textFieldController.text);
                          _refresh();
                        }

                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(
            Icons.add,
            size: 30,
          )),
      body: HiveHelperOfNotes.listOfnotes.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: width * .26),
                  child: texting(
                      text: "ملاحظاتك فارغة",
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          : ListView.builder(
              itemCount: HiveHelperOfNotes.listOfnotes.length,
              itemBuilder: (context, index) => Center(
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      width: width * .90,
                      height: height * .12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: index % 2 == 1 ? Colors.pink : Colors.blue),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              height: width * .10,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  color: Colors.white60),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: InkWell(
                                      onTap: () {
                                        HiveHelperOfNotes.removeNotes(index);
                                        _refresh();
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        size: 32,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: InkWell(
                                      onTap: () {
                                        _textFieldControllerUpdate.text =
                                            HiveHelperOfNotes
                                                .listOfnotes[index];
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                'تعديل الملاحظه',
                                                style: TextStyle(fontSize: 25),
                                              ),
                                              content: TextField(
                                                controller:
                                                    _textFieldControllerUpdate,
                                              ),
                                              actions: <Widget>[
                                                MaterialButton(
                                                  child: const Text('إلغاء'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                MaterialButton(
                                                  child: const Text('حفظ'),
                                                  onPressed: () {
                                                    if (_textFieldControllerUpdate
                                                        .text.isNotEmpty) {
                                                      HiveHelperOfNotes.updateNotes(
                                                          index,
                                                          _textFieldControllerUpdate
                                                              .text,
                                                          _refresh);
                                                    }

                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        CupertinoIcons.pencil,
                                        size: 35,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                HiveHelperOfNotes.listOfnotes[index],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
