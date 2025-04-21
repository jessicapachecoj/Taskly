import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskly/core/utils/theme.dart';

class AppWidget extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Erro ao inicializar o Firebase')),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            title: 'Taskly',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: AppTheme.getThemeMode(),
            initialRoute: '/',
            getPages: AppPages.routes,
          );
        }

        return const MaterialApp(
          home: Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}