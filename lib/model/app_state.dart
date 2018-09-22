import 'package:dgsw_sns/model/models.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final Member member;
  final List<Story> stories;
  final List<Article> articles;

  AppState({this.member, this.stories = const [], this.articles = const []});

  AppState copyWith({
    Member member,
    List<Story> storys,
    List<Article> articles
  }) {
    return AppState(
      member: member ?? this.member,
      stories: storys ?? this.stories,
      articles: articles ?? this.articles,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              member == other.member &&
              stories == other.stories &&
              articles == other.articles;

  @override
  int get hashCode =>
      member.hashCode ^
      stories.hashCode ^
      articles.hashCode;

  @override
  String toString() {
    return 'AppState{member: $member, stories: $stories, articles: $articles}';
  }
}
