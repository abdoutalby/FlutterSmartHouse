import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:smarthouse/main.dart';

import '../views/Login.dart';
import '../views/home.dart';

class AuthController extends GetxController {
    TextEditingController email = new TextEditingController();
    TextEditingController password = new TextEditingController();
     RxBool isLoading = false.obs;

    Future<void> Login() async{
      isLoading.value= true;
      try{
        var headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};
        var url = Uri.parse('http://15.235.140.225:8080/api/auth/login');
        Map body = {
          "email": email.text,
          "password" : password.text
        };

        http.Response response = await http.post(url,body:jsonEncode( body),headers: headers);
        if(response.statusCode == 200){
          isLoading.value= false;
              Get.to(MyHome()
          );
        }else {
          isLoading.value= false;
          throw jsonDecode( response.body);
        }
      }catch(e){
        isLoading.value= false;
        Get.back();
        showDialog(
          context: Get.context!,
          builder: (context){
            return SimpleDialog(title: Text("Error ")
            ,  contentPadding: EdgeInsets.all(20),
            children: [
                Text("wrong credentials"),
            ],
            );
          }
        );
      }
    }
}