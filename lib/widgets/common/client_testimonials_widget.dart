import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';

class TestimonialModel {
  final String id;
  final String quote;
  final String authorName;
  final String authorTitle;
  final String organization;
  final String projectType;
  final int rating;

  const TestimonialModel({
    required this.id,
    required this.quote,
    required this.authorName,
    required this.authorTitle,
    required this.organization,
    required this.projectType,
    this.rating = 5,
  });
}

/// Interactive Client & Campus Testimonials Carousel Widget.
class ClientTestimonialsWidget extends StatefulWidget {
  const ClientTestimonialsWidget({super.key});

  @override
  State<ClientTestimonialsWidget> createState() => _ClientTestimonialsWidgetState();
}

class _ClientTestimonialsWidgetState extends State<ClientTestimonialsWidget> {
  int _currentIndex = 0;

  static const List<TestimonialModel> testimonials = [
    TestimonialModel(
      id: 'iedc-aset',
      quote:
          '“The Robotics Workshop poster designed by StudioProof completely transformed our registration numbers. Bold, futuristic layout that stood out on both print flex screens and Instagram stories.”',
      authorName: 'IEDC Student Lead',
      authorTitle: 'Event Coordinator',
      organization: 'IEDC ASET',
      projectType: 'Robotics Workshop Poster',
      rating: 5,
    ),
    TestimonialModel(
      id: 'sync-2026',
      quote:
          '“StudioProof delivered high-impact countdown posters and guest reveal graphics for SYNC 2026 under super tight deadlines. The visual branding gave our campus hackathon a professional edge.”',
      authorName: 'Campus Media Team',
      authorTitle: 'Media & Communications Head',
      organization: 'SYNC 2026 Hackathon',
      projectType: 'Event Campaign Branding',
      rating: 5,
    ),
    TestimonialModel(
      id: 'figma-workshop',
      quote:
          '“The poster design workshop was hands-on and extremely practical. We learned real-world layout composition, typography hierarchy, and speed tricks in Photoshop and Figma.”',
      authorName: 'Design Workshop Student',
      authorTitle: 'Workshop Participant',
      organization: 'College Design Club',
      projectType: 'Figma & Photoshop Training',
      rating: 5,
    ),
  ];

  void _previous() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + testimonials.length) % testimonials.length;
    });
  }

  void _next() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % testimonials.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scale = ResponsiveBreakpoints.getTypographyScale(context);
    final isMobile = ResponsiveBreakpoints.isMobile(context);
    final active = testimonials[_currentIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Sub-header & Navigation Controls
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
                  'CLIENT REVIEWS & FEEDBACK',
                  style: AppTypography.labelUppercase(
                    color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                    scale: scale,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _previous,
                  icon: const Icon(Icons.arrow_back_rounded, size: 20),
                  tooltip: 'Previous review',
                  style: IconButton.styleFrom(
                    side: BorderSide(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _next,
                  icon: const Icon(Icons.arrow_forward_rounded, size: 20),
                  tooltip: 'Next review',
                  style: IconButton.styleFrom(
                    side: BorderSide(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'What clients & attendees say.',
          style: AppTypography.heading1(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            scale: scale,
          ),
        ),
        const SizedBox(height: 24),

        // Testimonial Card Container
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: Container(
            key: ValueKey<int>(_currentIndex),
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 24.0 : 36.0),
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
                // Rating Stars Row
                Row(
                  children: [
                    ...List.generate(active.rating, (i) {
                      return const Padding(
                        padding: EdgeInsets.only(right: 4.0),
                        child: Icon(Icons.star_rounded, size: 20, color: Colors.amber),
                      );
                    }),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : AppColors.borderLight,
                        ),
                      ),
                      child: Text(
                        active.projectType,
                        style: AppTypography.labelUppercase(
                          color: AppColors.accent,
                          scale: scale,
                        ).copyWith(fontSize: 10 * scale),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  active.quote,
                  style: AppTypography.heading2(
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    scale: scale,
                  ).copyWith(
                    fontStyle: FontStyle.italic,
                    height: 1.45,
                    fontSize: isMobile ? 18 * scale : 22 * scale,
                  ),
                ),
                const SizedBox(height: 28),
                Divider(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  height: 1,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          active.authorName,
                          style: AppTypography.buttonText(
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${active.authorTitle} — ${active.organization}',
                          style: AppTypography.bodySmall(
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                            scale: scale,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: List.generate(testimonials.length, (idx) {
                        return GestureDetector(
                          onTap: () => setState(() => _currentIndex = idx),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(left: 6.0),
                            width: idx == _currentIndex ? 24 : 8,
                            height: 6,
                            decoration: BoxDecoration(
                              color: idx == _currentIndex
                                  ? AppColors.accent
                                  : (isDark ? AppColors.borderDark : AppColors.borderLight),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
