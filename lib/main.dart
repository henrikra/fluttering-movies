import 'package:flutter/material.dart';

import 'single_movie.dart';
import 'api.dart';

void main() => runApp(new MyApp());

class PhotoHero extends StatelessWidget {
  const PhotoHero({ Key key, this.photo, this.onTap, this.width, this.height, this.tag }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;
  final double height;
  final int tag;

  Widget build(BuildContext context) {
    return new SizedBox(
      width: width,
      height: height,
      child: new Hero(
        tag: tag,
        child: new GestureDetector(
          onTap: onTap,
          child: new Image.network(photo)
        ),
      ),
    );
  }
}

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
        child: new ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            var movie = _movies[index];
            return new PhotoHero(
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
              height: 100.0,
            );
          },
          itemCount: _movies.length,
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
