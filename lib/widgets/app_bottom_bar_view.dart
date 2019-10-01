import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nice_ui_practice/widgets/tab_icon.dart';

import '../appTheme.dart';

class AppBottomBar extends StatefulWidget {
  final Function(int index) changeTabEvent;
  final Function() clickButtonEvent;
  final List<TabIconData> tabIcons;

  const AppBottomBar(
      {Key key,
      @required this.tabIcons,
      @required this.changeTabEvent,
      @required this.clickButtonEvent})
      : super(key: key);

  @override
  _AppBottomBarState createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _bottomBar();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget _bottomBar() {
    return Container(
      height: 62.0 + 38.0,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: _tabIconContainer(),
          ),
          Align(
            alignment: AlignmentDirectional.topCenter,
            child: _buttonContainer(),
          ),
        ],
      ),
    );
  }

  Widget _tabIconContainer() {
    return SizedBox(
      height: 62,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return PhysicalShape(
            color: AppTheme.white,
            clipBehavior: Clip.antiAlias,
            elevation: 16.0,
            clipper: AppBottomBarClipper(
              radius: Tween(begin: 0.0, end: 1.0)
                      .animate(
                        CurvedAnimation(
                            parent: animationController,
                            curve: Curves.fastOutSlowIn),
                      )
                      .value *
                  38.0,
            ),
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TabIcon(
                        tabIconData: widget.tabIcons[0],
                        onSelectedIndexEvent: _changeTabCallback,
                      ),
                    ),
                    Expanded(
                      child: TabIcon(
                        tabIconData: widget.tabIcons[1],
                        onSelectedIndexEvent: _changeTabCallback,
                      ),
                    ),
                    SizedBox(
                      width: Tween(begin: 0.0, end: 1.0)
                              .animate(CurvedAnimation(
                                  parent: animationController,
                                  curve: Curves.fastOutSlowIn))
                              .value *
                          64.0,
                    ),
                    Expanded(
                      child: TabIcon(
                        tabIconData: widget.tabIcons[2],
                        onSelectedIndexEvent: _changeTabCallback,
                      ),
                    ),
                    Expanded(
                      child: TabIcon(
                        tabIconData: widget.tabIcons[3],
                        onSelectedIndexEvent: _changeTabCallback,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _changeTabCallback(int index) {
    if (!mounted) return;
    setState(() {
      widget.tabIcons.forEach((tab) {
        tab.clearSelected();
        if (index == tab.index) {
          tab.selected();
        }
      });

      widget.changeTabEvent(index);
    });
  }

  Widget _buttonContainer() {
    return SizedBox(
      width: 38.0 + 38.0,
      height: 38.0 + 38.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ScaleTransition(
          scale: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: animationController, curve: Curves.fastOutSlowIn),
          ),
          child: Container(
            // alignment: Alignment.center,s
            decoration: BoxDecoration(
              color: AppTheme.nearlyDarkBlue,
              gradient: LinearGradient(colors: [
                AppTheme.nearlyDarkBlue,
                HexColor("#6A88E5"),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppTheme.nearlyDarkBlue.withOpacity(0.4),
                    offset: Offset(8.0, 16.0),
                    blurRadius: 16.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white.withOpacity(0.1),
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  widget.clickButtonEvent();
                },
                child: Icon(
                  Icons.add,
                  color: AppTheme.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppBottomBarClipper extends CustomClipper<Path> {
  final double radius;

  AppBottomBarClipper({this.radius = 38.0});

  @override
  Path getClip(Size size) {
    final path = Path();

    final v = radius * 2;
    path.lineTo(0, 0);
    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180),
        degreeToRadians(90), false);
    path.arcTo(
        Rect.fromLTWH(
            ((size.width / 2) - v / 2) - radius + v * 0.04, 0, radius, radius),
        degreeToRadians(270),
        degreeToRadians(70),
        false);

    path.arcTo(Rect.fromLTWH((size.width / 2) - v / 2, -v / 2, v, v),
        degreeToRadians(160), degreeToRadians(-140), false);

    path.arcTo(
        Rect.fromLTWH((size.width - ((size.width / 2) - v / 2)) - v * 0.04, 0,
            radius, radius),
        degreeToRadians(200),
        degreeToRadians(70),
        false);
    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(90), false);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(AppBottomBarClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
