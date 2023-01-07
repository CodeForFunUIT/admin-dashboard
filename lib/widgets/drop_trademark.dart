import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';

class DropTrademark extends StatefulWidget {
  final void Function(int id, String name) callBack;
  final List<String> items;
  const DropTrademark({
    super.key,
    required this.callBack,
    required this.items,
  });

  @override
  State<DropTrademark> createState() => DropTrademarkState();
}

class DropTrademarkState extends State<DropTrademark> {
  late String selected;

  @override
  void initState() {
    selected = widget.items[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(),
        contentPadding: EdgeInsets.zero,
      ),
      alignment: Alignment.center,
      value: selected,
      items: widget.items
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
          case 'kingSton':
            widget.callBack(1, 'kingSton');
            break;
          case 'crucial':
            widget.callBack(2, 'crucial');
            break;
          case 'kingMax':
            widget.callBack(3, 'kingMax');
            break;
          case 'HP':
            widget.callBack(4, 'HP');
            break;
          case 'Lenovo':
            widget.callBack(5, 'Lenovo');
            break;
          case 'Dell':
            widget.callBack(6, 'Dell');
            break;
          case 'MSI':
            widget.callBack(7, 'MSI');
            break;
          case 'Intel':
            widget.callBack(8, 'Intel');
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
