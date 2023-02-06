import 'package:app/src/models/albums_model.dart';

abstract class AlbumState{
  const AlbumState();
}
class AlbumLoading extends AlbumState{}
class AlbumError extends AlbumState{}
class NetworkError extends AlbumState{}
class AlbumLoaded extends AlbumState{
  final List<Album> album;
  const AlbumLoaded({this.album=const <Album>[]});

}