import 'package:flutter/material.dart';

class BlinkingWidget extends StatefulWidget {
  final Widget child;
  const BlinkingWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  _BlinkingWidgetState createState() => _BlinkingWidgetState();
}

class _BlinkingWidgetState extends State<BlinkingWidget>
    with SingleTickerProviderStateMixin {
  Animation<int>? animation;
  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    final curve = CurvedAnimation(parent: controller!, curve: Curves.easeInOut);
    animation = IntTween(begin: 0, end: 1).animate(curve);
    animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller!.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller!.forward();
      }
      setState(() {});
    });
    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation!,
        builder: (BuildContext context, Widget? child) {
          return Container(
            child: Opacity(
              opacity: animation!.value == 0 ? 0 : 1,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }

  dispose() {
    controller!.dispose();
    super.dispose();
  }
}
