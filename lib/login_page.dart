import 'package:event_go_app/adaptive_form_widget.dart';
import 'package:event_go_app/custom_form_button.dart';
import 'package:event_go_app/custom_form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberCredentials = false;
  int _roleSelectedIndex = 0;

  Widget _buildContent(BuildContext context, Size formSize) {
    Color logoColor;
    Color activeBgColor;
    Color activeFgColor;
    Color inactiveBgColor;
    Color inactiveFgColor;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      logoColor = Colors.black;
      activeBgColor = Colors.blue;
      activeFgColor = Colors.white;
      inactiveBgColor = const Color.fromARGB(25, 0, 0, 0);
      inactiveFgColor = Colors.black87;
    } else {
      logoColor = Colors.white;
      activeBgColor = Colors.white;
      activeFgColor = Colors.blue;
      inactiveBgColor = const Color.fromARGB(25, 255, 255, 255);
      inactiveFgColor = Colors.white70;
    }

    var usernameIcon = SvgPicture.asset('images/user_icon.svg');
    var passwordIcon = SvgPicture.asset('images/password_icon.svg');

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, formSize.height * 0.07),
                child: Image.asset('images/logo_mask.png',
                    color: logoColor,
                    width: formSize.width * 0.3,
                    height: formSize.width * 0.3)),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: CustomFormTextField(
                        hintText: 'Enter username',
                        controller: _usernameController,
                        prefixIcon: usernameIcon))),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: CustomFormTextField(
                        hintText: 'Enter password',
                        controller: _passwordController,
                        prefixIcon: passwordIcon,
                        obscuredText: true))),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ToggleSwitch(
                  initialLabelIndex: _roleSelectedIndex,
                  totalSwitches: 3,
                  labels: const [
                    'Client',
                    'Event Organizer',
                    'Service Provider'
                  ],
                  activeBgColor: [activeBgColor],
                  activeFgColor: activeFgColor,
                  inactiveBgColor: inactiveBgColor,
                  inactiveFgColor: inactiveFgColor,
                  fontSize: 12,
                  customWidths: [
                    (formSize.width - 84) * 7 / 37,
                    (formSize.width - 84) * 14 / 37,
                    (formSize.width - 84) * 16 / 37
                  ],
                  onToggle: (index) {
                    setState(() {
                      _roleSelectedIndex = index!;
                    });
                  },
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 6, 8, formSize.height * 0.07),
              child: Row(
                children: [
                  Checkbox(
                      value: _rememberCredentials,
                      onChanged: (value) => setState(() {
                            _rememberCredentials = value!;
                          })),
                  const Text('Remember me')
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: CustomFormButton(text: 'Login', onPressed: () {}),
                )),
            const Text('OR'),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: TextButton(
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {},
                )),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    var landscapeTheme = ThemeData(
      inputDecorationTheme:
          const InputDecorationTheme(fillColor: Color.fromARGB(28, 0, 0, 0)),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black)),
    );

    var portraitTheme = ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color.fromARGB(40, 255, 255, 255)),
      checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Colors.white),
          checkColor: MaterialStateProperty.all(Colors.blue)),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: Colors.white)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.blue,
            primary: const Color.fromARGB(255, 255, 255, 255)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xff2d8bf8),
                  Color(0xff215dc9),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
                transform: GradientRotation(1.39626)),
          ),
          child: SingleChildScrollView(
              child: AdaptiveFormWidget(
                  landscapeTheme: landscapeTheme,
                  portraitTheme: portraitTheme,
                  builder: _buildContent))),
    );
  }
}
