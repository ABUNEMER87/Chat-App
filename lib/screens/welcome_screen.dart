import 'package:flutter/material.dart';
import '../screens/registration_screen.dart';
import '../screens/signin_screen.dart';
import '../widgets/my_button.dart';

class WelcomeSreen extends StatefulWidget {
  static const String screenroute = 'welcome_screen';
  const WelcomeSreen({super.key});

  @override
  State<WelcomeSreen> createState() => _WelcomeSreenState();
}

class _WelcomeSreenState extends State<WelcomeSreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child: const Image(
                    image: AssetImage('images/logo.png'),
                  ),
                ),
                const Text(
                  'Message Me',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff2e386b),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            MyButton(
              title: 'Sign in',
              color: Colors.yellow[900]!,
              onPressed: () {
                Navigator.pushNamed(context, SigninScreen.screenRoute);
              },
            ),
            MyButton(
              title: 'Register',
              color: Colors.blue[800]!,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.screenRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
