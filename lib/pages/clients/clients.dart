import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/controllers.dart'
    show menuController;
import 'package:flutter_web_dashbard/helpers/responsiveness.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';
import 'package:get/get.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6,
                ),
                child: CustomText(
                  text: menuController.activeItem.value,
                  size: 24,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
