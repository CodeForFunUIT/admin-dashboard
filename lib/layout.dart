import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/helpers/responsiveness.dart';
import 'package:flutter_web_dashbard/widgets/large_screen.dart';
import 'package:flutter_web_dashbard/widgets/side_menu.dart';
import 'package:flutter_web_dashbard/widgets/small_screen.dart';
import 'package:flutter_web_dashbard/widgets/top_nav.dart';

class SiteLayout extends StatelessWidget {
  SiteLayout({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      drawer: const Drawer(child: SideMenu()),
      appBar: topNavigationBar(context, scaffoldKey),
      body: const ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
