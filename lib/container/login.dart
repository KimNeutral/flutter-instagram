import 'package:dgsw_sns/action/actions.dart';
import 'package:dgsw_sns/model/models.dart';
import 'package:dgsw_sns/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnLoginCallback>(
      converter: (store) {
        return (success, member) {
          if(success) {
            store.dispatch(LoadMemberAction(member));
            Navigator.of(context).pushReplacementNamed("/main");
          } else {

          }
        };
      },
      builder: (context, vm) {
        return LoginScreen(vm);
      },
    );
  }
}
