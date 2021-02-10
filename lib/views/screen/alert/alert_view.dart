import 'package:batalyon/views/widget/customcirclecontainer.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class AlertView extends StatefulWidget {
  static const id = 'alertview';
  @override
  _AlertViewState createState() => _AlertViewState();
}

class _AlertViewState extends State<AlertView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: Duration(seconds: 3),
    )..repeat();
    startVibrate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: AnimatedBuilder(
          animation:
              CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                CustomCircleContainer(
                  height: size.height / 4,
                  width: size.width / 4,
                  color: Colors.red,
                  controller: _controller,
                ),
                CustomCircleContainer(
                  height: size.height / 3.5,
                  width: size.width / 3.5,
                  color: Colors.red,
                  controller: _controller,
                ),
                CustomCircleContainer(
                  height: size.height / 3,
                  width: size.width / 3,
                  color: Colors.red,
                  controller: _controller,
                ),
                CustomCircleContainer(
                  height: size.height / 2.5,
                  width: size.width / 2.5,
                  color: Colors.red,
                  controller: _controller,
                ),
                CustomCircleContainer(
                  height: size.height / 2,
                  width: size.width / 2,
                  color: Colors.red,
                  controller: _controller,
                  child: Text(
                    'SOS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Align(
                  heightFactor: 10,
                  alignment: Alignment.bottomCenter,
                  child: OutlineButton(
                    onPressed: () {
                      Vibration.cancel();
                      _controller.reset();
                      _controller.stop();
                    },
                    child: Text(
                      'stop',
                    ),
                  ),
                )
              ],
            );
          }),
    ));
  }

  void startVibrate() async {
    var pattern = <int>[];
    for (var i = 0; i < 11; i++) {
      i.isEven ? pattern.add(500) : pattern.add(3000);
    }

    if (await Vibration.hasVibrator()) {
      if (await Vibration.hasCustomVibrationsSupport()) {
        Vibration.vibrate(pattern: pattern, intensities: [256]);
      }
    }
  }
}
