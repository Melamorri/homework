import '../gif_model.dart';

abstract class GifInteractor {
  Future<List<Gif>> getGifs(String query);
}
