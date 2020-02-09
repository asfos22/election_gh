import 'dart:math';

import 'package:flutter/material.dart';

class VotingPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<VotingPage> {
  //Todo: import images
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage lucky = AssetImage("images/rupee.png");
  AssetImage unlucky = AssetImage("images/sadFace.png");

  //Todo: array for buttons
  List<String> itemArray;
  int luckyNumber, counter = 0;
  String message = "";

  //initialize array with 25 elements
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemArray = List<String>.generate(3, (index) {
      return "empty";
    });
    generateRandomNumber();
  }

  generateRandomNumber() {
    int random = Random().nextInt(25);
    //print(random);
    setState(() {
      luckyNumber = random;
    });
  }

  //Todo: define getImage method
  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case 'lucky':
        return lucky;
        break;
      case 'unlucky':
        return unlucky;
        break;
    }
    return circle;
  }

  //Todo: play game method

  playGame(int index) {
    if (counter == 5) {
      setState(() {
        message = "You Losse try again!!";
        resetGame();
      });
    } else if (luckyNumber == index) {
      setState(() {
        itemArray[index] = 'lucky';
        message = "You Win";
        showAll();
      });
    } else {
      setState(() {
        itemArray[index] = 'unlucky';
        message = "";
        counter++;
      });
    }
  }

  //Todo: showall
  showAll() {
    setState(() {
      itemArray = List<String>.filled(2, 'unlucky');
      itemArray[luckyNumber] = 'lucky';
    });
  }

  //Todo: Reset all

  resetGame() {
    setState(() {
      itemArray = List<String>.filled(2, "empty");
      counter = 0;
    });
    generateRandomNumber();
  }

  //Todo: win logic
  winGame() {
    if (counter == 5) {
      setState(() {
        this.message = "You lose";
        resetGame();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tap and win'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: itemArray.length,
              itemBuilder: (context, i) {
                return SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      this.playGame(i);
                    },
                    child: Image(
                      image: this.getImage(i),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.0),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                this.showAll();
                this.message = "";
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color: Colors.pink,
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Show All',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                this.resetGame();
                this.message = "";
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color: Colors.pink,
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Reset',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Container(
            child: MaterialButton(
              onPressed: () {},
              color: Colors.black,
              textColor: Colors.white,
              child: Text(
                'Developed by Nilotpal kr Ghosh',
              ),
            ),
          )
        ],
      ),
    );
  }
}
