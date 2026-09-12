import 'package:flutter/material.dart';
import '../../models/project_model.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';
import '../modals/project_preview_modal.dart';

class ProjectArtworkCard extends StatefulWidget {
  final Project project;
  final bool isActive;
  final VoidCallback? onTap;

  const ProjectArtworkCard({
    super.key,
    required this.project,
    this.isActive = true,
    this.onTap,
  });

  @override
  State<ProjectArtworkCard> createState() => _ProjectArtworkCardState();
}

class _ProjectArtworkCardState extends State<ProjectArtworkCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveBreakpoints.getTypographyScale(context);
    final isMobile = ResponsiveBreakpoints.isMobile(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap ?? () => ProjectPreviewModal.show(context, widget.project),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: AppColors.bgLight,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: (_isHovered || widget.isActive)
                  ? AppColors.textPrimaryLight
                  : AppColors.borderLight,
              width: (_isHovered || widget.isActive) ? 1.5 : 1.0,
            ),
            boxShadow: _isHovered
                ? const [
                    BoxShadow(
                      color: Color(0x1F000000),
                      blurRadius: 32,
                      spreadRadius: -4,
                      offset: Offset(0, 16),
                    ),
                  ]
                : const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 16,
                      spreadRadius: -4,
                      offset: Offset(0, 8),
                    ),
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Artwork Asset Stack
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRect(
                        child: AnimatedScale(
                          scale: _isHovered ? 1.04 : 1.0,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeOutCubic,
                          child: Image.asset(
                            widget.project.imageAsset,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.surfaceSubtleLight,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.image_outlined,
                                  size: 40,
                                  color: AppColors.textMutedLight,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Gradient Hover Overlay with Quick Preview Action
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        opacity: _isHovered ? 1.0 : 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Color(0xCC0A0A0A)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Expand Artwork ↗',
                                style: AppTypography.buttonText(color: AppColors.bgLight, scale: scale).copyWith(
                                  fontSize: 12 * scale,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: AppColors.bgLight,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.fullscreen_rounded,
                                  size: 16,
                                  color: AppColors.textPrimaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Top Left Overlay Badge
                      Positioned(
                        top: 14,
                        left: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xE60A0A0A),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.project.category.toUpperCase(),
                            style: AppTypography.labelUppercase(
                              color: AppColors.bgLight,
                              scale: scale,
                            ).copyWith(
                              fontSize: 9.5 * scale,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Clean Modern Footer Metadata
                Container(
                  padding: EdgeInsets.all(isMobile ? 14.0 : 18.0),
                  decoration: const BoxDecoration(
                    color: AppColors.bgLight,
                    border: Border(
                      top: BorderSide(
                        color: AppColors.borderLight,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.project.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.heading3(
                                color: AppColors.textPrimaryLight,
                                scale: scale,
                              ).copyWith(
                                fontSize: 15 * scale,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceSubtleLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              widget.project.year,
                              style: AppTypography.labelUppercase(
                                color: AppColors.textPrimaryLight,
                                scale: scale,
                              ).copyWith(
                                fontSize: 10 * scale,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.project.tagline,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bodySmall(
                          color: AppColors.textSecondaryLight,
                          scale: scale,
                        ).copyWith(fontSize: 12 * scale),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
