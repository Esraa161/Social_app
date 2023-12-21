
import 'package:firbaseapp/features/Edit%20profile/data/cubit/editProfile_cubit.dart';
import 'package:firbaseapp/features/Home%20Screen/presentation/home_screen.dart';
import 'package:firbaseapp/features/auth/data/cubit/auth_cubit.dart';
import 'package:firbaseapp/features/auth/presentation/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'core/Network/Cache_helper.dart';
import 'core/Notifications/notification_helper.dart';
import 'firebase_options.dart';
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();
  NotificationHelper().showNotificationHeadUp(message);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await CacheHelper.init();

  runApp(const MyApp());
}

String? _Token = CacheHelper.getData(key: 'uId');

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application
  NotificationHelper notiHelper = NotificationHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    notiHelper.requestPermissionAndGetToken();
    notiHelper.configLocalNotification();
    //
    //






  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit()..GetUserData(),
        ),
        BlocProvider<EditProfileCubit>(
          create: (BuildContext context) => EditProfileCubit(),
        )
      ],
      child: MaterialApp(
          builder: (context, child) => ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  const Breakpoint(
                      start: 1921, end: double.infinity, name: '4K'),
                ],
              ),
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Color.fromARGB(202, 36, 30, 98),
            fontFamily: 'j',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: _Token == null ? LoginScreen() : HomeScreen()),
    );
  }
}
