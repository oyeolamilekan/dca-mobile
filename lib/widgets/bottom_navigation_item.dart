import 'package:flutter/material.dart';

class BottomNavigationItem extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final bool active;
  final int? index;

  const BottomNavigationItem({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.active,
    this.index,
  }) : super(key: key);

  Color? getCurrentStyle(int? index, BuildContext context) {
    final Color middleIndicatorStyle = active
        ? Theme.of(context).canvasColor
        : Theme.of(context).iconTheme.color!.withOpacity(0.5);

    final Color? iconThemeIndicatorStyle = active
        ? Theme.of(context).iconTheme.color
        : Theme.of(context).iconTheme.color!.withOpacity(0.5);

    return iconThemeIndicatorStyle;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: active && index == 1
                ? Theme.of(context).cardColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            color: getCurrentStyle(index, context),
            size: 20,
          ),
        ),
      ),
    );
  }
}
