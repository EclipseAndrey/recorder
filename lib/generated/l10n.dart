// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `MemoryBox`
  String get app_name {
    return Intl.message(
      'MemoryBox',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Твой голос всегда рядом`
  String get slogan {
    return Intl.message(
      'Твой голос всегда рядом',
      name: 'slogan',
      desc: '',
      args: [],
    );
  }

  /// `Мы рады тебя видеть`
  String get hello_old {
    return Intl.message(
      'Мы рады тебя видеть',
      name: 'hello_old',
      desc: '',
      args: [],
    );
  }

  /// `Привет!`
  String get hello_new1 {
    return Intl.message(
      'Привет!',
      name: 'hello_new1',
      desc: '',
      args: [],
    );
  }

  /// `Мы рады видеть тебя здесь.\nЭто приложение поможет записывать \nсказки и держать их в удобном месте\n не заполняя память на телефоне`
  String get hello_new2 {
    return Intl.message(
      'Мы рады видеть тебя здесь.\nЭто приложение поможет записывать \nсказки и держать их в удобном месте\n не заполняя память на телефоне',
      name: 'hello_new2',
      desc: '',
      args: [],
    );
  }

  /// `Взрослые иногда нуждаются \nв сказке даже больше, чем дети`
  String get hello_old_desc {
    return Intl.message(
      'Взрослые иногда нуждаются \nв сказке даже больше, чем дети',
      name: 'hello_old_desc',
      desc: '',
      args: [],
    );
  }

  /// `Продолжить`
  String get btn_next {
    return Intl.message(
      'Продолжить',
      name: 'btn_next',
      desc: '',
      args: [],
    );
  }

  /// `Привет!`
  String get hello {
    return Intl.message(
      'Привет!',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Регистрация привяжет твои сказки \n к облаку, после чего они всегда\n будут с тобой`
  String get desc_register {
    return Intl.message(
      'Регистрация привяжет твои сказки \n к облаку, после чего они всегда\n будут с тобой',
      name: 'desc_register',
      desc: '',
      args: [],
    );
  }

  /// `Позже`
  String get later {
    return Intl.message(
      'Позже',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Введите номер телефона`
  String get enter_num {
    return Intl.message(
      'Введите номер телефона',
      name: 'enter_num',
      desc: '',
      args: [],
    );
  }

  /// `Введи код из смс, чтобы \nмы тебя запомнили`
  String get enter_code {
    return Intl.message(
      'Введи код из смс, чтобы \nмы тебя запомнили',
      name: 'enter_code',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}