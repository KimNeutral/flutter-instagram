import 'package:dgsw_sns/model/article.dart';

class LoadArticlesAction {
  final List<Article> articles;

  LoadArticlesAction(this.articles);

  @override
  String toString() {
    return 'LoadArticlesAction{articles: $articles}';
  }
}

class LoadArticlesFailedAction {}

class AddArticleAction {
  final Article article;

  AddArticleAction(this.article);

  @override
  String toString() {
    return 'AddArticleAction{article: $article}';
  }
}

class UpdateArticleAction {
  final String id;
  final Article updatedArticle;

  UpdateArticleAction(this.id, this.updatedArticle);

  @override
  String toString() {
    return 'UpdateArticleAction{id: $id, updatedArticle: $updatedArticle}';
  }
}

class DeleteArticleAction {
  final String id;

  DeleteArticleAction(this.id);

  @override
  String toString() {
    return 'DeleteArticleAction{id: $id}';
  }
}

class FavorArticleAction {
  final String id;

  FavorArticleAction(this.id);

  @override
  String toString() {
    return 'FavorArticleAction{id: $id}';
  }
}
