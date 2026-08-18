import 'package:flutter/material.dart';
import '../../models/project_model.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';
import 'project_artwork_card.dart';

class WorkCarouselWidget extends StatefulWidget {
  final List<Project> projects;

  const WorkCarouselWidget({
    super.key,
    required this.projects,
  });

  @override
  State<WorkCarouselWidget> createState() => _WorkCarouselWidgetState();
}

class _WorkCarouselWidgetState extends State<WorkCarouselWidget> {
  final ScrollController _scrollController = ScrollController();

  void _scrollLeft() {
    _scrollController.animateTo(
      (_scrollController.offset - 320).clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      (_scrollController.offset + 320).clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = isMobile
        ? (screenWidth - 48.0).clamp(240.0, 300.0)
        : 340.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Carousel Header & Navigation Arrows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'RECENT DESIGN WORKS',
                  style: AppTypography.labelUppercase(
                    color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _scrollLeft,
                  icon: const Icon(Icons.arrow_back_rounded, size: 20),
                  tooltip: 'Scroll left',
                  style: IconButton.styleFrom(
                    side: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _scrollRight,
                  icon: const Icon(Icons.arrow_forward_rounded, size: 20),
                  tooltip: 'Scroll right',
                  style: IconButton.styleFrom(
                    side: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Horizontal Carousel Scroll View
        SizedBox(
          height: isMobile ? 440 : 490,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.projects.length,
            itemBuilder: (context, index) {
              final project = widget.projects[index];
              return Container(
                width: cardWidth,
                margin: const EdgeInsets.only(right: 24.0),
                child: ProjectArtworkCard(
                  project: project,
                  onTap: null, // Cards locked: showcase presentation view
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
