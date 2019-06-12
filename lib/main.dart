import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'article.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshList,
        child: ListView(
          children: _articles.map(_buildItem).toList(),
        ),
      ),
    );
  }

  Future<void> _refreshList() {
    setState(() {
      _articles.removeAt(0);
    });
    return Future.delayed(Duration(seconds: 2));
  }

  Widget _buildItem(Article article) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ExpansionTile(
        key: Key(article.text),
        title: Text(article.text),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("this article has ${article.commentsCount} comments"),
              IconButton(
                icon: Icon(Icons.open_in_new),
                onPressed: () async {
                  final url = "http://${article.domain}";
                  if (await canLaunch(url)) {
                    launch(url);
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
