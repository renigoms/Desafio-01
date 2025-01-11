import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/routes/routes.dart';
import 'package:task_list_challenge_1/app/service/progress_service.dart';
import 'package:task_list_challenge_1/app/service/task_service.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskService>(create: (_) => TaskService()),
        ChangeNotifierProvider<ProgressService>(create: (_) => ProgressService())
      ],
      child: MaterialApp.router(
        theme: ThemeData(
            primaryColor: Colors.green,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.green,
            )),
        debugShowCheckedModeBanner: false,
        routerDelegate: routes.routerDelegate,
        routeInformationParser: routes.routeInformationParser,
        routeInformationProvider: routes.routeInformationProvider,
      ),
    );
  }
}
