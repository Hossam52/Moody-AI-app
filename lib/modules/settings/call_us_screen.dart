import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/presentation/resources/strings_manager.dart';

class CallUsScreen extends StatelessWidget {
  const CallUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call us'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 0.1.sh),
              Image.asset(
                'assets/images/emotions.png',
                width: 0.7.sw,
                height: 0.2.sh,
                fit: BoxFit.fill,
              ),
              Text(
                StringsManager.callusMessage,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp),
              ),
              const SizedBox(height: 30),
              _buildListTile(
                  Icons.email_outlined, 'hossam.hassan.fcis@gmail.com'),
              _buildListTile(Icons.phone_android, '+201115425561'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(IconData iconData, String text) {
    return ListTile(
      minLeadingWidth: 0,
      leading: Icon(
        iconData,
        color: Colors.grey,
      ),
      title: Text(
        text,
        style: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18.sp),
      ),
    );
  }
}
