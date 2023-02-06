import 'package:app/src/blocs/album_bloc/album_bloc.dart';
import 'package:app/src/blocs/album_bloc/album_state.dart';
import 'package:flutter/material.dart';
import 'package:app/src/models/albums_model.dart';
import 'package:app/src/api/albums_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAlbums extends StatefulWidget {
  const MyAlbums({super.key});

  @override
  State<MyAlbums> createState() => _MyAppState();
}

class _MyAppState extends State<MyAlbums> {
  late Future<List<Album>> futureAlbum;
  static const albums = AlbumsApi();
  @override
  void initState() {
    super.initState();
    futureAlbum = albums.fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
            builder: (context) => IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  tooltip: 'back',
                )),
        title: const Text('Fetch Data Example'),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          
          if(state is AlbumLoading)
          {
            return const Center(child: CircularProgressIndicator());
          }
          if(state is AlbumError)
          {
            return const Center(child: Text('No Data Found'));
          }
          if(state is NetworkError)
          {
            return const Center(child: Text('Error in Fetching Api Response'));
          }
          if(state is AlbumLoaded)
          { return Center(
            child: ListView.builder(
                      itemCount: state.album.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 75,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        state.album[index].id.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      const Text(
                                        '.',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          state.album[index].title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        );
                      })
              
              
            
          );}
         else{
          return const Text('Something Went wrong');
        }
        
        }
      ),
    );
  }
}
