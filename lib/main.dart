import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/chat_screen.dart';
import '../screens/registration_screen.dart';
import '../screens/signin_screen.dart';
import '../screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _auth = FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.fuchsia: PageTransition(
                    type: PageTransitionType.leftToRightJoined, child: this)
                .matchingBuilder
          })),
      home: AnimatedSplashScreen(
        splash: Image.asset('images/logo.png'),
        nextScreen: const WelcomeSreen(),
        duration: 2500,
        splashTransition: SplashTransition.fadeTransition,
        //pageTransitionType: PageTransitionType.scale,
        backgroundColor: const Color.fromRGBO(21, 101, 192, 1),
      ),
      // initialRoute: _auth.currentUser != null
      //   ? ChatScreen.screenRoute
      // : WelcomeSreen.screenroute,
      routes: {
        WelcomeSreen.screenroute: (context) => const WelcomeSreen(),
        SigninScreen.screenRoute: (context) => const SigninScreen(),
        RegistrationScreen.screenRoute: (context) => const RegistrationScreen(),
        ChatScreen.screenRoute: (context) => const ChatScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
