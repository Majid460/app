import 'package:app/src/api/albums_api.dart';
import 'package:app/src/blocs/album_bloc/album_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/src/blocs/album_bloc/album_events.dart';
import 'package:app/src/models/albums_model.dart';

class AlbumBloc extends Bloc<AlbumEvent,AlbumState>{
  final AlbumsApi api=const AlbumsApi();
  late List<Album> listAlbum;
  AlbumBloc():super(AlbumLoading()){
   on<GetAlbums>((event, emit) async {
      try {
        emit(AlbumLoading());
        listAlbum = await api.fetchAlbum();
        emit(AlbumLoaded(album:listAlbum));
        if (listAlbum.isEmpty) {
          emit(AlbumError());
        }
      } catch(e)
      {
        emit(NetworkError());
      } 
    });
  }
 
}