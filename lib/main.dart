import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:univ_app/core/utils/wrapper.dart';
import 'package:univ_app/features/auth/presentation/manager/auth_service.dart';
import 'package:univ_app/features/auth/presentation/manager/data_manager.dart';
import 'package:flutter/services.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (context) => AuthService(),
        ),
        Provider<DataManager>(
          create: (context) => DataManager(),
        ),
      ],
      child: const UnivApp(),
    ),
  );
}

class UnivApp extends StatelessWidget {
  const UnivApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}
