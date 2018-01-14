import 'package:flutter/material.dart';

import 'single_movie.dart';
import 'api.dart';
import 'photo_hero.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _movies = [];

  @override
  void initState() {
    super.initState();
    getPopuralMovies().then((value) {
      setState(() {
        _movies = value['results'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              height: 270.0,
              child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(20.0),
                itemExtent: MediaQuery.of(context).size.width - 20,
                itemBuilder: (BuildContext context, int index) {
                  var movie = _movies[index];
                  return new Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    child: new Stack(
                      children: <Widget>[
                        new Image.network(
                          "https://image.tmdb.org/t/p/w500${movie['backdrop_path']}"),
                        new Positioned(
                          child: new Container(
                            decoration:
                                new BoxDecoration(color: const Color.fromRGBO(0, 0, 0, 0.25)),
                          ),
                          top: 0.0,
                          left: 0.0,
                          right: 0.0,
                          height: 189.0,
                        ),
                        new Positioned(
                          bottom: 0.0,
                          left: 10.0,
                          child: new PhotoHero(
                            height: 100.0,
                            photo: "https://image.tmdb.org/t/p/w300${movie['poster_path']}",
                            tag: movie['id'],
                            onTap: () {
                              Navigator.push(
                                context, 
                                new MaterialPageRoute(builder: (_) => new SingleMovie(
                                  movieId: movie['id'],
                                  passedMovie: movie,
                                ))
                              );
                            },
                          ),
                        ),
                        new Positioned(
                          bottom: 30.0,
                          left: 90.0,
                          right: 0.0,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                movie['title'], 
                                style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: _movies.length,
              ),
            ),
          ],
        ),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: const Alignment(-0.5, -0.5),
            end: const Alignment(0.0, 0.0),
            colors: <Color>[
              const Color.fromRGBO(75, 35, 42, 1.0),
              const Color.fromRGBO(14, 16, 27, 1.0),
            ],
          )
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
