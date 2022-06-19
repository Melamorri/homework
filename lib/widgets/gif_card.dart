import 'package:flutter/material.dart';

import '../gif_model.dart';

class GifCard extends StatelessWidget {
  final void Function() onTap;
  final Gif gif;

  const GifCard({
    Key? key,
    required this.onTap,
    required this.gif,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(gif.image),
          ],
        ),
      ),
    );
  }
}
