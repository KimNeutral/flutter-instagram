import 'package:dgsw_sns/action/article_action.dart';
import 'package:redux/redux.dart';
import 'package:dgsw_sns/model/article.dart';

final articlesReducer = combineReducers<List<Article>>([
  TypedReducer<List<Article>, AddArticleAction>(_addArticle),
  TypedReducer<List<Article>, UpdateArticleAction>(_updateArticle),
  TypedReducer<List<Article>, DeleteArticleAction>(_deleteArticle),
  TypedReducer<List<Article>, LoadArticlesAction>(_setLoadedArticles),
  TypedReducer<List<Article>, LoadArticlesFailedAction>(_setLoadFailedArticles),
]);

List<Article> _addArticle(List<Article> state, AddArticleAction action) {
  return List.from(state)..add(action.article);
}

List<Article> _updateArticle(List<Article> state, UpdateArticleAction action) {
  return state.map((s) => s.id == action.id ? action.updatedArticle : s).toList();
}

List<Article> _deleteArticle(List<Article> state, DeleteArticleAction action) {
  return state.where((s) => s.id != action.id).toList();
}

List<Article> _setLoadedArticles(List<Article> state, LoadArticlesAction action) {
  return action.articles;
}

List<Article> _setLoadFailedArticles(List<Article> state, LoadArticlesFailedAction action) {
  return [];
}