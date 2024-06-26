import 'package:flutter/material.dart';
import 'package:flutter_journey/book_router.dart';
import 'package:flutter_journey/go_router_test.dart';
import 'package:flutter_journey/jwidgets/AllWidgets.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

// GoRouter configuration
final _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) =>
          const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <RouteBase>[
        GoRoute(
            path: 'jwidgets',
            builder: (context, state) => AllWidgets(),
            routes: [
              GoRoute(
                  path: ':widgetName',
                  builder: (context, state) {
                    final widgetName = state.pathParameters['widgetName'];
                    final widget = AllWidgets.widgetRoutes
                        .firstWhere((element) => element.title == widgetName);
                    return Scaffold(
                        appBar: AppBar(title: Text(widget.title)),
                        body: widget.widgetFactory());
                  }),
            ]),
      ],
    ),
    GoRoute(
      path: "/books",
      builder: (context, state) {
        return BookWidget();
      },
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            return BookWidget();
          },
        ),
      ],
    ),
    ...PushWithShellRouteWidget.routes,
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(),
      ),
      routerConfig: _router,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(children: [
          TextButton(
            onPressed: () {
              // AllWidgets()
              context.go('/jwidgets');
            },
            child: const Text("JWidget"),
          ),
          TextButton(
            onPressed: () {
              context.go('/go_router_test');
            },
            child: const Text("GoRouter Test"),
          ),
          TextButton(
            onPressed: () {
              context.go('/books');
            },
            child: const Text("Books"),
          )
        ]),
      ),
    ));
  }
}
