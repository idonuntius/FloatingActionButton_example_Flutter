import 'package:flutter/material.dart';
import 'package:floating_action_button_example/example1/example1_page.dart';
import 'package:floating_action_button_example/example2/example2_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FloatingActionButton Examples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  final _dataList = [
    'Example 1',
    'Example 2',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FloatingActionButton Examples'),
      ),
      body: ListView.builder(
        itemBuilder:  (BuildContext context, int index) {
          return _listItemView(context, index);
        },
        itemCount: _dataList.length,
      ),
    );
  }

  Widget _listItemView(BuildContext context, int index) {
    return Card(
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Colors.grey[350],
            ),
          ),
        ),
        child: ListTile(
          title: Text(_dataList[index]),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            switch (index) {
              case 0:
                _goExample1Page(context);
                break;
              case 1:
                _goExample2Page(context);
                break;
            }
          },
        ),
      ),
    );
  }

  _goExample1Page(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return Example1Page();
        })
    );
  }

  _goExample2Page(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return Example2Page();
        })
    );
  }
}
