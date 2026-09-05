import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';

class ProcessStepModel {
  final String stepNumber;
  final String title;
  final String subtitle;
  final String description;
  final String turnaround;
  final List<String> deliverables;
  final IconData icon;

  const ProcessStepModel({
    required this.stepNumber,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.turnaround,
    required this.deliverables,
    required this.icon,
  });
}

/// Interactive 4-Step Studio Process Timeline Widget.
class StudioProcessTimeline extends StatefulWidget {
  const StudioProcessTimeline({super.key});

  @override
  State<StudioProcessTimeline> createState() => _StudioProcessTimelineState();
}

class _StudioProcessTimelineState extends State<StudioProcessTimeline> {
  int _activeStep = 0;

  static const List<ProcessStepModel> steps = [
    ProcessStepModel(
      stepNumber: '01',
      title: 'BRIEF & DISCOVERY',
      subtitle: 'Understanding goals & requirements',
      description:
          'We start by discussing event goals, target audience, brand aesthetic, and key deliverables (posters, social graphics, or workshop syllabus).',
      turnaround: '24–48 Hours',
      deliverables: [
        'Creative Direction Alignment',
        'Reference Moodboard',
        'Scope & Timeline Approval',
      ],
      icon: Icons.lightbulb_outline_rounded,
    ),
    ProcessStepModel(
      stepNumber: '02',
      title: 'CONCEPT & COMPOSITION',
      subtitle: 'Layouts, typography & visual hierarchy',
      description:
          'Drafting initial key visual concepts with custom typography, high-impact imagery, and grid-aligned structure focused on readability.',
      turnaround: '2–3 Days',
      deliverables: [
        '2–3 Distinct Visual Concepts',
        'Typography & Color Explorations',
        'Draft Layout Previews',
      ],
      icon: Icons.grid_view_rounded,
    ),
    ProcessStepModel(
      stepNumber: '03',
      title: 'PROOFING & REFINEMENT',
      subtitle: 'Collaborative feedback & polish',
      description:
          'Presenting high-resolution proofs for client review. We refine details, adjust color contrast, and fine-tune typography based on feedback.',
      turnaround: '1–2 Days',
      deliverables: [
        'High-Res Proof Mockups',
        'Unlimited Minor Tweaks',
        'Color & Contrast Check',
      ],
      icon: Icons.auto_fix_high_rounded,
    ),
    ProcessStepModel(
      stepNumber: '04',
      title: 'FINAL ASSETS & HANDOFF',
      subtitle: 'Production-ready files & digital formats',
      description:
          'Delivering pixel-perfect export files formatted for high-density printing, Instagram/social feeds, and vector source assets.',
      turnaround: 'Same Day Handoff',
      deliverables: [
        'Print-Ready PDF / CMYK Files',
        'Web & Social Media PNG / JPGs',
        'Editable Source Files (Figma/PSD)',
      ],
      icon: Icons.task_alt_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobile(context);
    final scale = ResponsiveBreakpoints.getTypographyScale(context);
    final activeModel = steps[_activeStep];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
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
              'STUDIO PROCESS',
              style: AppTypography.labelUppercase(
                color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                scale: scale,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'How we work together.',
          style: AppTypography.heading1(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            scale: scale,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'A structured 4-step graphic design & training methodology designed for clarity and speed.',
          style: AppTypography.bodyMedium(
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            scale: scale,
          ),
        ),
        const SizedBox(height: 32),

        // Step Navigation Buttons Row / Grid
        isMobile
            ? Column(
                children: List.generate(steps.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildStepTab(index, isDark, scale, isMobile: true),
                  );
                }),
              )
            : Row(
                children: List.generate(steps.length, (index) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index == steps.length - 1 ? 0 : 12.0),
                      child: _buildStepTab(index, isDark, scale, isMobile: false),
                    ),
                  );
                }),
              ),

        const SizedBox(height: 24),

        // Active Step Detailed Card
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: Container(
            key: ValueKey<int>(_activeStep),
            width: double.infinity,
            padding: const EdgeInsets.all(28.0),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(activeModel.icon, size: 24, color: AppColors.accent),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                activeModel.title,
                                style: AppTypography.heading3(
                                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                  scale: scale,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                                  ),
                                ),
                                child: Text(
                                  'Est. ${activeModel.turnaround}',
                                  style: AppTypography.labelUppercase(
                                    color: AppColors.accent,
                                    scale: scale,
                                  ).copyWith(fontSize: 10 * scale),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            activeModel.subtitle,
                            style: AppTypography.bodySmall(
                              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                              scale: scale,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  activeModel.description,
                  style: AppTypography.bodyLarge(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    scale: scale,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepTab(int index, bool isDark, double scale, {required bool isMobile}) {
    final isSelected = index == _activeStep;
    final item = steps[index];

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _activeStep = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.accent
                : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
            border: Border.all(
              color: isSelected
                  ? AppColors.accent
                  : (isDark ? AppColors.borderDark : AppColors.borderLight),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Text(
                item.stepNumber,
                style: AppTypography.heading3(
                  color: isSelected
                      ? Colors.white
                      : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
                  scale: scale,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.buttonText(
                        color: isSelected
                            ? Colors.white
                            : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                      ).copyWith(fontSize: 12 * scale),
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
