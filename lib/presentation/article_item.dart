import 'package:dgsw_sns/container/edit_article.dart';
import 'package:dgsw_sns/model/models.dart';
import 'package:dgsw_sns/network/network_manager.dart';
import 'package:dgsw_sns/presentation/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:dgsw_sns/selector/selector.dart';

typedef ArticleCallback = Function(Article);

class ArticleItem extends StatelessWidget {

  final Article _article;
  final String _demoImageUrl = "https://scontent-hkg3-2.cdninstagram.com/vp/c7320e4002e1ccde0f939af015cf330e/5BF6B4C7/t51.2885-19/s150x150/31977749_818469158354525_4510161693153689600_n.jpg";
  final String _demoMediaUrl = "https://scontent-hkg3-2.xx.fbcdn.net/v/t1.0-9/40096979_1893271724049295_5566132913872830464_n.jpg?_nc_cat=0&oh=e298f0c12580b03ae836375f73ca8982&oe=5C38AC34";

  final double _profileSize = 35.0;

  final ArticleCallback onDelete;
  final ArticleCallback onUpdate;

  ArticleItem(this._article, this.onDelete, this.onUpdate);

  ImageProvider getFirstMediaImage() {
    if(_article.media == null || _article.media.length == 0)
      return Image.network(_demoMediaUrl).image;
    return Image.network(NetworkManager.$BASE_URL + _article.media[0].mediaUrl).image;
  }

  Member getMe(BuildContext context) {
    AppState state = StoreProvider.of<AppState>(context).state;
    var me = memberSelector(state);
    return me;
  }

  bool checkLike(BuildContext context) {
    var me = getMe(context);
    try {
      var favorite = _article.favorites?.firstWhere((i) => i.member.id == me.id);
      if(favorite == null) return false;
      return true;
    } catch (e) {
      return false;
    }
  }

  void doLike(BuildContext context, bool doLike) async {
    var me = getMe(context);

    var resp = await NetworkManager().likeArticle(_article.id, me.id, doLike);

    if (resp.status == 200) {
      onUpdate(resp.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    var isMeLike = checkLike(context);

    return Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.0, top: 5.0, right: 2.5, bottom: 5.0),
              child: Row(
                children: <Widget>[
                  ProfileImage(_profileSize, new Member(profileImage: _demoImageUrl)),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(_article.author.nickname, style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      showModalBottomSheet(context: context, builder: (context) {
                        return Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text("수정"),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => EditArticle(_article),
                                  ));
                                },
                              ),
                              ListTile(
                                title: Text("삭제"),
                                onTap: () {
                                  onDelete(_article);
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        );
                      });
                    },
                  )
                ],
              )
            ),
            GestureDetector(
              child: Image(
                width: double.infinity,
                image: getFirstMediaImage(),
              ),
              onDoubleTap: () => doLike(context, !isMeLike),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(isMeLike ? Icons.favorite : Icons.favorite_border), color: isMeLike? Colors.red : Colors.black, onPressed: () => doLike(context, !isMeLike),),
                  IconButton(icon: Icon(Icons.message), color: Colors.black, onPressed: (){},),
                  IconButton(icon: Icon(Icons.send), color: Colors.black, onPressed: (){},),
                  Expanded(child: Text(''),),
                  IconButton(icon: Icon(Icons.bookmark_border), color: Colors.black, onPressed: (){},),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('좋아하는 사람: eut.d님, earthwide님 외 237명', textAlign: TextAlign.left,),
                    Text(_article.content, textAlign: TextAlign.left,)
                  ],
                )
            )
          ],
        )
    );
  }

}