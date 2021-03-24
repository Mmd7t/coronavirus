import 'package:coronavirus/providers/theme_provider.dart';
import 'package:flutter/material.dart';

class GlobalTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const GlobalTextFormField({
    Key key,
    @required this.controller,
    @required this.hintText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var themeController = ThemeController.of(context);
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      keyboardAppearance: (themeController.currentTheme == 'dark')
          ? Brightness.dark
          : Brightness.light,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: (themeController.currentTheme == 'dark')
            ? const Color(0xFF131344)
            : Colors.grey[300],
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'fill this label please';
        }
        return null;
      },
    );
  }
}
