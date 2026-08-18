import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';

class FloatingWhatsappButton extends StatefulWidget {
  const FloatingWhatsappButton({super.key});

  @override
  State<FloatingWhatsappButton> createState() => _FloatingWhatsappButtonState();
}

class _FloatingWhatsappButtonState extends State<FloatingWhatsappButton> {
  bool _isHovered = false;

  Future<void> _launchWhatsapp() async {
    final message = Uri.encodeComponent("Hi StudioProof! I'd like to discuss a design project.");
    final url = Uri.parse('https://wa.me/${AppConfig.whatsappNumber}?text=$message');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobile(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _launchWhatsapp,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: (isMobile || !_isHovered) ? 14.0 : 18.0,
            vertical: 12.0,
          ),
          decoration: BoxDecoration(
            color: (isDark ? const Color(0xFF1B1B18) : const Color(0xFF111110)).withValues(alpha: 0.95),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFF22C55E) // Glowing WhatsApp Emerald on hover
                  : (isDark ? AppColors.borderDark : AppColors.borderLight),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Emerald Live Status Dot
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              // WhatsApp Chat Icon
              const Icon(
                Icons.chat_bubble_outline_rounded,
                size: 18,
                color: Colors.white,
              ),
              if (!isMobile) ...[
                const SizedBox(width: 8),
                Text(
                  'QUICK CHAT',
                  style: AppTypography.labelUppercase(
                    color: Colors.white,
                  ).copyWith(
                    fontSize: 11,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
