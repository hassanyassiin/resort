import 'package:flutter/material.dart';

import '../../../Global/Animated_Widgets/Animated_Loading_Widgets.dart';

class Animated_Color_Tween extends StatefulWidget {
  final Color end_color;
  final Color begin_color;
  final int duration_in_second;
  final String loading_widget_name;

  const Animated_Color_Tween({
    required this.end_color,
    required this.begin_color,
    required this.duration_in_second,
    required this.loading_widget_name,
    super.key,
  });

  @override
  State<Animated_Color_Tween> createState() => _Animated_Color_TweenState();
}

class _Animated_Color_TweenState extends State<Animated_Color_Tween>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> color_animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: widget.duration_in_second),
      vsync: this,
    );

    color_animation = ColorTween(
      begin: widget.begin_color,
      end: widget.end_color,
    ).animate(controller);

    // This means that when the animation begin and then end, to repeat th
    // e tween color in a loop, and the reverse true mean when it ends to begin from the end color to the begin color.
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Switch_Animated_Loading_Widgets(
          animation: color_animation,
          loading_widget_name: widget.loading_widget_name,
        );
      },
    );
  }
}
