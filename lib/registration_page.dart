import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_go_app/adaptive_form_widget.dart';
import 'package:event_go_app/custom_form_button.dart';
import 'package:event_go_app/custom_form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final CarouselController _slideController = CarouselController();
  int _pageNumber = 1;

  List<Widget> _buildPages() {
    var usernameIcon = SvgPicture.asset('images/user_icon.svg');
    var emailIcon = SvgPicture.asset('images/email_icon.svg');
    var passwordIcon = SvgPicture.asset('images/password_icon.svg');
    var confirmIcon = SvgPicture.asset('images/confirm_icon.svg');

    var items = <Widget>[
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: SizedBox(
                width: double.infinity,
                height: 52,
                child: CustomFormTextField(
                    hintText: 'Enter name',
                    controller: _nameController,
                    prefixIcon: usernameIcon))),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: SizedBox(
                width: double.infinity,
                height: 52,
                child: CustomFormTextField(
                    hintText: 'Enter email',
                    controller: _emailController,
                    prefixIcon: emailIcon)))
      ]),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: SizedBox(
                width: double.infinity,
                height: 52,
                child: CustomFormTextField(
                    hintText: 'Enter password',
                    controller: _password1Controller,
                    prefixIcon: passwordIcon,
                    obscuredText: true))),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: SizedBox(
                width: double.infinity,
                height: 52,
                child: CustomFormTextField(
                    hintText: 'Reenter password',
                    controller: _password2Controller,
                    prefixIcon: confirmIcon,
                    obscuredText: true))),
      ])
    ];

    return items;
  }

  Widget _buildContent(BuildContext context, Size formSize) {
    Color logoColor;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      logoColor = Colors.black;
    } else {
      logoColor = Colors.white;
    }

    var pages = _buildPages();
    var isFinal = pages.length == _pageNumber;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, formSize.height * 0.07),
                child: Image.asset('images/logo_mask.png',
                    color: logoColor,
                    width: formSize.width * 0.25,
                    height: formSize.width * 0.25)),
            CarouselSlider(
                items: _buildPages(),
                carouselController: _slideController,
                options: CarouselOptions(
                    height: formSize.height * 0.4,
                    viewportFraction: 1,
                    initialPage: _pageNumber - 1,
                    enableInfiniteScroll: false,
                    scrollDirection: Axis.horizontal)),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: CustomFormButton(
                      text: isFinal ? 'Register' : 'Next',
                      onPressed: () {
                        _slideController.nextPage();
                        setState(() {
                          _pageNumber++;
                        });
                      }),
                )),
            const Text('OR'),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: TextButton(
                  child: const Text(
                    'Login',
                    style: TextStyle(fontFamily: 'Ubuntu', fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
          bodyMedium: TextStyle(
              fontFamily: 'Ubuntu', fontSize: 14, color: Colors.black)),
    );

    var portraitTheme = ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color.fromARGB(40, 255, 255, 255)),
      checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Colors.white),
          checkColor: MaterialStateProperty.all(Colors.blue)),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontFamily: 'Ubuntu', color: Colors.white),
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
