import 'package:awesome_page_transitions/awesome_page_transitions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivational_app/constants.dart';
import 'package:motivational_app/screens/welcome_screen2.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'welcome_screen2.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BounceInRight(
            child: Image.asset(
              'assets/welcome1.png',
            ),
          ),
          FadeInLeft(
            child: SizedBox(
              width: 280,
              child: Text(
                'Welcome to Motivational Quotes',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  decoration: TextDecoration.none,
                  fontFamily: kfont,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          SlitInDiagonal(
            child: Text(
              'Together We Can Change The World!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w600,
                fontFamily: kfont,
              ),
            ),
          ),
          RollIn(
            child: CircleAvatar(
              child: IconButton(
                icon: Icon(
                  Icons.chevron_right_outlined,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      AwesomePageRoute(
                        transitionDuration: Duration(milliseconds: 600),
                        exitPage: widget,
                        enterPage: WelcomeScreenS(),
                        transition: AccordionTransition(),
                      ));
                },
              ),
              radius: 30,
            ),
          ),
          SizedBox()
        ],
      ),
    );
  }
}
