import 'dart:convert';
import 'package:awesome_page_transitions/awesome_page_transitions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/widgets/specials/roll_in.dart';
import 'package:motivational_app/constants.dart';
import 'package:motivational_app/screens/home_screen.dart';
import 'package:http/http.dart' as http;

class WelcomeScreenS extends StatefulWidget {
  const WelcomeScreenS({Key? key}) : super(key: key);

  @override
  _WelcomeScreenSState createState() => _WelcomeScreenSState();
}

List attributes = [
  RichText(
    text: TextSpan(
      style: kWelcomeScreenAttribute,
      children: [
        TextSpan(text: 'Reduce '),
        TextSpan(
          text: 'Stress',
          style: kWelcomeScreenAttributeUnder,
        ),
      ],
    ),
  ),
  RichText(
    text: TextSpan(
      style: kWelcomeScreenAttribute,
      children: [
        TextSpan(text: 'Increase '),
        TextSpan(
          text: 'happiness',
          style: kWelcomeScreenAttributeUnder,
        ),
      ],
    ),
  ),
  RichText(
    text: TextSpan(
      style: kWelcomeScreenAttribute,
      children: [
        TextSpan(text: 'Improve '),
        TextSpan(
          text: 'relationships',
          style: kWelcomeScreenAttributeUnder,
        ),
      ],
    ),
  ),
  RichText(
    text: TextSpan(
      style: kWelcomeScreenAttribute,
      children: [
        TextSpan(text: 'Achieve '),
        TextSpan(
          text: 'goals',
          style: kWelcomeScreenAttributeUnder,
        ),
      ],
    ),
  ),
  RichText(
    text: TextSpan(
      style: kWelcomeScreenAttribute,
      children: [
        TextSpan(text: 'Improve '),
        TextSpan(
          text: 'health',
          style: kWelcomeScreenAttributeUnder,
        ),
      ],
    ),
  ),
];

class _WelcomeScreenSState extends State<WelcomeScreenS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BounceInDown(
            child: Image.asset(
              'assets/welcome2.png',
            ),
          ),
          Column(
            children: [
              Flip(
                child: SizedBox(
                  width: 250,
                  child: Text(
                    'NOW',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      fontFamily: kfont,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // for (var i in attributes)
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: Column(
                    children: [
                      SlideInRight(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: RichText(
                            text: TextSpan(
                              style: kWelcomeScreenAttribute,
                              children: [
                                TextSpan(text: 'Reduce '),
                                TextSpan(
                                  text: 'Stress',
                                  style: kWelcomeScreenAttributeUnder,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SlideInLeft(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: RichText(
                            text: TextSpan(
                              style: kWelcomeScreenAttribute,
                              children: [
                                TextSpan(text: 'Increase '),
                                TextSpan(
                                  text: 'happyness',
                                  style: kWelcomeScreenAttributeUnder,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SlideInRight(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: RichText(
                            text: TextSpan(
                              style: kWelcomeScreenAttribute,
                              children: [
                                TextSpan(text: 'Improve '),
                                TextSpan(
                                  text: 'relationships',
                                  style: kWelcomeScreenAttributeUnder,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SlideInLeft(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: RichText(
                            text: TextSpan(
                              style: kWelcomeScreenAttribute,
                              children: [
                                TextSpan(text: 'Achieve '),
                                TextSpan(
                                  text: 'goals',
                                  style: kWelcomeScreenAttributeUnder,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SlideInRight(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: RichText(
                            text: TextSpan(
                              style: kWelcomeScreenAttribute,
                              children: [
                                TextSpan(text: 'Improve '),
                                TextSpan(
                                  text: 'health',
                                  style: kWelcomeScreenAttributeUnder,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          RollIn(
            child: CircleAvatar(
              child: IconButton(
                icon: Icon(
                  Icons.chevron_right_outlined,
                  size: 30,
                ),
                onPressed: () async {
                  await Firebase.initializeApp();
                  await getData();
                  Navigator.push(
                      context,
                      AwesomePageRoute(
                        transitionDuration: Duration(milliseconds: 600),
                        exitPage: widget,
                        enterPage: HomeScreen(),
                        transition: DepthTransition(),
                      ));
                },
              ),
              radius: 30,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getData() async {
    http.Response qod_link = await http.get(
      Uri.parse('https://www.quotepub.com/api/widget/?type=qotd_t'),
    );
    String data = qod_link.body;
    qod = jsonDecode(data)["quote_body"];
    author1 = jsonDecode(data)["quote_author"];
    return qod;
  }
}
