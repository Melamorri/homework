
import 'main.dart';

class BandsRepository {
  late List <Bands> bands = [
    Bands('https://i.pinimg.com/originals/3b/a6/1a/3ba61a5cb0cab9a41c9b2f2ea973a118.jpg', 'Bauhaus', bauhausImages),
    Bands('https://iscale.iheart.com/catalog/artist/829998', 'Siouxsie and the Banshees', siouxsieImages),
    Bands('https://cdns-images.dzcdn.net/images/artist/8f644b0c7ddc36e0d7233b44ebdc9bfc/500x500.jpg', 'Fields of the Nephilim', nephilimImages)
  ];

  List<String> bauhausImages = [
    'https://i.pinimg.com/originals/3b/a6/1a/3ba61a5cb0cab9a41c9b2f2ea973a118.jpg',
    'https://i.pinimg.com/originals/4b/01/3a/4b013ac842a6c95397ee353784ed6a28.jpg',
    'https://post-punk.com/wp-content/uploads/2019/08/Bauhaus-bw-1.jpg',
  ];
  List<String> siouxsieImages = [
    'https://iscale.iheart.com/catalog/artist/829998',
    'https://lastfm.freetls.fastly.net/i/u/ar0/862dc16de767593d5ed2c39a8afa3c2a.jpg',
    'https://www.rockarchive.com/media/4469/siousxie-and-the-banshees-ss001migrflip.jpg?anchor=center&mode=crop&width=800&height=800&rnd=132960441710000000&overlay=watermark.png&overlay.size=230,20&overlay.position=0,780',
  ];
  List<String> nephilimImages = [
    'https://cdns-images.dzcdn.net/images/artist/8f644b0c7ddc36e0d7233b44ebdc9bfc/500x500.jpg',
    'http://www.metalmusicarchives.com/images/artists/fields-of-the-nephilim.jpg',
    'https://studiosol-a.akamaihd.net/uploadfile/letras/fotos/3/8/9/7/3897315df1a5826edd83227974f8efa1.jpg',
  ];
}