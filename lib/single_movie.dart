import 'package:flutter/material.dart';

import 'api.dart';

class SingleMovie extends StatefulWidget {
  SingleMovie({Key key, this.movieId}): super(key: key);
  final int movieId;

  @override
  SingleMovieState createState() => new SingleMovieState(movieId: movieId);
}

class SingleMovieState extends State<SingleMovie> {
  SingleMovieState({this.movieId});
  final int movieId;
  Map _movie;

  @override
  void initState() {
    super.initState();
    getMovieDetauls(movieId).then((value) {
      setState(() {
        _movie = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_movie == null) {
      return new Scaffold(
        body: new Center(
          child: new Text('Loading'),
        ),
      );
    }
    return new Scaffold(
      appBar: new AppBar(title: new Text(_movie['title'])),
      body: new Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          new Image.network(
              "https://image.tmdb.org/t/p/w500${_movie['backdrop_path']}"),
          new Positioned(
            child: new Container(
              decoration:
                  new BoxDecoration(color: const Color.fromRGBO(0, 0, 0, 0.5)),
            ),
            bottom: 0.0,
            top: 0.0,
            left: 0.0,
            right: 0.0,
          ),
          new Container(
            child: new Center(
              child: new Column(
                children: <Widget>[
                  new Container(
                    child: new Text(
                      _movie['title'],
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                        letterSpacing: 1.0,
                        height: 1.25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    margin: const EdgeInsets.only(top: 50.0),
                  ),
                  new Container(
                    child: new Text(
                      _movie['overview'],
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: "Roboto",
                          height: 1.25),
                    ),
                    margin: new EdgeInsets.only(top: 20.0),
                  )
                ],
              ),
            ),
            padding: new EdgeInsets.all(20.0),
            margin: const EdgeInsets.only(top: 211.0),
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
              begin: const Alignment(-0.5, -0.5),
              end: const Alignment(0.0, 0.0),
              colors: <Color>[
                const Color.fromRGBO(75, 35, 42, 1.0),
                const Color.fromRGBO(14, 16, 27, 1.0),
              ],
            )),
          ),
          new Positioned(
            top: 100.0,
            left: 0.0,
            right: 0.0,
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                decoration: new BoxDecoration(boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: new Color.fromRGBO(0, 0, 0, 0.2),
                    offset: new Offset(10.0, 10.0),
                  )
                ]),
                child: new Image.network(
                  "https://image.tmdb.org/t/p/w300${_movie['poster_path']}",
                  height: 150.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
