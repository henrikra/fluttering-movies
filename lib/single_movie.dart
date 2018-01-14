import 'package:flutter/material.dart';
import 'dart:async';

import 'api.dart';
import 'photo_hero.dart';

class SingleMovie extends StatefulWidget {
  SingleMovie({Key key, this.movieId, this.passedMovie}): super(key: key);
  final int movieId;
  final Map passedMovie;

  @override
  SingleMovieState createState() => new SingleMovieState(movieId: movieId, passedMovie: passedMovie);
}

class SingleMovieState extends State<SingleMovie> {
  SingleMovieState({this.movieId, this.passedMovie});
  final int movieId;
  Map _movie;
  String _director;
  String _genres;
  Map passedMovie;

  @override
  void initState() {
    super.initState();
    Future.wait([getMovieDetails(movieId), getMovieCredits(movieId)]).then((results) {
      setState(() {
        _movie = results.first;
        _director = results.last['crew'].firstWhere((n) => n['job'] == 'Director')['name'];
        _genres = results.first['genres'].map((n) => n['name']).join(', ');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(color: const Color.fromRGBO(14, 16, 27, 1.0),),
          new PhotoHero(
            photo: "https://image.tmdb.org/t/p/w500${passedMovie['backdrop_path']}",
            tag: "${passedMovie['id']}backdrop",
            height: 211.0,
          ),
          new Positioned(
            child: new Container(
              decoration:
                  new BoxDecoration(color: const Color.fromRGBO(0, 0, 0, 0.5)),
            ),
            top: 0.0,
            left: 0.0,
            right: 0.0,
            height: 211.0,
          ),
          new ListView(
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          child: new Text(
                            passedMovie['title'],
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
                          margin: const EdgeInsets.only(top: 70.0),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: new Text("${_movie != null ? _movie['runtime'].toString() : '-'} min", style: new TextStyle(
                            color: new Color.fromRGBO(255, 255, 255, 0.7)
                          )),
                        ),
                        new Container(
                          child: new Text(
                            passedMovie['overview'],
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: "Roboto",
                                height: 1.25),
                          ),
                          margin: new EdgeInsets.symmetric(vertical: 20.0),
                        ),
                        new Row(
                          children: <Widget>[
                            new Expanded(
                              flex: 2,
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text('DIRECTOR', style: new TextStyle(
                                    color: new Color.fromRGBO(255, 255, 255, 0.7)
                                  )),
                                  new Container(
                                    child: new Text(_director ?? '...', 
                                      style: new TextStyle(color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    margin: const EdgeInsets.only(top: 5.0),
                                  )
                                ],
                              ),
                            ),
                            new Expanded(
                              flex: 3,
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text('GENRES', style: new TextStyle(
                                    color: new Color.fromRGBO(255, 255, 255, 0.7)
                                  )),
                                  new Container(
                                    child: new Text(
                                      _genres ?? '...', 
                                      style: new TextStyle(color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    margin: const EdgeInsets.only(top: 5.0),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    padding: new EdgeInsets.all(20.0),
                    margin: const EdgeInsets.only(top: 191.0),
                    decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                      begin: const Alignment(-0.25, -0.5),
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
                        child: new PhotoHero(
                          photo: "https://image.tmdb.org/t/p/w300${passedMovie['poster_path']}",
                          height: 150.0,
                          tag: "${passedMovie['id']}",
                        ),
                      ),
                    ),
                  ),
                ],
              )   
            ],
          ),
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            height: 76.0,
            child: new Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.arrow_back_ios, color: Colors.white,), 
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
