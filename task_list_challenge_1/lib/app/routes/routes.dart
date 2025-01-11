import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_challenge_1/app/pages/main_page.dart';
import 'package:task_list_challenge_1/app/pages/progess_bar_page.dart';
import 'package:task_list_challenge_1/app/pages/task_comparator_chart.dart';
import 'package:task_list_challenge_1/app/pages/task_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final routes = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigatorShell) {
        return MainPage(navigationShell: navigatorShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const TaskPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/progress_bar',
              builder: (context, state) => const ProgressBarPage(),
              routes: [
                GoRoute(
                  path: '/graph_vs',
                  builder: (context, state) => const TaskComparatorChart(),
                ),
              ],
            ),
          ],
        )
      ],
    )
  ],
);
