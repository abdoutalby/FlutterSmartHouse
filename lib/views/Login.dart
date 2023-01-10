
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../utils/consts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controllers
  AuthController controller = Get.put( AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // SvgPicture.asset(
              //   'login.svg',
              //   height: 200,
              // ),
              const SizedBox(
                height: 65,
              ),
              Text(
                "Login ",
                style: TextStyle(fontSize: 30 , fontWeight:FontWeight.bold,  ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: controller.email,
                      decoration: InputDecoration(
                        prefix: const Icon(Icons.person),
                        prefixIconColor: AppColors.TEXT_COLOR,
                        hintText: "Email",
                        fillColor: AppColors.PRIMARY_COLOR,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: AppColors.SECONDARY_COLOR),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                            BorderSide(color: AppColors.TEXT_COLOR)),
                        filled: true,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                        controller:controller.password,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefix: Icon(Icons.lock),
                            fillColor: AppColors.PRIMARY_COLOR,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.SECONDARY_COLOR),
                                borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                BorderSide(color: AppColors.TEXT_COLOR)),
                            filled: true,
                            hintText: 'Password')),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child: Obx(
                            () => controller.isLoading.value ?

                             Center(
                                child
                                    :  CircularProgressIndicator(),
                              )

                                :

                                OutlinedButton(
                          onPressed: (){ controller.Login();},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.ACCENT_COLOR)),
                          child: Center(
                            child
                                : Text(
                              "sign in",
                              style: TextStyle(color: AppColors.WHITE),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 25,
              ),

            ]),
          ),
        ),
      ),
    );
  }
}