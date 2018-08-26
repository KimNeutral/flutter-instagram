import 'package:dgsw_sns/model/member.dart';

class Article {
  int idx;
  Member author;
  String content;
  List<Comment> comments;
  DateTime createdAt;
  DateTime updatedAt;
}

class Comment {
  Article article;
  Comment parent;
  Member author;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  Comment createChild() {
    var child = Comment();
    if(this.parent == null) {
      child.parent = this;
    } else {
      child.parent = this.parent;
    }

    return child;
  }
}