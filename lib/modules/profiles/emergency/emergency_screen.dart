import 'package:flutter/material.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:moody_app/widgets/default_appbar.dart';
import 'package:moody_app/widgets/default_text_button.dart';
import 'package:moody_app/widgets/default_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmergencyScreen extends StatelessWidget {
  EmergencyScreen({Key? key}) : super(key: key);
  final List<TextEditingController> controllersNumbers = [
    TextEditingController(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defultAppBar(title: 'Emergency'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Column(
            children: [
              Text(
                'You can add your friends phone numbers here to remember them in emergency cases',
                style: StyleManager.primaryTextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManager.black,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ...List.generate(
                controllersNumbers.length,
                (index) {
                  if (controllersNumbers.length - 1 != index) {
                    return DefaultTextField(
                        hintText: 'Friend phone number',
                        controller: controllersNumbers[index]);
                  }
                  return Row(
                    children: [
                      IconButton(
                          onPressed: () 
                          {
                            controllersNumbers.add(TextEditingController());
                          },
                          icon: Icon(
                            Icons.add,
                            size: 25.sp,
                          )),
                      DefaultTextField(
                          hintText: 'Friend phone number',
                          controller: controllersNumbers[index]),
                    ],
                  );
                },
              ),
              Column(
                children: controllersNumbers
                    .map(
                      (e) => DefaultTextField(
                          hintText: 'Friend phone number', controller: e),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 20.h,
              ),
              DefaultTextButton(
                  onPressed: () {},
                  colorButton: ColorManager.successColor,
                  title: 'Save'),
            ],
          ),
        ),
      ),
    );
  }
}
