import '../model/app_state.dart';
import 'articles_reducer.dart';
import 'stories_reducer.dart';
import 'members_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    member: membersReducer(state.member, action),
    articles: articlesReducer(state.articles, action),
    stories: storiesReducer(state.stories, action),
  );
}