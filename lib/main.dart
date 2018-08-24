import 'package:dgsw_sns/model/member.dart';
import 'package:dgsw_sns/model/story.dart';
import 'package:dgsw_sns/story_list.dart';
import 'package:dgsw_sns/time_line.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'DGSW SNS',
      theme: new ThemeData(
        primaryColor: Color.fromARGB(0xFF, 0xFA, 0xFA, 0xFA),
        accentColor: Colors.white,
        buttonColor: Colors.white,
        backgroundColor: Colors.white,
        dividerColor: Color.fromARGB(0xFF, 0xEF, 0xEF, 0xEF),
        primaryIconTheme: IconThemeData(
          color: Colors.black
        ),
        textTheme: TextTheme(
          title: TextStyle(color: Colors.black),
          body1: TextStyle(color: Colors.black),
          body2: TextStyle(color: Colors.black),
          button: TextStyle(color: Colors.black)
        )
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  void _setSelectedIndex(int idx) {
    setState(() {
      selectedIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          title: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Instagram_logo.svg/1200px-Instagram_logo.svg.png", width: 90.0,),
          elevation: 1.0,

        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            StoryList(),
            Expanded(
              child: TimeLine()
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _setSelectedIndex,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.home, color: Theme.of(context).iconTheme.color,),
              title: Text('Home', style: Theme.of(context).textTheme.button,),
          ),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color,),
              title: Text('Search', style: Theme.of(context).textTheme.button,)
          ),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
              title: Text('Add', style: Theme.of(context).textTheme.button,)
          ),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.favorite_border, color: Theme.of(context).iconTheme.color,),
              activeIcon: Icon(Icons.favorite, color: Theme.of(context).iconTheme.color),
              title: Text('Favorite', style: Theme.of(context).textTheme.button,)
          ),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.person_outline, color: Theme.of(context).iconTheme.color,),
              activeIcon: Icon(Icons.person, color: Theme.of(context).iconTheme.color),
              title: Text('Profile', style: Theme.of(context).textTheme.button,)
          ),
        ],
      ),
    );
  }
}