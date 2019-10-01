import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../appTheme.dart';

class TabIcon extends StatefulWidget {
  final TabIconData tabIconData;
  final Function(int index) onSelectedIndexEvent;

  TabIcon({Key key, this.tabIconData, this.onSelectedIndexEvent});

  @override
  _TabIconState createState() => _TabIconState();
}

class _TabIconState extends State<TabIcon> with TickerProviderStateMixin {

  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 400,
      ),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          widget.onSelectedIndexEvent(widget.tabIconData.index);
          _animationController.reverse();
        }
      }
    });
    super.initState();
  }

  void _startAnimation() {
    if (_animationController != null) {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (!widget.tabIconData.isSelected) {
              _startAnimation();
              widget.onSelectedIndexEvent(widget.tabIconData.index);
            }
          },
          child: IgnorePointer(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                ScaleTransition(
                  scale: Tween(begin: 0.88, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(
                        0.1,
                        1,
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                  ),
                  child: Image.asset(
                    widget.tabIconData.isSelected
                        ? widget
                            .tabIconData.selectedImagePath
                        : widget.tabIconData.imagePath,
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 6,
                  right: 0,
                  child: new ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: _animationController,
                        curve:
                        Interval(0.2, 1.0, curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyDarkBlue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 6,
                  bottom: 8,
                  child: new ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: _animationController,
                        curve:
                        Interval(0.5, 0.8, curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyDarkBlue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 8,
                  bottom: 0,
                  child: new ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: _animationController,
                        curve:
                        Interval(0.5, 0.6, curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyDarkBlue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabIconData {
  final String imagePath;
  final String selectedImagePath;
  bool _isSelected;
  final int index;

  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = "",
  }) {
    _isSelected = false;
  }

  void selected() {
    _isSelected = true;
  }

  void clearSelected() {
    _isSelected = false;
  }

  bool get isSelected => _isSelected;
}
