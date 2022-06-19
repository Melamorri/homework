import 'gif_interactor.dart';
import '../gif_model.dart';
import '../gif_service.dart';

class DefaultGifInteractor implements GifInteractor {
  final GifService _service = GifService();

  @override
  Future<List<Gif>> getGifs(String query) => _service.fetchGifs(query);
}
