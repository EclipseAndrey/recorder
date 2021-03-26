import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:recorder/UI/General.dart';
import 'package:recorder/Utils/app_keys.dart';

class LoginController {
  PageController controllerPages = PageController(initialPage: 0);

  var maskFormatter = new MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
  var maskFormatterCode = new MaskTextInputFormatter(
      mask: '# # # #', filter: {"#": RegExp(r'[0-9]')});
  TextEditingController controllerNum = TextEditingController();
  TextEditingController controllerCode = TextEditingController();

  stepOneTap() {
    controllerPages.animateToPage(1,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  stepTwoTap() {
    controllerPages.animateToPage(2,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
    getCode();
  }

  stepThreeTap() async {
    controllerPages.animateToPage(3,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
    checkCode();
    await Future.delayed(Duration(milliseconds: 700));
    pushHome();
  }

  transitionToHome() async {
    await Future.delayed(Duration(seconds: 2, milliseconds: 500));
    pushHome();
  }

  getCode() async {}

  checkCode() async {}

  pushHome() {
    Navigator.pushReplacement(AppKeys.scaffoldKey.currentContext, routeHome());
  }

  Route routeHome() {
    var curve = Curves.ease;
    var curveTween = CurveTween(curve: curve);

    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 2500),
      pageBuilder: (context, animation, secondaryAnimation) => General(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
          reverseCurve: curve,
        );
        return SlideTransition(
          // position: offsetAnimation,
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}
