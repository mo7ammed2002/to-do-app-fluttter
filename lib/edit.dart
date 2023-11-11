import 'package:flutter/material.dart';
import 'package:todoapp/db.dart';
import 'package:todoapp/home.dart';

class editNote extends StatefulWidget {
  final note;
  final Title;
  final id;
  final color;
  const editNote({super.key, this.note, this.Title, this.id, this.color});

  @override
  State<editNote> createState() => _editNoteState();
}

class _editNoteState extends State<editNote> {
  SqlDb sqldb = SqlDb();
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  initState() async {
    note.text = await widget.note;
    title.text = await widget.Title;
    color.text = await widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('edit Note'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // const TextField(
                  //   decoration: InputDecoration(
                  //     hintText: 'Enter Note',
                  //   ),
                  // ),
                  TextFormField(
                    controller: note,
                    decoration: const InputDecoration(
                      hintText: 'Enter Note',
                      label: Text('Note'),
                    ),
                  ),
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(
                      hintText: 'Enter Title',
                      label: Text('Title'),
                    ),
                  ),
                  TextFormField(
                    controller: color,
                    decoration: const InputDecoration(
                      hintText: 'Enter Color',
                      label: Text('Color'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () async {
                      // ignore: unused_local_variable
                      var response = sqldb.updateData('''
                     UBDATE notes SET 
                        note ="${note.text}",
                        title ="${title.text},
                       color ="${color.text}"
                        WHRE id =${widget.id}
                      ''');
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Home()),
                            (route) => false);
                      }
                    },
                    child: const Text('edite notes'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
