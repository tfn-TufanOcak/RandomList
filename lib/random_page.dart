import 'package:flutter/material.dart';
import 'package:dart_random_choice/dart_random_choice.dart';

import 'Meal.dart';

// ignore: must_be_immutable
class Random extends StatefulWidget {
  var list;
  Random({this.list});
  @override
  State<StatefulWidget> createState() {
    return RandomState(list: list);
  }
}

class RandomState extends State {
  var list;
  RandomState({this.list});
  Meal selected = new Meal(recipe: "", mealName: "");
  spaceScreen(){
    if(list.length==0){
      return Text("Liste Ekle", style:
      TextStyle(fontSize: 30, color: Colors.white),);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text("Rastgele Seç!"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[700],
                    ),
                    height: 270,
                    width: 270,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 54),
                      child: Center(
                        child: Column(
                          children: [ Text(
                            selected == null ? '': selected.mealName,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 35, color: Colors.white),
                          ),
                            SizedBox(height: 36,),
                            Text(
                              selected == null ? '': selected.recipe,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 35, color: Colors.white),
                            ),

                          ]

                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: FloatingActionButton(
                      tooltip: 'Zarla',
                      child: Icon(
                        Icons.auto_awesome,
                        size: 60,
                      ),
                      backgroundColor: Colors.grey[600],
                      onPressed: () {
                        setState(() {

                          selected = randomChoice<Meal>(list);
                        });

                      },
                    ),
                  ),
                  Container(
                    height: 50,
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 260),
            child: Center(
              child: spaceScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
