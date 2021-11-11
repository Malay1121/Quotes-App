import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivational_app/constants.dart';
import 'package:motivational_app/screens/create_quote.dart';
import 'package:motivational_app/screens/downloads.dart';
import 'package:motivational_app/screens/home_screen.dart';
import 'package:motivational_app/screens/liked_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerMenu extends StatelessWidget {
  final _advancedDrawerController = AdvancedDrawerController();

  final String appbarText;
  final Widget body;

  DrawerMenu({Key? key, required this.body, required this.appbarText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.deepOrange,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 24.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/dp.png',
                ),
              ),
              Text(
                'Welcome %Username%!',
                style: TextStyle(
                  fontFamily: kfont,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                  border: Border.all(width: 0.3, color: Colors.indigo),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Login/Logout',
                    style: TextStyle(
                      fontFamily: kfont,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrangeAccent.shade400,
                    ),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.width - 70,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Quotes',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: kfont,
                        ),
                      ),
                    ),
                    DrawerOptions(
                      messages: '21',
                      text: 'Home',
                      icon: Icons.home,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                    ),
                    DrawerOptions(
                      messages: '46',
                      text: 'Quotes',
                      icon: Icons.format_quote_sharp,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                    ),
                    DrawerOptions(
                      messages: '6',
                      text: 'Liked',
                      icon: FontAwesomeIcons.solidHeart,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LikedScreen()));
                      },
                    ),
                    DrawerOptions(
                      messages: '2',
                      text: 'Downloads',
                      icon: FontAwesomeIcons.solidHeart,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DownloadedScreen()));
                      },
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.7,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: kfont,
                        ),
                      ),
                    ),
                    DrawerOptions(
                      messages: '',
                      text: 'Recent Notifications',
                      icon: Icons.message,
                      onTap: () {},
                    ),
                    DrawerOptions(
                      messages: '',
                      text: 'Daily Reminders',
                      icon: Icons.notifications_none,
                      onTap: () {},
                    ),
                    DrawerOptions(
                      messages: '',
                      text: 'Quote Quality',
                      icon: Icons.image_outlined,
                      onTap: () {},
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.7,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Socials',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: kfont,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShakeAnimatedWidget(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await launch(
                                  'http://www.instagram.com/insta_motivational_thoughts');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.indigo.shade400,
                                    Colors.purple.shade400
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 1.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(FontAwesomeIcons.instagram,
                                    size: 30, color: Colors.white),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await launch(
                                  'https://www.facebook.com/DailyMotivationalThoughtsfb');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.indigo, Colors.blue],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(FontAwesomeIcons.facebookF,
                                    size: 30, color: Colors.white),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await launch(
                                  'https://t.me/joinchat/PgvOTjoeXYI4YTU1');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.cyan, Colors.lightBlue],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(FontAwesomeIcons.telegramPlane,
                                    size: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appbarText),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateQuote()));
              },
            )
          ],
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: body,
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  // Future<Void> Chrome

}
