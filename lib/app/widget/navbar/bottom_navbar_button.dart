import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';

class IconBottomNavbarButton extends StatefulWidget {
  final IconData icon;
  final double? iconSize;
  final Color? activeColor;
  final Color? color;
  final bool? isActivate;
  final void Function() onPressed;

  const IconBottomNavbarButton({
    super.key,
    required this.icon,
    this.iconSize = 16,
    this.activeColor = AppColors.green,
    this.color = AppColors.darkGrey,
    required this.onPressed,
    this.isActivate = false,
  });

  @override
  State<IconBottomNavbarButton> createState() => _IconBottomNavbarButtonState();
}

class _IconBottomNavbarButtonState extends State<IconBottomNavbarButton> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    isVisible = widget.isActivate!;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            isVisible = widget.isActivate!;
          });
        });
        widget.onPressed();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            color: widget.isActivate! ? widget.activeColor : widget.color,
            size: widget.iconSize,
          )
              .animate(
                target: widget.isActivate! ? 1 : 0,
                onPlay: (controller) =>
                    controller.loop(count: 1, reverse: true),
              )
              .scaleXY(
                end: 1.2,
                curve: Curves.easeInOutCubic,
              ),
          AnimatedOpacity(
            opacity: widget.isActivate! ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: AnimatedContainer(
              margin:
                  EdgeInsets.only(top: widget.isActivate! ? 10 : 0, left: 2),
              duration: const Duration(milliseconds: 300),
              width: widget.isActivate! ? 20 : 5,
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: widget.activeColor),
            ).animate(target: widget.isActivate! ? 1 : 0).fade(
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                ),
          )
        ],
      ),
    );
  }
}
