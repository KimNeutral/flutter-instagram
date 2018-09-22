import 'package:dgsw_sns/model/member.dart';
import 'package:dgsw_sns/network/network_manager.dart';
import 'package:flutter/material.dart';

typedef OnLoginCallback = Function(bool success, Member member);

// Create a Form Widget
class LoginScreen extends StatefulWidget {
  final OnLoginCallback onLogin;

  LoginScreen(this.onLogin);

  @override
  LoginScreenState createState() {
    return LoginScreenState(onLogin);
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class LoginScreenState extends State<LoginScreen> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final pwController = TextEditingController();

  final OnLoginCallback onLogin;

  LoginScreenState(this.onLogin);

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Instagram_logo.svg/1200px-Instagram_logo.svg.png", width: 180.0,),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
              ),
              TextFormField(
                controller: idController,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return '이 칸을 채워주세요';
                  }
                },
                decoration: InputDecoration(
                  hintText: '사용자 이름',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(0xFF, 0xBB, 0xBB, 0xBB)),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(0xFF, 0xBB, 0xBB, 0xBB)),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(0xFF, 0xF5, 0xF5, 0xF5),
                  contentPadding: EdgeInsets.all(12.0),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 15.0)),
              TextFormField(
                controller: pwController,
                obscureText: true,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return '이 칸을 채워주세요';
                  }
                },
                decoration: InputDecoration(
                  hintText: '비밀번호',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(0xFF, 0xBB, 0xBB, 0xBB)),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(0xFF, 0xBB, 0xBB, 0xBB)),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(0xFF, 0xF5, 0xF5, 0xF5),
                  contentPadding: EdgeInsets.all(12.0),
                ),
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
                      if (_formKey.currentState.validate()) {
                        // TODO: Login
                        var loginData = await NetworkManager().login(idController.text, pwController.text);
                        if(loginData.status == 200) {
                          onLogin(true, loginData.data);
//                          Navigator.of(context).pushReplacementNamed('/main');
                        } else {
                          onLogin(false, null);
                        }
                      }
                    },
                    child: Text('로그인'),
                  )
                ),
              ),
            ],
          ),
        )
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black26)
          )
        ),
        child: FlatButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "계정이 없으신가요?",
                style: TextStyle(
                  color: Colors.black54
                ),
              ),
              Text(
                " 가입하기.",
                style: TextStyle(
                  fontWeight: FontWeight.w600
                ),
              ),
            ]
          ),
          onPressed: () => Navigator.of(context).pushNamed('/register'),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        )
      ),
    );
  }
}
