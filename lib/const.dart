import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const primaryColor = Color(0xFFFE724C);
const caption1 = 'Your favourite foods delivered';
const caption2 = 'fast at your door.';

Widget texting({
  required String text,
  required double fontSize,
  required Color color,
  required FontWeight fontWeight,
}) {
  return Row(
    children: [
      Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    ],
  );
}

Widget labelTextfield({
  required String textOfLabel,
  required double fontSizeOfLabel,
  required Color colorOfLabel,
  required FontWeight fontWeightOfLabel,
  required String labelText,
  required bool isFill,
  required double borderRadiusOftextField,
  required double sizedBoxByHeigth,
  required bool isSecure,
  required bool isShowCursor,
  required Icon iconOfEye,
}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(30, 190, 30, 0),
    child: Column(
      children: [
        texting(
            text: textOfLabel,
            fontSize: fontSizeOfLabel,
            color: colorOfLabel,
            fontWeight: fontWeightOfLabel),
        SizedBox(
          height: sizedBoxByHeigth,
        ),
        TextFormField(
          obscureText: isSecure,
          showCursor: isShowCursor,
          decoration: InputDecoration(
            suffixIcon: iconOfEye,
            labelText: labelText,
            filled: isFill,
            border: OutlineInputBorder(
              borderSide: const BorderSide(),
              borderRadius: BorderRadius.circular(borderRadiusOftextField),
            ),
          ),
        ),
      ],
    ),
  );
}
