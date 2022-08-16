// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sumry_app/utilis/designs/colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.menu,
                        color: kPrimaryColor,
                        size: 36,
                      )),
                  Spacer(),
                  SizedBox(
                    height: 36,
                    width: 114,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        primary: kButtonColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Register",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text(
                "About",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
              Text(
                "Summryman",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "SumryMan is a text summarization app with support for input from differnet sources(eg. url(website), text input, file upload(support msdocs, text files(.text) and docx files).",
                style: TextStyle(
                  color: Color(0xFF4F4F4F),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 90),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  height: 228,
                  width: 156,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/about_img.png"),
                        fit: BoxFit.contain),
                  ),
                )
              ]),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "@2022 ZummitAfrica Inc.",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
