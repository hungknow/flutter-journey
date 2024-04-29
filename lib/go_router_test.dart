import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// https://pub.dev/documentation/go_router/latest/topics/Navigation-topic.html

class PushWithShellRouteWidget extends StatelessWidget {
  PushWithShellRouteWidget({super.key});

  static var routes = <RouteBase>[
    ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('go_router_1'),
              backgroundColor: Colors.amber[300],
            ),
            body: child,
          );
        },
        routes: <RouteBase>[
          GoRoute(
              path: "/go_router_test",
              builder: (context, state) {
                return const GoRouterButtonWidget();
              }),
          GoRoute(
            path: "/go_router_test_shell_1",
            pageBuilder: (_, __) => const NoTransitionPage<void>(
              child: Center(
                child: Text('shell 1 body'),
              ),
            ),
          )
        ]),
    ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('go_router_2'),
              backgroundColor: Colors.blue[100],
            ),
            body: child,
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: "/go_router_test_shell_2",
            pageBuilder: (_, __) => const NoTransitionPage<void>(
              child: Center(
                child: Text('shell 2 body'),
              ),
            ),
          )
        ]),
    GoRoute(
      path: '/go_router_test_regular_route',
      builder: (BuildContext context, GoRouterState state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('go_router_test_regular_route'),
            backgroundColor: Colors.cyan[300],
          ),
          body: Center(
            child: TextButton(
              onPressed: () {
                GoRouter.of(context).push('/go_router_test_shell_2');
              },
              child: const Text(
                  'Regular: push the different shell route /go_router_test_shell_2'),
            ),
          ),
        );
      },
    )
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class GoRouterButtonWidget extends StatelessWidget {
  /// Constructs a [Home] widget.
  const GoRouterButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextButton(
            onPressed: () {
              GoRouter.of(context).push('/go_router_test_shell_1');
            },
            child:
                const Text('push the same shell route /go_router_test_shell_1'),
          ),
          TextButton(
            onPressed: () {
              GoRouter.of(context).push('/go_router_test_shell_2');
            },
            child: const Text(
                'push the different shell route /go_router_test_shell_2'),
          ),
          TextButton(
            onPressed: () {
              GoRouter.of(context).push('/go_router_test_regular_route');
            },
            child: const Text(
                'push the regular route /go_router_test_regular_route'),
          ),
        ],
      ),
    );
  }
}
