import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddList extends StatefulWidget {
  List<String> list;
  Function onChanged;
  AddList({this.list, this.onChanged });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddListState(list: list, onChanged: onChanged);
  }
}

class AddListState extends State {
  List<String> list;
  Function onChanged;

  AddListState({this.list, this.onChanged});
  String newList;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text("Liste Ekle"),
        centerTitle: true,
      ),
      body: Center(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: TextFormField(
                  style: TextStyle(fontSize: 30, color: Colors.white),
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  onSaved: (String value) {
                    newList = value;
                  },
                  decoration: const InputDecoration(
                    hintText: "Yeni Ekle",
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              tooltip: 'Ekle',
              child: Icon(Icons.add),
              backgroundColor: Colors.grey[600],
              onPressed: () {
                formKey.currentState.save();
                print(newList);
                setState(() {
                  list.add(newList);
                  this.onChanged(list);

                });
                print(list);
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => AddList()));
              },
            ),
            Container(
              height: 50,
            ),
            Container(
              height: 50,
            ),
          ],
        ),
      )),
    );
  }
}
