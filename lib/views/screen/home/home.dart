import 'package:batalyon/views/screen/bukusaku/bukusaku.dart';
import 'package:batalyon/views/widget/customcirclecontainer.dart';
import 'package:batalyon/views/widget/customdialogbox.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const id = 'home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
        duration: Duration(milliseconds: 300),
        lowerBound: 0.0,
        upperBound: 0.1,
        vsync: this)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _scale = 1 - _controller.value;
    return Scaffold(
      body: Container(
        width: size.width,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BukuSaku(),
                              )),
                          child: Icon(
                            Icons.book,
                            color: Colors.grey[500],
                            size: 48.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () => showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return CustomDialogBox(size: size);
                            },
                          ),
                          child: Icon(
                            Icons.exit_to_app,
                            color: Colors.grey[500],
                            size: 48.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                buildPushButton(size),
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: TextField(
                        maxLength: 30,
                        maxLines: 2,
                        minLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: TextField(
                        maxLength: 65,
                        minLines: 1,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Deskripsi',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    MaterialButton(
                      elevation: 0.0,
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: () {},
                      child: Text('Attach File'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  CustomCircleContainer buildPushButton(Size size) {
    return CustomCircleContainer(
      width: size.width / 2,
      height: size.height / 2,
      color: Colors.grey[400],
      child: CustomCircleContainer(
        height: size.height / 2.5,
        width: size.width / 2.5,
        color: Colors.white,
        showShadow: true,
        child: CustomCircleContainer(
          height: size.height / 3,
          width: size.width / 3,
          color: Colors.grey[300],
          child: CustomCircleContainer(
            height: size.height / 3.5,
            width: size.width / 3.5,
            color: Colors.red,
            child: GestureDetector(
              onTapUp: _tapUp,
              onTapDown: _tapDown,
              child: Transform.scale(
                scale: _scale,
                child: CustomCircleContainer(
                  height: size.height / 4.5,
                  width: size.width / 4.5,
                  color: Colors.white,
                  child: Text('SOS'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
