import 'dart:io';

import 'package:dgsw_sns/action/actions.dart';
import 'package:dgsw_sns/model/models.dart';
import 'package:dgsw_sns/network/network_manager.dart';
import 'package:dgsw_sns/presentation/add_edit_article_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:dgsw_sns/selector/selector.dart';
import 'package:uuid/uuid.dart';

class AddArticle extends StatelessWidget {
  AddArticle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnSaveCallback>(
      converter: (Store<AppState> store) {
        return ({article, image}) async {
          if(image == null) return;

          var fileResp = await NetworkManager().uploadImage(image);
          if(fileResp.status != 200) return;

          var member = memberSelector(store.state);

          article.id = Uuid().v4();
          article.author = member;
          article.media = List()..add(fileResp.data);

          var resp = await NetworkManager().postArticle(article);

          if(resp.status == 200) {
            store.dispatch(AddArticleAction(resp.data));
            Navigator.of(context).pop();
          }
        };
      },
      builder: (BuildContext context, OnSaveCallback onSave) {
        return AddEditArticleScreen(
          onSave: onSave,
          isEdit: false,
        );
      },
    );
  }
}