import 'package:flutter/material.dart';
import 'package:search_cep/temas/themes_black.dart';
import 'package:search_cep/temas/themes_light.dart';
import 'package:search_cep/views/home_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';



/*void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.amber),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
    ),
  ));
}*/

class MyColorfulApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return DynamicTheme(
          defaultBrightness: Brightness.light,          
          data: (brightness) => myThemeLight,
          themedWidgetBuilder: (context, theme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              darkTheme: myThemeBlack,
              home: HomePage(),
            );
          }
        );
      }
    }

void main() {
  runApp(
    MyColorfulApp()
    );
}