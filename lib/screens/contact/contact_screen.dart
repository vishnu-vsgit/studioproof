import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../core/config/app_config.dart';
import '../../core/services/supabase_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';
import '../../widgets/layout/page_scaffold.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isSubmitting = false;
  bool _isSubmitted = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri? url = Uri.tryParse(urlString);
    if (url != null &&
        (url.scheme == 'https' ||
            url.scheme == 'mailto' ||
            url.scheme == 'tel')) {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    }
  }

  void _sendDirectEmail() {
    final subject = Uri.encodeComponent(
        'Direct Enquiry: ${_nameController.text.trim()}');
    final body = Uri.encodeComponent(
      'Name: ${_nameController.text.trim()}\n'
      'Email: ${_emailController.text.trim()}\n\n'
      'Message:\n${_messageController.text.trim()}',
    );
    _launchUrl('mailto:${AppConfig.contactEmail}?subject=$subject&body=$body');
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    // 1. Persist to Supabase Database if available
    if (SupabaseService.isInitialized) {
      await SupabaseService.submitContactInquiry(
        name: name,
        email: email,
        message: message,
      );
    }

    // 2. Send email notification directly to kalaa.png@gmail.com via FormSubmit AJAX endpoint
    try {
      final response = await http.post(
        Uri.parse('https://formsubmit.co/ajax/${AppConfig.contactEmail}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          '_subject': 'New Contact Form Submission: $name',
          '_template': 'table',
          '_captcha': 'false',
          'Name': name,
          'Email': email,
          'Message': message,
        }),
      );

      Map<String, dynamic> data = {};
      try {
        data = jsonDecode(response.body);
      } catch (_) {}

      final isSuccess = data['success'] == 'true' || data['success'] == true;
      final serverMsg = data['message']?.toString() ?? '';

      if ((response.statusCode >= 200 && response.statusCode < 300) || isSuccess) {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
            _isSubmitted = true;
          });
        }
        return;
      }

      if (mounted) {
        setState(() {
          _isSubmitting = false;
          if (serverMsg.toLowerCase().contains('activation') ||
              serverMsg.toLowerCase().contains('activate')) {
            _errorMessage =
                'Form activation required! FormSubmit sent an email to ${AppConfig.contactEmail}. Please open your inbox, click "Activate Form", and click Send again.';
          } else if (serverMsg.isNotEmpty) {
            _errorMessage = serverMsg;
          } else {
            _errorMessage =
                'Could not send message automatically. Please tap the direct email button below.';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _errorMessage =
              'Network connection issue. Please send via direct email below.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobileOrTablet(context);
    final horizontalPadding =
        ResponsiveBreakpoints.getHorizontalPadding(context);
    final scale = ResponsiveBreakpoints.getTypographyScale(context);

    return Title(
      title: 'Contact Us — ${AppConfig.studioName}',
      color: isDark ? AppColors.bgDark : AppColors.bgLight,
      child: PageScaffold(
        currentPath: '/contact',
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── HERO HEADER ─────────────────────────────────────────────
            _ScrollEntranceAnimation(
              staggerIndex: 0,
              child: Container(
                width: double.infinity,
                color: AppColors.bgLight,
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  top: isMobile ? 48.0 : 88.0,
                  bottom: isMobile ? 48.0 : 80.0,
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: ResponsiveBreakpoints.maxContentWidth,
                    ),
                    child: isMobile
                        ? _buildMobileHero(context, scale)
                        : _buildDesktopHero(context, scale),
                  ),
                ),
              ),
            ),

            const Divider(color: AppColors.borderLight, height: 1),

            // ── RESPONSE GUARANTEE STRIP ─────────────────────────────────
            _ScrollEntranceAnimation(
              staggerIndex: 1,
              child: Container(
                width: double.infinity,
                color: AppColors.surfaceLight,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 18,
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: ResponsiveBreakpoints.maxContentWidth,
                    ),
                    child: Wrap(
                      spacing: 32,
                      runSpacing: 12,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _ResponseBadge(
                          icon: Icons.schedule_rounded,
                          label: 'Typical response within 4 hours',
                          scale: scale,
                        ),
                        _ResponseBadge(
                          icon: Icons.check_circle_outline_rounded,
                          label: 'No spam, no unsolicited calls',
                          scale: scale,
                        ),
                        _ResponseBadge(
                          icon: Icons.lock_outline_rounded,
                          label: 'Your details stay private',
                          scale: scale,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const Divider(color: AppColors.borderLight, height: 1),

            // ── MAIN CONTACT CONTENT ─────────────────────────────────────
            _ScrollEntranceAnimation(
              staggerIndex: 2,
              child: Container(
                width: double.infinity,
                color: AppColors.bgLight,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: isMobile ? 48.0 : 80.0,
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: ResponsiveBreakpoints.maxContentWidth,
                    ),
                    child: isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDirectContactChannels(isDark, scale),
                              const SizedBox(height: 56),
                              _buildQuickMessageForm(isDark, scale),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: _buildDirectContactChannels(isDark, scale),
                              ),
                              const SizedBox(width: 72),
                              Expanded(
                                flex: 5,
                                child: _buildQuickMessageForm(isDark, scale),
                              ),
                            ],
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

  Widget _buildMobileHero(BuildContext context, double scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GET IN TOUCH',
          style: AppTypography.labelUppercase(
            color: AppColors.textMutedLight,
            scale: scale,
          ).copyWith(letterSpacing: 2.5),
        ),
        const SizedBox(height: 20),
        Text(
          "Let's connect.",
          style: AppTypography.heading1(
            color: AppColors.textPrimaryLight,
            scale: scale,
          ).copyWith(fontSize: 36 * scale, height: 1.1),
        ),
        const SizedBox(height: 16),
        Text(
          'Have a quick question, feedback, or want to discuss an idea? Reach out directly via email, WhatsApp, or message us below.',
          style: AppTypography.bodyLarge(
            color: AppColors.textSecondaryLight,
            scale: scale,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHero(BuildContext context, double scale) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GET IN TOUCH',
                style: AppTypography.labelUppercase(
                  color: AppColors.textMutedLight,
                  scale: scale,
                ).copyWith(letterSpacing: 2.5),
              ),
              const SizedBox(height: 24),
              Text(
                "Let's connect.",
                style: AppTypography.displayMedium(
                  color: AppColors.textPrimaryLight,
                  scale: scale,
                ).copyWith(height: 1.05),
              ),
              const SizedBox(height: 20),
              Text(
                'Have a quick question, feedback, or want to discuss an idea? Reach out directly via email, WhatsApp, or message us below.',
                style: AppTypography.bodyLarge(
                  color: AppColors.textSecondaryLight,
                  scale: scale,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 64),
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.statusAvailable,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Available & accepting work',
                      style: AppTypography.labelUppercase(
                        color: AppColors.textPrimaryLight,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Response within 4 hours on weekdays. WhatsApp for fastest replies.',
                  style: AppTypography.bodyMedium(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: AppColors.borderLight, height: 1),
                const SizedBox(height: 20),
                Text(
                  AppConfig.contactEmail,
                  style: AppTypography.bodyMedium(
                    color: AppColors.textPrimaryLight,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDirectContactChannels(bool isDark, double scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DIRECT CHANNELS',
          style: AppTypography.labelUppercase(
            color: AppColors.textMutedLight,
            scale: scale,
          ).copyWith(letterSpacing: 2.5),
        ),
        const SizedBox(height: 16),
        Text(
          'Instant & Direct Reachouts',
          style: AppTypography.heading2(
            color: AppColors.textPrimaryLight,
            scale: scale,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Message us on any of the platforms below for fast responses.',
          style: AppTypography.bodyMedium(
            color: AppColors.textSecondaryLight,
            scale: scale,
          ),
        ),
        const SizedBox(height: 32),
        _ContactChannelCard(
          icon: Icons.email_outlined,
          title: 'Email',
          value: AppConfig.contactEmail,
          subtitle: 'Open email composer',
          onTap: () => _launchUrl('mailto:${AppConfig.contactEmail}'),
        ),
        const SizedBox(height: 12),
        _ContactChannelCard(
          icon: Icons.phone_outlined,
          title: 'Phone / Call',
          value: AppConfig.phoneNumber,
          subtitle: 'Direct phone call',
          onTap: () => _launchUrl(AppConfig.phoneUrl),
        ),
        const SizedBox(height: 12),
        _ContactChannelCard(
          icon: Icons.chat_bubble_outline_rounded,
          title: 'WhatsApp',
          value: '+91 87789 44493',
          subtitle: 'Instant chat — fastest reply',
          onTap: () => _launchUrl('https://wa.me/${AppConfig.whatsappNumber}'),
        ),
        const SizedBox(height: 12),
        _ContactChannelCard(
          icon: Icons.camera_alt_outlined,
          title: 'Instagram',
          value: AppConfig.instagramHandle,
          subtitle: 'Follow updates & DM directly',
          onTap: () => _launchUrl(AppConfig.instagramUrl),
        ),
      ],
    );
  }

  Widget _buildQuickMessageForm(bool isDark, double scale) {
    if (_isSubmitted) {
      return _SuccessState(
        onReset: () {
          setState(() {
            _nameController.clear();
            _emailController.clear();
            _messageController.clear();
            _isSubmitted = false;
            _errorMessage = null;
          });
        },
        onWhatsApp: () =>
            _launchUrl('https://wa.me/${AppConfig.whatsappNumber}'),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QUICK MESSAGE',
            style: AppTypography.labelUppercase(
              color: AppColors.textMutedLight,
              scale: scale,
            ).copyWith(letterSpacing: 2.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Send a quick note',
            style: AppTypography.heading2(
              color: AppColors.textPrimaryLight,
              scale: scale,
            ),
          ),
          const SizedBox(height: 32),

          // Name field
          _FloatingLabelField(
            controller: _nameController,
            label: 'Your Name',
            hint: 'Alex Morgan',
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
          ),
          const SizedBox(height: 20),

          // Email field
          _FloatingLabelField(
            controller: _emailController,
            label: 'Email Address',
            hint: 'alex@domain.com',
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Please enter your email';
              if (!v.contains('@') || !v.contains('.')) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Message field
          _FloatingLabelField(
            controller: _messageController,
            label: 'Message',
            hint: 'Write your message or question here...',
            maxLines: 5,
            validator: (v) => (v == null || v.trim().length < 5)
                ? 'Please write a message (at least 5 characters)'
                : null,
          ),

          // Error message
          if (_errorMessage != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.redAccent.withValues(alpha: 0.06),
                border: Border.all(color: Colors.redAccent.withValues(alpha: 0.4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.error_outline_rounded,
                      color: Colors.redAccent, size: 18),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _errorMessage!,
                          style: AppTypography.bodySmall(color: Colors.redAccent),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: _sendDirectEmail,
                          child: Text(
                            'Click here to open email app →',
                            style: AppTypography.bodySmall(
                              color: Colors.redAccent,
                            ).copyWith(
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 28),

          // Submit button
          _SubmitButton(
            isLoading: _isSubmitting,
            onTap: _isSubmitting ? null : _submitForm,
            label: 'Send Message',
          ),
          const SizedBox(height: 14),
          Text(
            'By submitting this form, you agree to our Privacy Policy & Terms.',
            style: AppTypography.bodySmall(
              color: AppColors.textMutedLight,
            ).copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

// ── CONTACT CHANNEL CARD ───────────────────────────────────────────────────────

class _ContactChannelCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactChannelCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.onTap,
  });

  @override
  State<_ContactChannelCard> createState() => _ContactChannelCardState();
}

class _ContactChannelCardState extends State<_ContactChannelCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              border: Border(
                left: BorderSide(
                  color: _isHovered
                      ? AppColors.textPrimaryLight
                      : AppColors.borderLight,
                  width: _isHovered ? 3 : 1,
                ),
                top: BorderSide(color: AppColors.borderLight),
                right: BorderSide(color: AppColors.borderLight),
                bottom: BorderSide(color: AppColors.borderLight),
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : [],
            ),
            child: Row(
              children: [
                // Icon container
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? AppColors.textPrimaryLight
                        : AppColors.surfaceSubtleLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    size: 20,
                    color: _isHovered ? Colors.white : AppColors.textMutedLight,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: AppTypography.labelUppercase(
                          color: AppColors.textMutedLight,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.value,
                        style: AppTypography.heading3(
                          color: AppColors.textPrimaryLight,
                        ).copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle,
                        style: AppTypography.bodySmall(
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSlide(
                  offset: _isHovered ? Offset.zero : const Offset(-0.1, 0),
                  duration: const Duration(milliseconds: 200),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _isHovered ? 1.0 : 0.3,
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: AppColors.textPrimaryLight,
                    ),
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

// ── FLOATING LABEL FIELD ───────────────────────────────────────────────────────

class _FloatingLabelField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final int maxLines;

  const _FloatingLabelField({
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.maxLines = 1,
  });

  @override
  State<_FloatingLabelField> createState() => _FloatingLabelFieldState();
}

class _FloatingLabelFieldState extends State<_FloatingLabelField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          style: AppTypography.labelUppercase(
            color: _isFocused
                ? AppColors.textPrimaryLight
                : AppColors.textMutedLight,
          ).copyWith(letterSpacing: 1.5, fontSize: 11),
          child: Text(widget.label),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          maxLines: widget.maxLines,
          style: AppTypography.bodyMedium(color: AppColors.textPrimaryLight),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTypography.bodyMedium(
              color: AppColors.textMutedLight,
            ).copyWith(color: const Color(0xFFCBD5E1)),
            filled: true,
            fillColor: _isFocused
                ? AppColors.bgLight
                : AppColors.surfaceLight,
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.borderLight),
              borderRadius: BorderRadius.circular(2),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.textPrimaryLight,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent),
              borderRadius: BorderRadius.circular(2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.redAccent, width: 1.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}

// ── SUBMIT BUTTON ─────────────────────────────────────────────────────────────

class _SubmitButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback? onTap;
  final String label;

  const _SubmitButton({
    required this.isLoading,
    required this.onTap,
    required this.label,
  });

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.forbidden,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.onTap == null
                ? AppColors.borderLight
                : (_isHovered
                    ? const Color(0xFF1E293B)
                    : AppColors.textPrimaryLight),
          ),
          child: widget.isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.label,
                      style: AppTypography.buttonText(color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    AnimatedSlide(
                      offset: _isHovered
                          ? const Offset(0.15, 0)
                          : Offset.zero,
                      duration: const Duration(milliseconds: 180),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// ── SUCCESS STATE ─────────────────────────────────────────────────────────────

class _SuccessState extends StatefulWidget {
  final VoidCallback onReset;
  final VoidCallback onWhatsApp;

  const _SuccessState({required this.onReset, required this.onWhatsApp});

  @override
  State<_SuccessState> createState() => _SuccessStateState();
}

class _SuccessStateState extends State<_SuccessState>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(36),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: AppColors.textPrimaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Message Sent!',
              style: AppTypography.heading2(color: AppColors.textPrimaryLight),
            ),
            const SizedBox(height: 12),
            Text(
              'Thank you for reaching out. We will get back to your email shortly — usually within 4 hours on weekdays.',
              style: AppTypography.bodyMedium(
                color: AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                _OutlineActionButton(
                  label: 'Send another',
                  onTap: widget.onReset,
                ),
                const SizedBox(width: 12),
                _OutlineActionButton(
                  label: 'WhatsApp us',
                  onTap: widget.onWhatsApp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OutlineActionButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _OutlineActionButton({required this.label, required this.onTap});

  @override
  State<_OutlineActionButton> createState() => _OutlineActionButtonState();
}

class _OutlineActionButtonState extends State<_OutlineActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.textPrimaryLight : Colors.transparent,
            border: Border.all(
              color: _isHovered ? AppColors.textPrimaryLight : AppColors.borderLight,
              width: 1.5,
            ),
          ),
          child: Text(
            widget.label,
            style: AppTypography.buttonText(
              color: _isHovered ? Colors.white : AppColors.textPrimaryLight,
            ),
          ),
        ),
      ),
    );
  }
}

// ── RESPONSE BADGE ─────────────────────────────────────────────────────────────

class _ResponseBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final double scale;

  const _ResponseBadge({
    required this.icon,
    required this.label,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: AppColors.textMutedLight),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppTypography.bodySmall(
            color: AppColors.textSecondaryLight,
            scale: scale,
          ).copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

// ── SCROLL ENTRANCE ANIMATION ─────────────────────────────────────────────────

class _ScrollEntranceAnimation extends StatefulWidget {
  final Widget child;
  final int staggerIndex;

  const _ScrollEntranceAnimation({
    required this.child,
    required this.staggerIndex,
  });

  @override
  State<_ScrollEntranceAnimation> createState() =>
      _ScrollEntranceAnimationState();
}

class _ScrollEntranceAnimationState extends State<_ScrollEntranceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.025),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(Duration(milliseconds: 40 * widget.staggerIndex), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
