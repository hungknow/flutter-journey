import 'package:flutter/material.dart';
import 'package:flutter_journey/jwidgets/AnimatedBarrierModalWidget.dart';
import 'package:flutter_journey/jwidgets/AnimatedBuilderWidget.dart';
import 'package:flutter_journey/jwidgets/AnimatedContainerWidget.dart';
import 'package:flutter_journey/jwidgets/AnimatedCrossFadeWidget.dart';
import 'package:flutter_journey/jwidgets/AnimatedGrid.dart';
import 'package:flutter_journey/jwidgets/AnimatedListWidget.dart';
import 'package:flutter_journey/jwidgets/AspectRatioWidget.dart';
import 'package:flutter_journey/jwidgets/AutofillGroupWidget.dart';
import 'package:flutter_journey/jwidgets/BackdropFilterWidget.dart';
import 'package:flutter_journey/jwidgets/PageViewWidget.dart';
import 'package:flutter_journey/jwidgets/RawAutoCompleteWidget.dart';
import 'package:flutter_journey/jwidgets/ResponsiveUIWidget.dart';
import 'package:flutter_journey/jwidgets/SmoothWidget.dart';
import 'package:flutter_journey/jwidgets/YoutubeWidget.dart';
import 'package:go_router/go_router.dart';

class widgetRoute {
  final String title;
  final Widget Function() widgetFactory;

  widgetRoute(this.title, this.widgetFactory);
}

class AllWidgets extends StatelessWidget {
  AllWidgets({Key? key}) : super(key: key);

  static var widgetRoutes = [
    widgetRoute('AnimatedBarrierModal', () => AnimatedBarrierModalWidget()),
    widgetRoute('AnimatedBuilder', () => AnimatedBuilderWidget()),
    widgetRoute('AnimatedContainerWidget', () => AnimatedContainerWidget()),
    widgetRoute('AnimatedCrossFadeWidget', () => AnimatedCrossFadeWidget()),
    widgetRoute('AnimatedGrid', () => AnimatedGridWidget()),
    widgetRoute('AnimatedList', () => AnimatedListWidget()),
    widgetRoute('AspectRatioWidget', () => AspectRatioWidget()),
    widgetRoute('AutofillGroupWidget', () => AutofillGroupWidget()),
    widgetRoute('BackdropFilterWidget', () => BackdropFilterWidget()),
    widgetRoute('PageViewWidget', () => PageViewWidget()),
    widgetRoute('RawAutoCompleteWidget', () => RawAutoCompleteWidget()),
    widgetRoute('ResponsiveUI', () => ResponsiveUIWidget()),
    widgetRoute('SmoothWidget', () => SmoothWidget()),
    widgetRoute('YoutubeWidget', () => YoutubeWidget())
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: widgetRoutes.map((widget) {
        return TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.green[200],
          ),
          onPressed: () {
            context.go("/jwidgets/${widget.title}");
          },
          child: Text(widget.title),
        );
      }).toList(),
    );
  }
}
