import 'package:dart_json_mapper/annotations.dart';
import 'package:dgsw_sns/model/media.dart';
import 'package:dgsw_sns/model/member.dart';


@jsonSerializable
class Article {
  String id;
  Member author;
  String content;
  List<Comment> comments;
  List<Favorite> favorites;
  List<Media> media;
  DateTime createdAt;
  DateTime updatedAt;

  Article({this.id, this.author, this.content, this.comments, this.favorites, this.media, this.createdAt,
      this.updatedAt});

  @override
  String toString() {
    return 'Article{id: $id, author: $author, content: $content, comments: $comments, media: $media, createdAt: $createdAt, updatedAt: $updatedAt, favorites: $favorites}';
  }
}

@jsonSerializable
class Comment {
  String id;

  @JsonProperty(ignore: true)
  Article article;

  @JsonProperty(ignore: true)
  Comment parent;
  Member member;
  String content;
  DateTime createdAt;
  DateTime updatedAt;


  Comment({this.id, this.article, this.parent, this.member, this.content,
      this.createdAt, this.updatedAt});

  Comment createChild() {
    var child = Comment();
    if(this.parent == null) {
      child.parent = this;
    } else {
      child.parent = this.parent;
    }

    return child;
  }

  @override
  String toString() {
    return 'Comment{id: $id, article: $article, parent: $parent, member: $member, content: $content, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

@jsonSerializable
class Favorite {
  int id;
  Member member;

  Favorite({this.id, this.member});

  @override
  String toString() {
    return 'Favorite{id: $id, member: $member}';
  }
}