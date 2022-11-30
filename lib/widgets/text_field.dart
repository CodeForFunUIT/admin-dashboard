import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/style.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';

class TextFieldCustom extends StatelessWidget {
  final bool isId;
  final String? text;
  final String? label;
  final String? hintText;
  final String? titleText;
  final void Function(String data)? callBack;
  const TextFieldCustom({
    super.key,
    this.isId = false,
    this.text,
    this.label,
    this.hintText,
    this.titleText,
    this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(text: titleText),
          const SizedBox(height: 16),
          TextField(
            readOnly: isId,
            onChanged: callBack,
            controller: TextEditingController()..text = text ?? '',
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide(width: .5),
              ),
              filled: true,
              fillColor:
                  isId ? lightGrey.withOpacity(.5) : lightGrey.withOpacity(.2),
              hintText: hintText,
              labelText: label,
            ),
          ),
        ],
      ),
    );
  }
}
