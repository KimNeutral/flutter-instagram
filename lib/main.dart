import 'package:dart_json_mapper/json_mapper.dart';
import 'package:dgsw_sns/container/add_article.dart';
import 'package:dgsw_sns/container/filtered_article.dart';
import 'package:dgsw_sns/container/login.dart';
import 'package:dgsw_sns/model/jsonConverter/date_converter.dart';
import 'package:dgsw_sns/model/models.dart';
import 'package:dgsw_sns/presentation/add_edit_article_screen.dart';
import 'package:dgsw_sns/presentation/login_screen.dart';
import 'package:dgsw_sns/presentation/register_screen.dart';
import 'package:dgsw_sns/reducer/app_state_reducer.dart';
import 'package:dgsw_sns/network/network_manager.dart';
import 'package:dgsw_sns/story_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'main.reflectable.dart';
import 'package:dgsw_sns/action/actions.dart';

void initializeJsonMapper() {
  JsonMapper.registerConverter<DateTime>(CustomDateConverter());

  final iterableArticleDecorator = (value) => value?.cast<Article>();
  JsonMapper.registerValueDecorator<List<Article>>(iterableArticleDecorator);
  JsonMapper.registerValueDecorator<Set<Article>>(iterableArticleDecorator);

  final iterableCommentDecorator = (value) => value?.cast<Comment>();
  JsonMapper.registerValueDecorator<List<Comment>>(iterableCommentDecorator);
  JsonMapper.registerValueDecorator<Set<Comment>>(iterableCommentDecorator);

  final iterableMediaDecorator = (value) => value?.cast<Media>();
  JsonMapper.registerValueDecorator<List<Media>>(iterableMediaDecorator);
  JsonMapper.registerValueDecorator<Set<Media>>(iterableMediaDecorator);

  final iterableFavoriteDecorator = (value) => value?.cast<Favorite>();
  JsonMapper.registerValueDecorator<List<Favorite>>(iterableFavoriteDecorator);
  JsonMapper.registerValueDecorator<Set<Favorite>>(iterableFavoriteDecorator);
}

void main() {
  initializeReflectable();
  initializeJsonMapper();
  runApp(MyApp());
}

void loadArticles(Store<AppState> store) async {
  var articleData = await NetworkManager().getArticles();
  if(articleData?.data != null) {
    for(var article in articleData.data) {
      store.dispatch(AddArticleAction(article));
    }
  }
}

class MyApp extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState()
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    loadArticles(store);

    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'DGSW SNS',
        theme: new ThemeData(
          primaryColor: Color.fromARGB(0xFF, 0xFA, 0xFA, 0xFA),
          accentColor: Colors.white,
          buttonColor: Colors.white,
          backgroundColor: Colors.white,
          dividerColor: Color.fromARGB(0xFF, 0xEF, 0xEF, 0xEF),
          primaryIconTheme: IconThemeData(
            color: Colors.black
          ),
          textTheme: TextTheme(
            title: TextStyle(color: Colors.black),
            body1: TextStyle(color: Colors.black),
            body2: TextStyle(color: Colors.black),
            button: TextStyle(color: Colors.black)
          ),
          textSelectionColor: Colors.black
        ),
        home: Login(),
        routes: <String, WidgetBuilder> {
          '/login': (context) => Login(),
          '/register': (context) => RegisterScreen(),
          '/main': (context) => MainPage(),
          '/article/add': (context) => AddArticle(),
        },
        debugShowCheckedModeBanner: false
      )
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  void _setSelectedIndex(int idx) {
    if(idx == 2) {
      Navigator.of(context).pushNamed("/article/add");
      return;
    }
    setState(() {
      selectedIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          title: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Instagram_logo.svg/1200px-Instagram_logo.svg.png", width: 90.0,),
          elevation: 1.0,

        ),
      ),
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: StoryList(),
            ),
            SliverToBoxAdapter(
              child: FilteredArticle(),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _setSelectedIndex,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.home, color: Theme.of(context).iconTheme.color,),
              title: Text('Home', style: Theme.of(context).textTheme.button,),
          ),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color,),
              title: Text('Search', style: Theme.of(context).textTheme.button,)
          ),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
              title: Text('Add', style: Theme.of(context).textTheme.button,)
          ),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.favorite_border, color: Theme.of(context).iconTheme.color,),
              activeIcon: Icon(Icons.favorite, color: Theme.of(context).iconTheme.color),
              title: Text('Favorite', style: Theme.of(context).textTheme.button,)
          ),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.person_outline, color: Theme.of(context).iconTheme.color,),
              activeIcon: Icon(Icons.person, color: Theme.of(context).iconTheme.color),
              title: Text('Profile', style: Theme.of(context).textTheme.button,)
          ),
        ],
      ),
    );
  }
}