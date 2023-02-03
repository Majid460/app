import 'package:flutter/material.dart';
import 'package:app/src/models/albums_model.dart';
import 'package:app/src/api/albums_api.dart';
class MyAlbums extends StatefulWidget {
  const MyAlbums({super.key});

  @override
  State<MyAlbums> createState() => _MyAppState();
}

class _MyAppState extends State<MyAlbums> {
  late Future<List<Album>> futureAlbum;
  static const albums= AlbumsApi();
  @override
  void initState() {
    super.initState();
    futureAlbum = albums.fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
     leading:Builder(builder:(context)=>IconButton(onPressed: () {Navigator.pushReplacementNamed(context, '/home');
     }, icon: const Icon(Icons.arrow_back_ios),tooltip: 'back',)) ,
     title: const Text('Fetch Data Example'),automaticallyImplyLeading: false,),
        body: Center(
          child: FutureBuilder<List<Album>>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(children: [
                  const SizedBox(height: 10,),
                  Container(
                  height: 75,
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [
                    const SizedBox(width: 10,),
                    Text(snapshot.data![index].id.toString(),style: const TextStyle(color: Colors.white,fontSize: 20),),
                    const Text('.',style: TextStyle(fontSize: 20,color: Colors.white),),
                    const SizedBox(width: 10,),
                    Expanded(child:Text(snapshot.data![index].title,style: const TextStyle(color: Colors.white,fontSize: 20),),
                
                    ),
                      ],)
                ),
                ],),);
                
                
              });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      );
  }
}