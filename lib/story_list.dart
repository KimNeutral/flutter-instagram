import 'package:flutter/material.dart';
import 'package:dgsw_sns/model/story.dart';

class StoryItem extends StatelessWidget {

  final Story story;

  final List<Color> _notRead = [
    Color.fromARGB(0xFF, 0xFC, 0xA5, 0x49),
    Color.fromARGB(0xFF, 0xBF, 0x08, 0x85)
  ];
  final List<Color> _read = [
    Color.fromARGB(0xFF, 0xC7, 0xC7, 0xC7),
    Color.fromARGB(0xFF, 0xC7, 0xC7, 0xC7)
  ];

  final double _readThickness = 1.0;
  final double _notReadThickness = 2.0;

  final double _size = 65.0;

  final String _demoImageUrl = "https://scontent-hkg3-2.cdninstagram.com/vp/c7320e4002e1ccde0f939af015cf330e/5BF6B4C7/t51.2885-19/s150x150/31977749_818469158354525_4510161693153689600_n.jpg";

  StoryItem(Story story):
      this.story = story;

  List<Color> _getColors() {
    if(story.isRead) {
      return _read;
    } else {
      return _notRead;
    }
  }

  double _getBorderThickness() {
    if(story.isRead) {
      return _readThickness;
    } else {
      return _notReadThickness;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: new LinearGradient(
              colors: _getColors(),
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(_getBorderThickness()),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.5),
                color: Colors.blue,
                image: DecorationImage(
                  image: Image.network(_demoImageUrl).image,
                  fit: BoxFit.fill,
                )
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.5),
          child: Text("eut.d"),
        )
      ]
    );
  }

}

class StoryList extends StatefulWidget {
  @override
  _StoryListState createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {

  List<Story> _list = [
    Story()..isRead = true,
    Story()..isRead = false,
    Story()..isRead = true,
    Story()..isRead = false,
    Story()..isRead = false,
    Story()..isRead = false,
    Story()..isRead = false,
    Story()..isRead = false,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _list.map((i) => Padding(padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0), child: StoryItem(i))).toList(),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
      ),
    );
  }
}
