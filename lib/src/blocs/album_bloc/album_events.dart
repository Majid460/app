import 'package:app/src/models/albums_model.dart';
import 'package:equatable/equatable.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();
  @override
  List<Object> get props => [];
}

class GetAlbums extends AlbumEvent{}
class LoadingAlbums extends AlbumEvent{}