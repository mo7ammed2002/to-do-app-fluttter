// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:todoapp/db.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SqlDb sqldb = SqlDb();
  bool islooding = true;
  List note = [];
  Future readData() async {
    List<Map> response = await sqldb.readData('SELECT * FROM notes');
    note.addAll(response);
    islooding = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("add_note");
        },
      ),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        child: ListView(
          children: [
            // MaterialButton(
            //   onPressed: () async {
            //     await sqldb.mydeleteDb();
            //   },
            //   child: Text("delet Data"),
            // ),
            ListView.builder(
                itemCount: note.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Card(
                      child: ListTile(
                    title: Text("${note[i]['title']}"),
                    subtitle: Text("${note[i]['note']}"),
                    trailing: MaterialButton(
                        onPressed: () async {
                          int response = await sqldb.deleteData(
                              "DELETE FROM notes WHERE id =${note[i]['id']} ");
                          if (response > 0) {
                            note.removeWhere(
                                (element) => element['id'] == note[i]['id']);
                            setState(() {});
                          }
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red[800],
                        )),
                  ));
                }),
          ],
        ),
      ),
    );
  }
}
