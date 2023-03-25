import 'package:flutter/material.dart';

import '../../../../../helpers/snackbar_helper.dart';

class BaseMobileSnackbar extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final Color progressBarColor;
  final Color textColor;
  final IconData icon;
  final Duration duration;

  const BaseMobileSnackbar({
    super.key,
    required this.message,
    required this.backgroundColor,
    required this.progressBarColor,
    required this.textColor,
    required this.icon,
    required this.duration,
  });

  @override
  State<BaseMobileSnackbar> createState() => _BaseMobileSnackbarState();
}

class _BaseMobileSnackbarState extends State<BaseMobileSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _stopTween;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration + const Duration(milliseconds: 400),
    );
    _stopTween = Tween<double>(begin: 1, end: 0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.hideSnackbar,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(widget.icon, color: widget.textColor),
                    const SizedBox(width: 8),
                    Text(
                      widget.message,
                      style: TextStyle(
                        color: widget.textColor,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => Container(
                  height: 5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [_stopTween.value, _stopTween.value],
                      colors: [widget.progressBarColor, widget.backgroundColor],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
