import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/blocs/serie_bloc.dart';
import 'package:streaming_app/controllers/controller.dart';
import 'package:streaming_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const Color primaryRed = Color.fromARGB(255, 193, 74, 90);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SerieBloc(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryRed,
            primary: primaryRed,
            secondary: Colors.red.shade100,
          ),
          useMaterial3: true, 
          appBarTheme: AppBarTheme(
            backgroundColor: primaryRed,
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryRed,
              foregroundColor: Colors.white,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: primaryRed),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: primaryRed,
            foregroundColor: Colors.white,
          ),
          progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryRed),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
