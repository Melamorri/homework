import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:my_animation_app/bands_repository.dart';
import '../picture_screen.dart';

class SizeTransitionList extends StatefulWidget {
  final bandImage;
  final bandTitle;
  final List<String> bandGallery;

  SizeTransitionList({
    required this.bandImage,
    required this.bandTitle,
    required this.bandGallery
  });

  @override
  State<SizeTransitionList> createState() => _SizeTransitionListState();
}

class _SizeTransitionListState extends State<SizeTransitionList>
    with TickerProviderStateMixin {
  int index = 0;
  bool isShown = false;
  late AnimationController _controller;
  late Animation<Offset> _animation;
  final bandsRepository = BandsRepository();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
    _animation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        transformHitTests: true,
        position: _animation,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Card(
            child: Image.network(widget.bandImage),
          ),
          DelayedDisplay(delay: Duration(seconds: 4),child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PictureScreen(widget.bandGallery, heroTag: 'band hero', bandTitle: widget.bandTitle, ),
                ),
              );
            },
            child: Text('Show more'),
          ),
          )
        ]));
  }
}
