class Gif {
  final String image;

  Gif({
    required this.image,
  });

  factory Gif.fromJson(Map<String, dynamic> json) => Gif(
        image: json['images']['original']['url'],
      );
}
