import 'dart:async';
import 'dart:io';

import 'package:dgsw_sns/model/article.dart';
import 'package:dgsw_sns/network/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef OnSaveCallback = Function({@required Article article, File image});

class AddEditArticleScreen extends StatefulWidget {
  final bool isEdit;
  final OnSaveCallback onSave;
  Article article;
  File image;

  AddEditArticleScreen({@required this.isEdit, @required this.onSave, this.article}){
    if(article == null) article = Article();
  }

  @override
  State<StatefulWidget> createState() {
    return AddEditArticleScreenState(isEdit: isEdit, onSave: onSave, article: article);
  }
}

class AddEditArticleScreenState extends State<AddEditArticleScreen> {
  static final GlobalKey<FormFieldState<String>> _contentKey =
      GlobalKey<FormFieldState<String>>();

  final bool isEdit;
  final OnSaveCallback onSave;
  Article article;
  File image;

  final String _defaultImageUrl = 'https://www.industriehof.com/images/social/xing-c.png';

  AddEditArticleScreenState({@required this.isEdit, @required this.onSave, this.article}){
    if(article == null) article = Article();
  }

  ImageProvider getImage() {
    if(image != null) {
      return Image.file(image).image;
    }
    if(article.media != null && article.media.length > 0) {
      return Image.network(NetworkManager.$BASE_URL + article.media[0].mediaUrl).image;
    }
    return Image.network(_defaultImageUrl).image;
  }

  Future showImagePicker() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      this.image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    var container = Container(
      child: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white30
                  ),
                  child: Image(image: getImage(),),
                ),
                onTap: showImagePicker,
              ),
              TextFormField(
                key: _contentKey,
                decoration: InputDecoration(
                    hintText: '내용을 입력해주세요.'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return '이 칸을 채워주세요';
                  }
                },
                initialValue: !isEdit ? '' : article.content,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 45.0,
                    child: FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () async {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_contentKey.currentState.validate()) {
                          onSave(article: article..content = _contentKey.currentState.value, image: image);
                        }
                      },
                      child: Text(!isEdit ? '등록' : '수정'),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(!isEdit ? '추가' : '수정'),),
      body: SingleChildScrollView(child: Center(child: container)),
    );
  }
}