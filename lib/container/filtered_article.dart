import 'package:dgsw_sns/model/app_state.dart';
import 'package:dgsw_sns/model/models.dart';
import 'package:dgsw_sns/presentation/article_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:dgsw_sns/selector/selector.dart';
import 'package:dgsw_sns/action/actions.dart';

class FilteredArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel> (
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return ArticleList(
          articles: vm.articles,
          onDelete: vm.onDelete,
          onUpdate: vm.onUpdate,
        );
      },
    );
  }
}

class _ViewModel {
  final List<Article> articles;
  final ArticleCallback onDelete;
  final ArticleCallback onUpdate;

  _ViewModel({@required this.articles, @required this.onDelete, @required this.onUpdate});

  factory _ViewModel.fromStore(Store<AppState> store) {
    var vm = _ViewModel(
      articles: articlesSelector(store.state),
      onDelete: (article) {
        store.dispatch(DeleteArticleAction(article.id));
      },
      onUpdate: (article) {
        store.dispatch(UpdateArticleAction(article.id, article));
      }
    );
    return vm;
  }
}