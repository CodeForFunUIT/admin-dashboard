import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/controllers.dart';
import 'package:flutter_web_dashbard/helpers/responsiveness.dart';
import 'package:flutter_web_dashbard/pages/overview/widgets/overview_cards_large.dart';
import 'package:flutter_web_dashbard/pages/overview/widgets/overview_cards_medium.dart';
import 'package:flutter_web_dashbard/pages/overview/widgets/overview_cards_small.dart';
import 'package:flutter_web_dashbard/pages/overview/widgets/revenue_section_large.dart';
import 'package:flutter_web_dashbard/pages/overview/widgets/revenue_section_small.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';
import 'package:get/get.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key? key}) : super(key: key);

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
        ),
        Expanded(
          child: ListView(
            children: [
              showCard(context),
              showRevenueSection(context),
            ],
          ),
        )
      ],
    );
  }

  Widget showCard(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context) ||
        ResponsiveWidget.isMediumScreen(context)) {
      if (ResponsiveWidget.isCustomSize(context)) {
        return const OverviewCardsMediumScreen();
      } else {
        return const OverviewCardsLargeScreen();
      }
    } else {
      return const OverviewCardsSmallScreen();
    }
  }

  Widget showRevenueSection(BuildContext context) {
    if (!ResponsiveWidget.isSmallScreen(context)) {
      return const RevenueSectionLarge();
    } else {
      return const RevenueSectionSmall();
    }
  }
}
