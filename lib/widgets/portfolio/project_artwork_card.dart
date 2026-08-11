import 'package:flutter/material.dart';
import '../../models/project_model.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';

class ProjectArtworkCard extends StatefulWidget {
  final Project project;
  final VoidCallback? onTap;

  const ProjectArtworkCard({
    super.key,
    required this.project,
    this.onTap,
  });

  @override
  State<ProjectArtworkCard> createState() => _ProjectArtworkCardState();
}

class _ProjectArtworkCardState extends State<ProjectArtworkCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scale = ResponsiveBreakpoints.getTypographyScale(context);

    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            border: Border.all(
              color: _isHovered
                  ? (isDark ? AppColors.borderHoverDark : AppColors.borderHoverLight)
                  : (isDark ? AppColors.borderDark : AppColors.borderLight),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Real Poster Design Image Asset Box
              Flexible(
                fit: FlexFit.loose,
                child: AspectRatio(
                  aspectRatio: widget.project.aspectRatio,
                  child: ClipRect(
                    child: AnimatedScale(
                      scale: _isHovered ? 1.02 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      child: Image.asset(
                        widget.project.imageAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: isDark ? const Color(0xFF1B2430) : const Color(0xFFECE8DF),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.image_outlined,
                              size: 40,
                              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              // Metadata Footer
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.project.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.heading3(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              scale: scale,
                            ).copyWith(fontSize: 15 * scale),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.project.category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.bodySmall(
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                              scale: scale,
                            ).copyWith(fontSize: 12 * scale),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.project.year,
                      style: AppTypography.labelUppercase(
                        color: AppColors.accent,
                        scale: scale,
                      ).copyWith(fontSize: 11 * scale),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
