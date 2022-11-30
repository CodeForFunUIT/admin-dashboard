import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';

class DropTypeProduct extends StatefulWidget {
  final void Function(int item) callBack;

  const DropTypeProduct({
    super.key,
    required this.callBack,
  });

  @override
  State<DropTypeProduct> createState() => DropTypeProductState();
}

class DropTypeProductState extends State<DropTypeProduct> {
  List<String> items = ['Ram', 'Cpu', 'Laptop', 'Hard Drive'];
  String selected = 'Ram';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(),
        contentPadding: EdgeInsets.zero,
      ),
      value: selected,
      items: items
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: CustomText(
                text: e,
                size: 24,
              ),
            ),
          )
          .toList(),
      onChanged: (item) {
        switch (item) {
          case 'Ram':
            widget.callBack(2);
            break;
          case 'Cpu':
            widget.callBack(1);
            break;
          case 'Laptop':
            widget.callBack(6);
            break;
          case 'Hard Drive':
            widget.callBack(3);
            break;
          default:
        }
        setState(() {
          selected = item!;
        });
      },
    );
  }
}
