import 'package:flutter/material.dart';
import '../navigation/site_header.dart';
import '../navigation/mobile_drawer.dart';
import '../navigation/site_footer.dart';

class PageScaffold extends StatefulWidget {
  final Widget body;
  final String currentPath;

  const PageScaffold({
    super.key,
    required this.body,
    required this.currentPath,
  });

  @override
  State<PageScaffold> createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<PageScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MobileDrawer(currentPath: widget.currentPath),
      body: Column(
        children: [
          SiteHeader(
            currentPath: widget.currentPath,
            onOpenMobileMenu: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  widget.body,
                  const SiteFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
