import 'package:flutter/material.dart';

class SingleMovie extends StatelessWidget {
  SingleMovie({this.movie});

  final Map movie;
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(movie['title'])),
      body: new Column(
        children: <Widget>[
          new Image.network("https://image.tmdb.org/t/p/w500${movie['backdrop_path']}"),
          new Container(
              child: new Center(
                child: new Column(
                  children: <Widget>[
                    new Image.network("https://image.tmdb.org/t/p/w300${movie['poster_path']}", height: 150.0,),
                    new Text(movie['title'], style: new TextStyle(
                      color: Colors.white, fontSize: 22.0
                    ), textAlign: TextAlign.center,)
                  ],
                ),
              ),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  begin: Alignment.topLeft,
                  end: const Alignment(0.0, 0.0),
                  colors: <Color>[
                    const Color.fromRGBO(75, 35, 42, 1.0),
                    const Color.fromRGBO(14, 16, 27, 1.0),
                  ],
                )
              ),
            ),
          
        ],
      ) ,
    );
  }
}