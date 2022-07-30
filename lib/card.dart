import 'package:flutter/material.dart';
import 'package:my_animation_app/animations/size_transition.dart';

class MyCard extends StatefulWidget {
  final bandImage;
  final bandTitle;
  final List<String> bandGallery;

  MyCard(
      {required this.bandImage,
      required this.bandTitle,
      required this.bandGallery});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> with SingleTickerProviderStateMixin {
  bool isShown = false;
  late AnimationController controller;
  late Animation animation;
  int _currIndex = 0;

  @override
  Widget build(BuildContext context) {
    final titleRow = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.bandTitle),
          IconButton(
            icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (child, anim) => RotationTransition(
                      turns: child.key == ValueKey('icon1')
                          ? Tween<double>(begin: 0.5, end: 1).animate(anim)
                          : Tween<double>(begin: 1, end: 0.5).animate(anim),
                      child: ScaleTransition(scale: anim, child: child),
                    ),
                child: _currIndex == 0
                    ? Icon(Icons.arrow_downward_rounded, key: const ValueKey('icon1'))
                    : Icon(
                        Icons.arrow_downward_rounded,
                        key: const ValueKey('icon2'),
                      )),
            onPressed: () {
              setState(() {
                _currIndex = _currIndex == 0 ? 1 : 0;
                isShown = !isShown;
              });
            },
          )
        ]);
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleRow,
          isShown
              ? Hero(
                  tag: 'band hero',
                  child: SizeTransitionList(
                    bandImage: widget.bandImage,
                    bandTitle: widget.bandTitle,
                    bandGallery: widget.bandGallery,
                  ))
              : const SizedBox()
        ],
      ),
    ));
  }
}
