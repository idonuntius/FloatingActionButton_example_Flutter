import 'package:floating_action_button_example/example2/border_circle_painter.dart';
import 'package:flutter/material.dart';

class Example2Page extends StatefulWidget {
  @override
  _Example2Page createState() => _Example2Page();
}

class _Example2Page extends State<Example2Page>  with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _toggleAnimation;
  Animation<double> _borderCircleAnimation;
  Animation<double> _removeButtonCurvedAnimation;
  Animation<double> _addButtonCurvedAnimation;
  Animation<double> _editButtonCurvedAnimation;
  double _borderCircleAnimationFraction = 0.0;
  double _removeButtonAnimationFraction = 0.0;
  double _addButtonAnimationFraction = 0.0;
  double _editButtonAnimationFraction = 0.0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _toggleAnimation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _borderCircleAnimation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {
          _borderCircleAnimationFraction = _borderCircleAnimation.value;
        });
      });
    _removeButtonCurvedAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
              0.16,
              0.66,
              curve: Curves.easeOutBack
          ),
      )
    )
      ..addListener(() {
        setState(() {
          _removeButtonAnimationFraction = _removeButtonCurvedAnimation.value;
        });
      });
    _addButtonCurvedAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
              0.48,
              0.58,
              curve: Curves.easeOutBack
          ),
        )
    )
      ..addListener(() {
        setState(() {
          _addButtonAnimationFraction = _addButtonCurvedAnimation.value;
        });
      });
    _editButtonCurvedAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
              0.9,
              1.0,
              curve: Curves.easeOutBack
          ),
        )
    )
      ..addListener(() {
        setState(() {
          _editButtonAnimationFraction = _editButtonCurvedAnimation.value;
        });
      });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Example 2'),
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[850]),
        child: Stack(
          children: <Widget>[
            _borderCircleAnimationWidget(size),
            _removeButton(size),
            _addButton(size),
            _editButton(size),
            _toggleButton(size),
          ],
        ),
      )
    );
  }

  Widget _removeButton(Size size) {
    return Positioned(
      top: size.height / 2 + 80 - 18,
      right: 16,
      child: Transform.scale(
        scale: _removeButtonAnimationFraction,
        child: SizedBox(
          width: 56,
          height: 56,
          child: RaisedButton(
            onPressed: () {
              print('>>> tap');
            },
            color: Colors.grey[850],
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.grey[400],
                width: 4,
                style: BorderStyle.solid,
              ),
            ),
            child: Icon(
              Icons.delete,
              color: Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }

  Widget _addButton(Size size) {
    return Positioned(
      top: size.height / 2 - 28,
      right: 102,
      child: Transform.scale(
        scale: _addButtonAnimationFraction,
        child: SizedBox(
          width: 56,
          height: 56,
          child: RaisedButton(
            onPressed: () {
              print('>>> tap');
            },
            color: Colors.grey[850],
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.grey[400],
                width: 4,
                style: BorderStyle.solid,
              ),
            ),
            child: Icon(
              Icons.add,
              color: Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }

  Widget _editButton(Size size) {
    return Positioned(
      top: size.height / 2 - 80 - 38,
      right: 16,
      child: Transform.scale(
        scale: _editButtonAnimationFraction,
        child: SizedBox(
          width: 56,
          height: 56,
          child: RaisedButton(
            onPressed: () {
              print('>>> tap');
            },
            color: Colors.grey[850],
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.grey[400],
                width: 4,
                style: BorderStyle.solid,
              ),
            ),
            child: Icon(
              Icons.edit,
              color: Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }

  Widget _toggleButton(Size size) {
    return Positioned(
      top: size.height / 2 - 28,
      right: 16,
      child: SizedBox(
        width: 56,
        height: 56,
        child: RaisedButton(
          onPressed: _animate,
          color: Colors.grey[850],
          shape: CircleBorder(
            side: BorderSide(
              color: Colors.white,
              width: 4,
              style: BorderStyle.solid,
            ),
          ),
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            color: Colors.white,
            progress: _toggleAnimation,
          ),
        ),
      ),
    );
  }

  Widget _borderCircleAnimationWidget(Size size) {
    return Positioned(
      top: size.height / 2 - 80,
      right: -40,
      child: SizedBox(
        width: 160,
        height: 160,
        child: CustomPaint(painter: BorderCirclePainter(_borderCircleAnimationFraction),),
      ),
    );
  }

  _animate() {
    switch (_animationController.status) {
      case AnimationStatus.dismissed:
      case AnimationStatus.reverse:
        _animationController.forward();
        break;
      case AnimationStatus.completed:
      case AnimationStatus.forward:
        _animationController.reverse();
        break;
    }
  }
}
