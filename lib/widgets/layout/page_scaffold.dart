import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';
import '../navigation/site_header.dart';
import '../navigation/mobile_drawer.dart';
import '../navigation/site_footer.dart';

import '../common/floating_whatsapp_button.dart';
import '../common/studio_cursor_follower.dart';

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
  final ScrollController _scrollController = ScrollController();
  bool _showBottomBar = false;
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/images/header_logo.png'), context);
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final maxExtent = _scrollController.position.maxScrollExtent;
      final currentOffset = _scrollController.offset;
      final progress = maxExtent > 0 ? (currentOffset / maxExtent).clamp(0.0, 1.0) : 0.0;
      final shouldShow = currentOffset > 200;
      
      if (shouldShow != _showBottomBar || progress != _scrollProgress) {
        setState(() {
          _showBottomBar = shouldShow;
          _scrollProgress = progress;
        });
      }
    }
  }

  @override
  void didUpdateWidget(covariant PageScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPath != widget.currentPath) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0.0);
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobile(context);
    final hideBottomBarOnPaths = widget.currentPath == '/start';
    final enableMobileBottomBar = isMobile && !hideBottomBarOnPaths;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MobileDrawer(currentPath: widget.currentPath),
      body: StudioCursorFollower(
        child: Stack(
          children: [
            Column(
              children: [
                SelectionContainer.disabled(
                  child: SiteHeader(
                    currentPath: widget.currentPath,
                    onOpenMobileMenu: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                ),
                // Top Scroll Progress Line
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _scrollProgress > 0.01 ? 1.0 : 0.0,
                  child: SizedBox(
                    height: 2.0,
                    child: LinearProgressIndicator(
                      value: _scrollProgress,
                      backgroundColor: Colors.transparent,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
                    ),
                  ),
                ),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      if (notification.metrics.axis == Axis.vertical && notification.metrics.maxScrollExtent > 0) {
                        final progress = (notification.metrics.pixels / notification.metrics.maxScrollExtent).clamp(0.0, 1.0);
                        final shouldShow = notification.metrics.pixels > 200;
                        if (shouldShow != _showBottomBar || progress != _scrollProgress) {
                          setState(() {
                            _showBottomBar = shouldShow;
                            _scrollProgress = progress;
                          });
                        }
                      }
                      return false;
                    },
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          SelectionArea(
                            child: widget.body,
                          ),
                          SelectionContainer.disabled(
                            child: const SiteFooter(),
                          ),
                          if (enableMobileBottomBar)
                            const SizedBox(height: 100.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Floating WhatsApp Quick Chat Button
            Positioned(
              right: isMobile ? 16.0 : 28.0,
              bottom: (enableMobileBottomBar && _showBottomBar) ? 76.0 : 20.0,
              child: SelectionContainer.disabled(
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  offset: _showBottomBar ? Offset.zero : const Offset(0, 0.4),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: _showBottomBar ? 1.0 : 0.0,
                    child: IgnorePointer(
                      ignoring: !_showBottomBar,
                      child: const FloatingWhatsappButton(),
                    ),
                  ),
                ),
              ),
            ),

            // Animated Sticky Mobile Bottom Navigation Bar (Appears ONLY after scrolling past Hero)
            if (enableMobileBottomBar)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SelectionContainer.disabled(
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,
                    offset: _showBottomBar ? Offset.zero : const Offset(0, 1.2),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: _showBottomBar ? 1.0 : 0.0,
                      child: IgnorePointer(
                        ignoring: !_showBottomBar,
                        child: Container(
                          height: 60.0,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: (isDark ? AppColors.surfaceDark : AppColors.bgLight).withValues(alpha: 0.96),
                            border: Border(
                              top: BorderSide(
                                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                                width: 1.0,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 10,
                                offset: const Offset(0, -4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => context.go('/contact'),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    side: BorderSide(
                                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ),
                                  child: Text(
                                    'Contact',
                                    style: AppTypography.buttonText(
                                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 2,
                                child: ElevatedButton(
                                  onPressed: () => context.go('/start'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.accent,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ),
                                  child: Text(
                                    'Start Project →',
                                    style: AppTypography.buttonText(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
