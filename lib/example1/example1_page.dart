import 'package:flutter/material.dart';

class Example1Page extends StatefulWidget {
  @override
  _Example1Page createState() => _Example1Page();
}

class _Example1Page extends State<Example1Page>  with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _toggleAnimation;
  Animation<double> _translationAnimation;
  final _heightOfButton = 56.0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _toggleAnimation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _translationAnimation = Tween<double>(
      begin: _heightOfButton,
      end: -8.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: Curves.easeOut,
      ),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Example 1'),
        ),
        body: SafeArea(
          child: _buttonsView(),
        ),
    );
  }

  Widget _buttonsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
              0.0,
              _translationAnimation.value * 3.0,
              0.0
          ),
          child: _addButton(),
        ),
        Transform(
          transform: Matrix4.translationValues(
              0.0,
              _translationAnimation.value * 2.0,
              0.0
          ),
          child: _editButton(),
        ),
        Transform(
          transform: Matrix4.translationValues(
              0.0,
              _translationAnimation.value,
              0.0
          ),
          child: _removeButton(),
        ),
        _toggleButton(),
      ],
    );
  }

  Widget _addButton() {
    return Container(
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.only(right: 16.0),
      child: FloatingActionButton(
        heroTag: 'addButton',
        elevation: 0.0,
        backgroundColor: Colors.orange,
        onPressed: null,
        tooltip: 'Add',
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _editButton() {
    return Container(
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.only(right: 16.0),
      child: FloatingActionButton(
        heroTag: 'editButton',
        elevation: 0.0,
        backgroundColor: Colors.orange,
        onPressed: null,
        tooltip: 'Edit',
        child: Icon(
          Icons.edit,
        ),
      ),
    );
  }

  Widget _removeButton() {
    return Container(
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.only(right: 16.0),
      child: FloatingActionButton(
        heroTag: 'removeButton',
        elevation: 0.0,
        backgroundColor: Colors.orange,
        onPressed: null,
        tooltip: 'Remove',
        child: Icon(
          Icons.delete,
        ),
      ),
    );
  }

  Widget _toggleButton() {
    return Container(
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
      child: FloatingActionButton(
        heroTag: 'toggleButton',
        backgroundColor: Colors.blue,
        onPressed: _animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _toggleAnimation,
        ),
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
