
import 'package:dgsw_sns/model/article.dart';
import 'package:dgsw_sns/network/network_manager.dart';
import 'package:dgsw_sns/presentation/article_item.dart';
import 'package:flutter/material.dart';

typedef ArticleCallback = Function(Article);

class ArticleList extends StatelessWidget {

  final List<Article> articles;
  final ArticleCallback onDelete;
  final ArticleCallback onUpdate;

  ArticleList({@required this.articles, @required this.onDelete, @required this.onUpdate}){
    articles.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, idx) {
          return ArticleItem(articles[idx], _onItemDelete, _onItemUpdate);
        },
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }

  void _onItemDelete(Article article) async {
    var resp = await NetworkManager().deleteArticle(article.id);
    if(resp.status == 200)
      onDelete(article);
    else {
      // TODO: 실패 알림
    }
  }

  void _onItemUpdate(Article article) async {
    onUpdate(article);
  }
}
