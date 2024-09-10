import 'package:dkejvh/core/configs/theme/app_theme.dart';
import 'package:dkejvh/firebase_options.dart';
import 'package:dkejvh/presentation/splash/bloc/splash_cubit.dart';
import 'package:dkejvh/presentation/splash/pages/splash_page.dart';
import 'package:dkejvh/service_locator.dart';
import 'package:dkejvh/push_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: dotenv.env["KAKAO_KEY"],
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await permissionWithNotification();
  await initializeLocalNotification();
  await initializeDependencies();
  await setupPushNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..appStarted(),
      child: MaterialApp(
          title: 'dkejvh',
          theme: AppTheme.appTheme,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko', "KR"),
          ],
          home: const SplashPage()),
    );
  }
}
