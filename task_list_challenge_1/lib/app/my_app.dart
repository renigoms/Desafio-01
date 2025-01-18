import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/routes/routes.dart';
import 'package:task_list_challenge_1/app/controller/progress_controller.dart';
import 'package:task_list_challenge_1/app/controller/task_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskController>(create: (_) => TaskController()),
        ChangeNotifierProvider<ProgressController>(
            create: (_) => ProgressController())
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
