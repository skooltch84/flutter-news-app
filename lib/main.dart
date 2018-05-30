import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//Top Us Headlines
String _apiUrl1 = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=22d87c157381478caebed8f1182f2f22";

//Articles about Bitcoin
String _apiUrl2 = "https://newsapi.org/v2/everything?q=bitcoin&sortBy=publishedAt&apiKey=22d87c157381478caebed8f1182f2f22";

//Top Articles from TechCrunch
String _apiUrl3 = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=22d87c157381478caebed8f1182f2f22";


List _provider1;
List _provider2;
List _provider3;


void main() async{

   _provider1 = await fetchData(_apiUrl1);
   _provider2 = await fetchData(_apiUrl2);
   _provider3 = await fetchData(_apiUrl3);



  runApp(new MaterialApp(
    home: new Categories(),
  ));
}


class Categories extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("News"),
          centerTitle: true,


        ),

        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              new RaisedButton(
                padding: const EdgeInsets.all(12.0),
                color: Colors.red,
                onPressed: (){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context)=> new Headlines(provider: _provider1,))
                  );
                },
                child: new Text("Get Top US Headlines",
                  style: new TextStyle(
                    fontSize: 21.0,
                    color: Colors.white,
                  ),),),


              new RaisedButton(
                padding: const EdgeInsets.all(12.0),
                color: Colors.green,
                onPressed: (){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context)=> new Headlines(provider: _provider2,))
                  );
                },
                child: new Text("Get Bitcoin Headlines",
                  style: new TextStyle(
                    fontSize: 21.0,
                    color: Colors.white,
                  ),),),


              new RaisedButton(
                padding: const EdgeInsets.all(12.0),
                color: Colors.blue,
                onPressed: (){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context)=> new Headlines(provider: _provider3,))
                  );
                },
                child: new Text("Top Articles from TechCrunch",
                  style: new TextStyle(
                    fontSize: 21.0,
                    color: Colors.white,
                  ),),),



            ],
          ),
        )

    );
  }

}



class Headlines extends StatelessWidget{

  final List provider;

  Headlines({Key key, @required this.provider}) : super(key : key);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Headlines"),
        centerTitle: true,
      ),

      body: new Center(
        child: new ListView.builder(
          //key: ,
            padding: const EdgeInsets.all(15.0),
            itemCount: provider.length,
            itemBuilder: (BuildContext context, int position){

              if(position.isOdd)return new Divider(
                color: Colors.red,
              );
              final index = position ~/2;

              return new ListTile(
                title: new Text("${provider[index]['title']}",
                    style: new TextStyle(
                        fontSize: 18.9,
                        fontWeight: FontWeight.bold)),

                subtitle: new Text("${provider[index]['description']}",
                    style: new TextStyle(
                        fontSize: 13.4,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic)),

              );


            }
        ),
      ),


    );
  }

}




Future<List> fetchData(String apiUrl) async{
  http.Response response = await http.get(apiUrl);
  return (json.decode(response.body))['articles'];

}