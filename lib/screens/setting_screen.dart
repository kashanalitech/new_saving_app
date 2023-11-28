import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../constants/custom_text_styles.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String selectedFormat = 'YYYY - MM - DD';
  bool useSwitch = false;

  void handleRadioValueChange(String? value) {
    setState(() {
      selectedFormat = value!;
    });
  }
  void handleSwitchValueChange(bool value) {
    setState(() {
      useSwitch = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Setting',
          style: CustomTextStyle.largeBlack(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RadioListTile(
            title: Text(
              'YYYY - MM - DD',
              style: CustomTextStyle.mediumBlack(context),
            ),
            value: 'YYYY - MM - DD',
            groupValue: selectedFormat,
            onChanged: handleRadioValueChange,
          ),
          RadioListTile(
            title: Text(
              'YYYY - DD - MM',
              style: CustomTextStyle.mediumBlack(context),
            ),
            value: 'YYYY - DD - MM',
            groupValue: selectedFormat,
            onChanged: handleRadioValueChange,
          ),
          RadioListTile(
            title: Text(
              'DD - MM - YYYY',
              style: CustomTextStyle.mediumBlack(context),
            ),
            value: 'DD - MM - YYYY',
            groupValue: selectedFormat,
            onChanged: handleRadioValueChange,
          ),
          RadioListTile(
            title: Text(
              'MM - DD - YYYY',
              style: CustomTextStyle.mediumBlack(context),
            ),
            value: 'MM - DD - YYYY',
            groupValue: selectedFormat,
            onChanged: handleRadioValueChange,
          ),
          SizedBox(height: 16.0),
          // Text('Selected Format: $selectedFormat',
          //     style: TextStyle(fontSize: 20.0)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Row(
              children: <Widget>[
                Text('24 Hours Time',style: CustomTextStyle.largegrey(context),),
                FlutterSwitch(
                  height: 25,
                  width: 45,
                  padding: 2.0,
                  toggleSize: 15.0,
                  borderRadius: 22.0,
                  activeColor: Colors.white,
                  inactiveColor: Colors.white,
                  toggleColor: Colors.blue,
                  activeSwitchBorder: Border.all(color: Colors.blue),
                  inactiveSwitchBorder: Border.all(color: Colors.blue),
                  activeToggleColor: Colors.blue,
                  value: useSwitch,
                  onToggle: handleSwitchValueChange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
