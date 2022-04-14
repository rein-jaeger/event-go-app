import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  Widget createTextField(
      String hint, Widget icon, TextEditingController controller,
      {bool obscured = false}) {
    return SizedBox(
      height: 80,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          prefixIcon: Padding(padding: const EdgeInsets.all(12), child: icon),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 32,
            minHeight: 32,
          ),
          filled: true,
          fillColor: const Color.fromARGB(140, 255, 255, 255),
          hintText: hint,
        ),
        obscureText: obscured,
      ),
    );
  }

  Widget createElevatedButton(String label, double width) {
    return SizedBox(
        width: width,
        height: 60,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(label, style: const TextStyle(fontSize: 18)),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.white70;
                }

                return Colors.white;
              }),
              foregroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)))),
        ));
  }

  Widget forPortrait(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    var usernameIcon = SvgPicture.asset(
      'images/user_icon.svg',
      color: Colors.black54,
    );

    var passwordIcon = SvgPicture.asset(
      'images/password_icon.svg',
      color: Colors.black54,
    );

    var formWidth = screenSize.width - 40;

    return Center(
        child: SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    createTextField(
                        'Enter username', usernameIcon, _usernameController),
                    createTextField(
                        'Enter password', passwordIcon, _passwordController,
                        obscured: true),
                    ToggleSwitch(
                      minWidth: formWidth,
                      initialLabelIndex: 0,
                      totalSwitches: 3,
                      labels: const [
                        'Client',
                        'Event Organizer',
                        'Service Provider'
                      ],
                      activeBgColor: const [Colors.white],
                      activeFgColor: Colors.blue,
                      inactiveBgColor: const Color.fromARGB(25, 255, 255, 255),
                      inactiveFgColor: Colors.white70,
                      fontSize: 13,
                      customWidths: const [80.0, 120.0, 600.0],
                      onToggle: (index) {},
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Checkbox(
                                value: _rememberCredentials,
                                fillColor:
                                    MaterialStateProperty.all(Colors.white),
                                checkColor: Colors.blue,
                                onChanged: (state) {
                                  setState(() {
                                    _rememberCredentials = state!;
                                  });
                                }),
                            const Text('Remember me',
                                style: TextStyle(color: Colors.white)),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 80, 0, 8),
                        child: createElevatedButton('Next', formWidth))
                  ],
                ))));
  }

  Widget forLandscape(BuildContext context) {
    return const Center(child: SizedBox());
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    // Select suitable layout for current screen
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      content = forPortrait(context);
    } else {
      content = forLandscape(context);
    }

    return Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
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
            child: content));
  }
}
