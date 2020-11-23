import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_list/globals.dart';
import 'package:random_list/login.dart';
import 'package:random_list/random_page.dart';
import 'Meal.dart';
import 'add_list.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  List<Meal> liste;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void initState() {
    if (_auth.currentUser == null) {
      // user not logged ==> Login Screen
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
      });
    }
    super.initState();

  }
  spaceScreen(){
    if(liste==null || liste.isEmpty){
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
        actions: [

          FlatButton.icon(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 27,
              ),
              label: Text(""),
              onPressed:  () async {
                await _auth.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              })
        ],
        backgroundColor: Colors.grey[850],
        title: Text(widget.title),
        centerTitle: true,
      ),
      body:  StreamBuilder<List<Meal>>(
        stream: Global.mealRef.mealStream,
        builder: (context, snapshot) {
         liste = snapshot.data;
          return Stack(
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
                          itemCount:liste!=null? liste.length : 0,
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
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (BuildContext context) => CupertinoActionSheet(
                                        title: const Text('recipe'),
                                          actions: <Widget>[
                                          CupertinoActionSheetAction(
                                            child: Text(liste[selected].recipe),
                                            onPressed: () {
                                              Navigator.pop(null);
                                            },
                                          )

                                        ],
                                      ),
                                    );

                                  });
                                },
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                  children: [
                                    Text(
                                      liste[index].mealName,
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(fontSize: 30, color: Colors.white),
                                    ),
                                    FlatButton.icon(
                                        label: Text(liste[index].vote!=null ? liste[index].vote.toString():  ''),
                                        icon: liste[index].vote==null || liste[index].vote==0 ? iconLike(): iconDislike(),
                                        onPressed: () {
                                          int control=liste[index].vote;
                                          if(control==null || control==0){
                                            Global.mealRef.like(liste[index].mealName);
                                          }else if (control>0){
                                            Global.mealRef.dislike(liste[index].mealName);
                                          }

                                        })
                                  ],
                                ),
                                leading: ikon(liste[index].vote),
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
                                              AddList(onChanged: onChanged))).then(onGoBack);
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
                                   onChanged(liste[selected].mealName, false);
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
          );
        }
      ),
    );
  }
  onChanged(String mealName, bool isAdd) async {
    Meal meal = new Meal(mealName: mealName);
    if(isAdd){
      Global.mealRef.updateMealDataWithMap(meal.toMap());
    }else{
      Global.mealRef.delete(mealName);
    }
   }
   Icon ikon(int vote){
    if(vote!= null && vote > 0){
      return Icon(Icons.check,size: 30,color:Colors.green,);
    }
    else{
      return Icon(Icons.delete,size:30,color: Colors.red,);
    }
   }
   Icon iconLike(){
    return Icon(CupertinoIcons.hand_thumbsup,color: Colors.green,);
   }
   Icon iconDislike(){
    return Icon(CupertinoIcons.hand_thumbsup_fill,color:Colors.green,);
   }
}
