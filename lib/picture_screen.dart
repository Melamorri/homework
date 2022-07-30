import 'package:flutter/material.dart';

class PictureScreen extends StatelessWidget {
  final List<String>? images;
  final String? heroTag;
  final bandTitle;


  const PictureScreen(this.images, {Key? key, this.heroTag, this.bandTitle, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bandTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: List.generate(
              images!.length,
                  (index) => (heroTag != null && index == 0)
                  ? Card(
                child: SizedBox(
                    height: 200,
                    child: Hero(
                      tag: heroTag!,
                      child: FadeInImage(
                        placeholder: AssetImage('images/placeholder.png'),
                        image: NetworkImage(images![index]),
                      ),
                    )
                ),
              )
                  : Card(
                child: SizedBox(
                  height: 200,
                  child: FadeInImage(
                    placeholder: AssetImage('images/placeholder.png'),
                    image: NetworkImage(images![index]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
