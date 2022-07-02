import 'package:flutter/material.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/widgets/default_appbar.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defultAppBar(title: 'Privacy Policy'),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
          child: SingleChildScrollView(
            child: Text(
              'What is a privacy policy? A privacy policy is a legal document where you disclose what data you collect from users, how you manage the collected data and how you use that data. The important objective of a privacy policy is to inform users how you collect, use and manage the collected.Is the privacy policy generator free to use?The Privacy Policy Generator (privacypolicygenerator.info) is a free generator of privacy policies for websites, apps & Facebook pages/app. You can use our free generator to create the privacy policy for your business.Why is a privacy policy important?The most important thing to remember is that a privacy policy is required by law if you collect data from users, either directly or indirectly. For example, if you have a contact form on your website you need a privacy policy. But you will also need a privacy policy if you use analytics tools such as Google Analytics. Where do I put my privacy policy?',
              style: StyleManager.primaryTextStyle(
                  fontSize: FontSize.s18,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManager.white),
            ),
          )),
    );
  }
}
