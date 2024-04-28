// https://medium.com/flutter-community/developing-for-multiple-screen-sizes-and-orientations-in-flutter-fragments-in-flutter-a4c51b849434

import 'package:flutter/material.dart';

class ResponsiveUIWidget extends StatefulWidget {
  ResponsiveUIWidget({Key? key}) : super(key: key);

  @override
  _ResponsiveUIWidgetState createState() => _ResponsiveUIWidgetState();
}

class _ResponsiveUIWidgetState extends State<ResponsiveUIWidget> {
  var selectedValue = 0;
  var isLargeScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: OrientationBuilder(builder: (context, orientation) {
          if (MediaQuery.of(context).size.width > 600) {
            isLargeScreen = true;
          } else {
            isLargeScreen = false;
          }

          return Row(children: <Widget>[
            Expanded(
                child: ListWidget(10, (value) {
              if (isLargeScreen) {
                setState(() {
                  selectedValue = value;
                });
              } else {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return DetailPage(value);
                  },
                ));
              }
            })),
            isLargeScreen
                ? Expanded(child: DetailWidget(selectedValue))
                : Container(),
          ]);
        }));
  }
}

typedef Null ItemSelectedCallback(int value);

class ListWidget extends StatefulWidget {
  final int itemCount;
  final ItemSelectedCallback onItemSelected;

  ListWidget(this.itemCount, this.onItemSelected);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.itemCount,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
            onTap: () {
              widget.onItemSelected(index);
            },
          );
        });
  }
}

class DetailPage extends StatefulWidget {
  final int data;

  DetailPage(this.data);

  @override
  State<StatefulWidget> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  DetailPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: DetailWidget(widget.data),
      ),
    );
  }
}

class DetailWidget extends StatefulWidget {
  final int data;

  DetailWidget(this.data);

  @override
  State<StatefulWidget> createState() => DetailWidgetState();
}

class DetailWidgetState extends State<DetailWidget> {
  DetailWidgetState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.data.toString(),
                style: TextStyle(fontSize: 36.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
