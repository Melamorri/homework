import 'package:flutter/material.dart';
import 'package:my_animation_app/bands_repository.dart';
import 'package:my_animation_app/card.dart';

void main() {
  runApp(const MyAnimationApp());
}

class MyAnimationApp extends StatefulWidget {
  const MyAnimationApp({Key? key}) : super(key: key);

  @override
  State<MyAnimationApp> createState() => _MyAnimationAppState();
}

class _MyAnimationAppState extends State<MyAnimationApp> with TickerProviderStateMixin {
  double turns = 0.0;
  final bandsRepository = BandsRepository();
  void _changeRotation() {
    setState(() => turns += 1.0 / 8.0);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goth Rock',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Gothic Rock Bands'),
        ),
        body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    SizedBox(height: 30,),
                    GestureDetector(
                      onTap: _changeRotation,
                      child: AnimatedRotation(
                          turns: turns,
                          duration: const Duration(seconds: 5),
                          child: Image.asset('images/logo.png', height: 100, width: 100,)
                      ),
                    ),
                    SizedBox(height: 30,),
                    ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: bandsRepository.bands.length,
                      itemBuilder: (BuildContext context, int index) {
                        final band = bandsRepository.bands[index];
                        return MyCard(bandImage: band.image, bandTitle: band.title, bandGallery: band.images,);
                      },
                    )
                  ],
                ),

        )
      ),
    );
  }
}
class Bands {
  final String image;
  final String title;
  final List<String> images;
  Bands (this.image, this.title, this.images);
}

