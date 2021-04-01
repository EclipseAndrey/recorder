import 'package:flutter/material.dart';
import 'package:recorder/Routes.dart';
import 'package:recorder/Utils/app_keys.dart';
import 'package:recorder/Utils/tokenDB.dart';

class ProfileController{
  comeOut()async{
    print('ProfileController => Out');
    Navigator.pushReplacementNamed(AppKeys.scaffoldKey.currentContext, Routes.welcomeNew);
    await tokenDB(token: "null");
  }

  editProfile(){}
  closeEdit(){}
  closeAndSaveEdit(){}


}