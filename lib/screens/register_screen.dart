import 'package:flutter/material.dart';

import '../components/barrel_image.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';
import '../constants/helper.dart';
import '../constants/routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 60, bottom: 30),
                    child: BarrelImage(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        const customField(),
                        const customField(),
                        CustomButton(
                          width: Helper.getWidth(context),
                          horizontalpadding: 20,
                          verticalpadding: 17,
                          title: 'Sign In',
                          icon: const Icon(Icons.login, size: 35),
                          ontap: () {
                            Navigator.pushNamed(context, RouteNames.home);
                          },
                        ),
                        CustomButton(
                          width: Helper.getWidth(context),
                          horizontalpadding: 20,
                          verticalpadding: 17,
                          title: 'Forgot Password',
                          icon: const Icon(Icons.square_outlined, size: 35),
                          ontap: () {
                            Navigator.pushNamed(context, RouteNames.register);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

