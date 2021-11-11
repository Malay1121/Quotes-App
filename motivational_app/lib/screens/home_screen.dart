import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:blur/blur.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:motivational_app/constants.dart';
import 'package:motivational_app/drawer_menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:convert';

var qod;
var author1;

final CarouselController _controller = CarouselController();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Future<void> getQuotes() async {
  //   final quoteList = await _firestore.collection('quotes').get();
  //   for (var quotes in quoteList.docs) {
  //     print(quotes);
  //   }
  // }

  final _firestore = FirebaseFirestore.instance;

  void getData() async {
    http.Response qod_link = await http.get(
      Uri.parse('https://www.quotepub.com/api/widget/?type=qotd_t'),
    );
    String data = qod_link.body;
    qod = jsonDecode(data)["quote_body"];
    author1 = jsonDecode(data)["quote_author"];
    return qod;
  }

  @override
  void initState() {
    // TODO: implement initState

    Firebase.initializeApp();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return DrawerMenu(
      appbarText: 'Quotes',
      body: SlidingUpPanel(
        renderPanelSheet: false,
        panel: _floatingPanel(),
        collapsed: _floatingCollapsed(),
        body: SingleChildScrollView(
          child: CarouselSlider(
            items: [
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _firestore.collection('quotes').snapshots(),
                builder: (context, snapshot) {
                  List<Widget> quoteWidgets = [];
                  if (snapshot.hasData) {
                    final quotes = snapshot.data!.docs;

                    for (var quote in quotes) {
                      final quoteText = quote.data()['quote'];
                      final quoteBy = quote.data()['by'];
                      final quoteWidget = QuoteCard(
                        color1: Colors.teal,
                        color2: Colors.orange,
                        quote: quoteText,
                        author: quoteBy,
                      );
                      quoteWidgets.add(quoteWidget);
                    }
                  }
                  return CarouselSlider(
                    items: quoteWidgets,
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      height:
                          MediaQuery.of(context).size.height - kToolbarHeight,
                      viewportFraction: 1.0,
                      scrollDirection: Axis.vertical,
                    ),
                    carouselController: _controller,
                  );
                },
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _firestore.collection('images').snapshots(),
                builder: (context, snapshot) {
                  List<Widget> quoteWidgets = [];
                  if (snapshot.hasData) {
                    final quotes = snapshot.data!.docs;

                    for (var quote in quotes) {
                      final quoteImage = quote.data()['image'];
                      final quoteWidget = ImageCard(
                        image: quoteImage,
                      );
                      quoteWidgets.add(quoteWidget);
                    }
                  }
                  return CarouselSlider(
                    items: quoteWidgets,
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      height:
                          MediaQuery.of(context).size.height - kToolbarHeight,
                      viewportFraction: 1.0,
                      scrollDirection: Axis.vertical,
                    ),
                    carouselController: _controller,
                  );
                },
              ),
            ],
            options: CarouselOptions(
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              viewportFraction: 1.0,
              scrollDirection: Axis.horizontal,
            ),
            carouselController: _controller,
          ),
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String image;

  const ImageCard({required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.yellow.shade800,
            ),
            child: Center(
              child: SizedBox(
                height:
                    MediaQuery.of(context).size.height - kToolbarHeight - 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(image),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 1,
          bottom: 55,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EngagementButton(
                icon: FontAwesomeIcons.heart,
                onTap: () {},
              ),
              EngagementButton(
                icon: Icons.copy_outlined,
                onTap: () {},
              ),
              EngagementButton(
                icon: Icons.download_outlined,
                onTap: () {},
              ),
              EngagementButton(
                icon: Icons.share,
                onTap: () {},
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          left: 0.1,
          child: SizedBox(
            width: 90,
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.blue],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(15)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.chevron_left_rounded,
                      size: 25,
                      color: Colors.white,
                    ),
                    Text(
                      'Quotes',
                      style: TextStyle(
                        fontFamily: kfont,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class QuoteCard extends StatelessWidget {
  final String quote;
  final Color color1;
  final Color color2;
  final String author;

  const QuoteCard(
      {required this.quote,
      required this.color1,
      required this.color2,
      required this.author});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),

            // border: Border.all(width: 0.2),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.green],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: JackInTheBox(
                    child: Text(
                      quote,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: kquoteFont,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                RotateInUpRight(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(
                      '- ' + author,
                      style: TextStyle(
                          fontSize: 13, color: Colors.white, fontFamily: kfont),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 1,
          bottom: 55,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EngagementButton(
                icon: FontAwesomeIcons.heart,
                onTap: () {},
              ),
              EngagementButton(
                icon: Icons.copy_outlined,
                onTap: () {},
              ),
              EngagementButton(
                icon: Icons.download_outlined,
                onTap: () {},
              ),
              EngagementButton(
                icon: Icons.share,
                onTap: () {},
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          right: 0.1,
          child: SizedBox(
            width: 90,
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.blue],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Images',
                      style: TextStyle(
                        fontFamily: kfont,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 25,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 1,
          right: 1,
          child: Column(
            children: [
              Text(
                'Quote Of The Day :-',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: kfont,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 3,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 0.7,
                      color: Colors.orange,
                    ),
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                child: HeartBeat(
                  child: ExpandableText(
                    elevation: 5,
                    padding: EdgeInsets.all(10.0),
                    animationDuration: Duration(milliseconds: 250),
                    textWidget: Text(
                      qod,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: kquoteFont,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    showArrowIcon: true,
                    initiallyExpanded: false,
                    hoverOn: false,
                    arrowLocation: ArrowLocation.right,
                    finalArrowLocation: ArrowLocation.bottom,
                    backGroundColor: Colors.transparent,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '- $author1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: kfont,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EngagementButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const EngagementButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          top: 12.0,
          bottom: 12.0,
          left: 8,
          right: 8,
        ),
        child: ShakeAnimatedWidget(
          enabled: true,
          duration: Duration(milliseconds: 1500),
          shakeAngle: Rotation.deg(z: 10),
          curve: Curves.linear,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                icon,
                size: 25,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerOptions extends StatelessWidget {
  final String messages;
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const DrawerOptions(
      {required this.messages,
      required this.text,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Stack(
          children: [
            Icon(
              icon,
              size: 30,
            ),
            Positioned(
              top: -3,
              left: -2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                    messages,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: kfont,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        title: Text(text),
      ),
    );
  }
}

Widget _floatingCollapsed() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.redAccent,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
    ),
    margin: const EdgeInsets.fromLTRB(20.0, 55.0, 20.0, 0.0),
    child: Center(
      child: Text(
        'Categories',
        style: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
            fontFamily: kfont,
            fontSize: 16),
      ),
    ),
  );
}

Widget _floatingPanel() {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.grey,
          ),
        ]),
    margin:
        const EdgeInsets.only(left: 20.0, right: 20.0, top: 55, bottom: 1.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: 300,
          child: Row(
            children: [
              Icon(Icons.keyboard_arrow_down),
              Text('Close'),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(4.0),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Category(
                  image1: 'attitude.png',
                  category1: 'Attitude',
                  onTap1: () {},
                  image2: 'good_morning.png',
                  category2: 'Good Morning',
                  onTap2: () {},
                ),
                Category(
                  image1: 'blessing.png',
                  category1: 'Blessing',
                  onTap1: () {},
                  image2: 'boy.png',
                  category2: 'Boy',
                  onTap2: () {},
                ),
                Category(
                  image1: 'girl.png',
                  category1: 'Girl',
                  onTap1: () {},
                  image2: 'congratulation.png',
                  category2: 'Congratulation',
                  onTap2: () {},
                ),
                Category(
                  image1: 'funny.png',
                  category1: 'Funny',
                  onTap1: () {},
                  image2: 'god.png',
                  category2: 'God',
                  onTap2: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class Category extends StatelessWidget {
  final String image1;
  final String image2;
  final VoidCallback onTap1;
  final String category1;
  final String category2;

  final VoidCallback onTap2;

  const Category({
    Key? key,
    required this.image1,
    required this.category1,
    required this.onTap2,
    required this.image2,
    required this.category2,
    required this.onTap1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CategoryCard(
          image: image1,
          category: category1,
          onTap: onTap1,
        ),
        CategoryCard(
          image: image2,
          category: category2,
          onTap: onTap2,
        )
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String image;
  final String category;
  final VoidCallback onTap;

  const CategoryCard(
      {required this.image, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 160,
        height: 50,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/category/$image').blurred(
              colorOpacity: 0.2,
              borderRadius: BorderRadius.circular(4),
              blur: 1,
              overlay: Text(
                category,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ).frosted(
                blur: 2.25,
                borderRadius: BorderRadius.circular(20),
                padding: EdgeInsets.all(8),
                frostColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
