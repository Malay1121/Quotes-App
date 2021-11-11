import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivational_app/constants.dart';
import 'package:motivational_app/drawer_menu.dart';
import 'package:o_popup/o_popup.dart';

class CreateQuote extends StatefulWidget {
  const CreateQuote({Key? key}) : super(key: key);

  @override
  _CreateQuoteState createState() => _CreateQuoteState();
}

TextEditingController quote = TextEditingController();

double fontSize = 23;

class _CreateQuoteState extends State<CreateQuote> {
  @override
  Widget build(BuildContext context) {
    return DrawerMenu(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.7,
                width: MediaQuery.of(context).size.width - 70,
                color: Colors.white,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  quote.text,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.black,
                    fontFamily: kfont,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.2,
            child: TextField(
              controller: quote,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Write your quote",
                  fillColor: Colors.white70),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    OPopupTrigger(
                      triggerWidget: EditOption(
                        icon: Icons.text_fields,
                        text: 'Font Size',
                      ),
                      popupHeader:
                          OPopupContent.standardizedHeader('Click anywhere'),
                      popupContent: Container(
                        width: 150.0,
                        height: 150.0,
                        color: Colors.blue,
                        child: Column(
                          children: [
                            Text(
                              'Font Size',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(FontAwesomeIcons.plus,
                                        color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        fontSize.toString();
                                        fontSize++;
                                      });
                                    },
                                  ),
                                  Text(
                                    fontSize.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.minus,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        fontSize.toString();
                                        fontSize--;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Note:- Reopen to see changes',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    EditOption(
                      icon: Icons.color_lens,
                      text: 'Text Color',
                    ),
                    EditOption(
                      icon: Icons.font_download,
                      text: 'Font',
                    ),
                    EditOption(
                      icon: Icons.align_horizontal_center,
                      text: 'Alignment',
                    ),
                    EditOption(
                      icon: Icons.padding_rounded,
                      text: 'Padding',
                    ),
                    EditOption(
                      icon: Icons.gradient,
                      text: 'Gradient',
                    ),
                    EditOption(
                      icon: Icons.format_color_fill,
                      text: 'Color',
                    ),
                    EditOption(
                      icon: Icons.opacity,
                      text: 'Opacity',
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: BounceInLeft(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Publish',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: kfont,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      appbarText: 'Write a quote',
    );
  }
}

class EditOption extends StatelessWidget {
  final IconData icon;
  final String text;

  const EditOption({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return BounceInDown(
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.indigo,
            ),
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: SizedBox(
                height: 80,
                width: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: Colors.white,
                    ),
                    Text(
                      text,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
