import 'package:flutter/material.dart';

import '../components/barrel_image.dart';
import '../components/custom_button.dart';
import '../constants/helper.dart';
import '../constants/routes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: BarrelImage(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    CustomButton(
                      width: Helper.getWidth(context),
                      horizontalpadding: 20,
                      verticalpadding: 20,
                      title: 'User Login',
                      ontap: () {
                        Navigator.pushNamed(context, RouteNames.login);
                      },
                    ),
                    CustomButton(
                      width: Helper.getWidth(context),
                      horizontalpadding: 20,
                      verticalpadding: 20,
                      title: 'Register',
                      icon: const Icon(Icons.square_outlined),
                      ontap: () {
                        Navigator.pushNamed(context, RouteNames.register);
                      },
                    ),
                    CustomButton(
                      width: Helper.getWidth(context),
                      verticalpadding: 20,
                      title: 'Offline Mode',
                      ontap: () {
                        Navigator.pushNamed(context, RouteNames.notes);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
