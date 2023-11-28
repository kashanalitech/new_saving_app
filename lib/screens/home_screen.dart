import 'package:flutter/material.dart';


import '../components/barrel_image.dart';
import '../components/custom_button.dart';
import '../constants/custom_text_styles.dart';
import '../constants/helper.dart';
import '../constants/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                      title: 'Create New Saving Sheet',
                      ontap: () {
                        // Navigator.pushNamed(context, RouteNames.createsheet);
                      },
                    ),
                    CustomButton(
                      width: Helper.getWidth(context),
                      horizontalpadding: 20,
                      verticalpadding: 20,
                      title: 'View All Savings Sheet',
                      ontap: () {
                        // Navigator.pushNamed(context, RouteNames.viewsheets);
                      },
                    ),
                    CustomButton(
                      width: Helper.getWidth(context),
                      verticalpadding: 20,
                      title: 'Notes',
                      ontap: () {
                        // Navigator.pushNamed(context, RouteNames.settingmenu);
                      },
                    ),
                    CustomButton(
                      icon: const Icon(Icons.square_outlined),
                      width: Helper.getWidth(context),
                      verticalpadding: 20,
                      title: 'Learn More',
                      ontap: () {
                        // Navigator.pushNamed(context, RouteNames.setting);
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
