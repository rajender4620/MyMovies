// ignore_for_file: use_named_constants

import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder<void> {
  CustomPageRoute({required this.page, this.side})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Offset beginOffset;
            Offset endOffset;
            switch (side) {
              case 'left':
                beginOffset = const Offset(-1, 0);
                endOffset = const Offset(0, 0);
              case 'right':
                beginOffset = const Offset(1, 0);
                endOffset = const Offset(0, 0);
              case 'top':
                beginOffset = const Offset(0, -1);
                endOffset = const Offset(0, 0);
              case 'bottom':
                beginOffset = const Offset(0, 1);
                endOffset = const Offset(0, 0);
              default:
                beginOffset = const Offset(0, 0);
                endOffset = const Offset(0, 0);
            }

            const curve = Curves.ease;
            final tween = Tween(begin: beginOffset, end: endOffset)
                .chain(CurveTween(curve: curve));
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
  final Widget page;
  final String? side;
}
