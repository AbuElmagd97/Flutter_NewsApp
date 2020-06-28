import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newsapp/news_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<News> _news = List<News>();
  static List<News> _newsInApp = List<News>();

  //fetching data from Api

  Future<List<News>> comingNews() async {
    var url = 'https://www.mocky.io/v2/5ecfddf13200006600e3d6d0';
    var response = await http.get(url);
    var news = List<News>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        news.add(News.fromJson(noteJson));
      }
    }
    return news;
  }

  @override
  void initState() {
    comingNews().then((value) {
      setState(() {
        _news.addAll(value);
        _newsInApp = _news;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(97),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 25.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
              ),
              child: AppBar(
                title: Text(
                  'News',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return _listItem(index);
        },
        itemCount: _newsInApp.length,
      ),
    );
  }

  _listItem(index) {
    return Container(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15.0, top: 1.0, right: 1.0, bottom: 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        _newsInApp[index].title,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MaterialApp(
                            debugShowCheckedModeBanner: false,
                            home: Scaffold(
                              appBar: AppBar(
                                centerTitle: true,
                                backgroundColor: Colors.white,
                                leading: IconButton(
                                  iconSize: 20.0,
                                  color: Colors.blue,
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                title: Text(
                                  _newsInApp[index].title,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              body: SingleChildScrollView(
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 220.0,
                                        width: 400,
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Image.network(
                                          _newsInApp[index].image,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                _newsInApp[index].publisher,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 17.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Divider(
                  color: Colors.black12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
