import 'package:flutter/material.dart';
import 'package:random_list/random_page.dart';
import 'add_list.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RandomList',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        scaffoldBackgroundColor: Colors.grey[500],
      ),
      home: MyHomePage(title: 'RandomList'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selected;
  var liste = [];
  spaceScreen(){
    if(liste.length==0){
      return Text("Liste Ekle", style:
      TextStyle(fontSize: 30, color: Colors.white),);
    }
  }
  onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: Center(
              child: spaceScreen(),
            ),
          ),
          Center(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: liste.length,
                      itemBuilder: (
                        BuildContext contex,
                        int index,
                      ) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            tileColor: Colors.grey[700],
                            selectedTileColor: Colors.grey[850],
                            selected: index == selected,
                            onTap: () {
                              setState(() {
                                selected = index;
                              });
                            },
                            title: Text(
                              liste[index],
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    color: Colors.grey[850],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: FloatingActionButton(
                            heroTag: null,
                            tooltip: 'Yeni Ekle',
                            child: Icon(Icons.add),
                            backgroundColor: Colors.grey[600],
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddList(list: liste))).then(onGoBack);
                            },
                          ),
                        ),
                        FloatingActionButton(
                          heroTag: null,
                          tooltip: 'Zarla',
                          child: Icon(Icons.auto_awesome),
                          backgroundColor: Colors.grey[600],
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Random(list: liste))).then(onGoBack);
                          },
                        ),
                        FloatingActionButton(
                          heroTag: null,
                          tooltip: 'Sil',
                          child: Icon(Icons.delete),
                          backgroundColor: Colors.grey[600],
                          onPressed: () {
                            setState(() {
                              liste.removeAt(selected);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
