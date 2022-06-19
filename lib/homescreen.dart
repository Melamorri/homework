import 'package:flutter/material.dart';
import 'package:week8/widgets/gif_card.dart';
import 'package:week8/widgets/searchfield.dart';
import 'interactors/default_gif_interactor.dart';
import 'interactors/gif_interactor.dart';
import 'gif_model.dart';

class GifsScreen extends StatefulWidget {
  const GifsScreen({Key? key}) : super(key: key);

  @override
  State<GifsScreen> createState() => _GifsScreenState();
}

class _GifsScreenState extends State<GifsScreen> {
  final GifInteractor _interactor = DefaultGifInteractor();
  var data = <Gif>[];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Color(0xFFFFE57F)],
              stops: [0.2, 1.0],
            ),
          ),
        ),
        title: const Text('Find a gif!'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            SearchField(onSearch: _findGif),
            Expanded(
                child: SizedBox(
              height: 500,
              width: 400,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    mainAxisExtent: 200),
                itemBuilder: (_, i) => GifCard(
                  gif: data[i],
                  onTap: () {
                    print('');
                  },
                ),
                itemCount: data.length,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchData() async {
    final result = await _interactor.getGifs('cats');
    setState(() => data = result);
  }

  void _findGif(String gifName) async {
    setState(() async {
      data = await _interactor.getGifs(gifName);
    });
  }
}
