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

enum FormCategory { design, retainer, training }

class StartProjectScreen extends StatefulWidget {
  final String? initialType;

  const StartProjectScreen({super.key, this.initialType});

  @override
  State<StartProjectScreen> createState() => _StartProjectScreenState();
}

class _StartProjectScreenState extends State<StartProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  FormCategory _selectedCategory = FormCategory.design;

  String _selectedProjectType = 'Poster';
  String _selectedBudget = 'Not sure yet';
  String _selectedDeadline = 'Flexible';

  bool _isSubmitting = false;
  bool _isSubmitted = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.initialType == 'retainer' || widget.initialType == 'monthly') {
      _selectedCategory = FormCategory.retainer;
      _selectedProjectType = _retainerProjectTypes.first;
      _selectedBudget = 'Not sure yet';
      _selectedDeadline = 'Start Immediately';
    } else if (widget.initialType == 'training') {
      _selectedCategory = FormCategory.training;
      _selectedProjectType = _trainingProjectTypes.first;
      _selectedBudget = 'Not sure yet';
      _selectedDeadline = 'Flexible Dates';
    }
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

  final List<String> _designProjectTypes = [
    'Poster',
    'Logo Design',
    'Social Media',
    'Event / College',
    'Startup',
    'Branding',
  ];

  final List<String> _retainerProjectTypes = [
    '2–4 Graphics / mo',
    '5–8 Graphics / mo',
    '8–15 Graphics / mo',
    'Custom Retainer Scope',
  ];

  final List<String> _trainingProjectTypes = [
    'Figma & UI Basics',
    'Poster Design Principles',
    'Club / College Workshop',
    'Visual Layout & Composition',
    'Custom Training',
  ];

  final List<String> _designBudgetOptions = [
    'Under ₹1,000',
    '₹1,000–₹3,000',
    '₹3,000–₹5,000',
    '₹5,000–₹10,000',
    '₹10,000+',
    'Not sure yet',
  ];

  final List<String> _retainerBudgetOptions = [
    '₹3,000–₹5,000 / mo',
    '₹5,000–₹10,000 / mo',
    '₹10,000–₹20,000 / mo',
    '₹20,000+ / mo',
    'Not sure yet',
  ];

  final List<String> _trainingBudgetOptions = [
    'Under ₹1,000',
    '₹1,000–₹3,000',
    '₹3,000–₹5,000',
    'Not sure yet',
  ];

  final List<String> _designDeadlineOptions = [
    'ASAP',
    'Within a week',
    '2–4 weeks',
    '1–2 months',
    'Flexible',
  ];

  final List<String> _retainerDeadlineOptions = [
    'Start Immediately',
    'Within 1–2 Weeks',
    'Next Month',
    'Flexible',
  ];

  final List<String> _trainingScheduleOptions = [
    'This Week / ASAP',
    'Within 2 Weeks',
    'Flexible Dates',
  ];

  List<String> get _currentProjectTypes {
    switch (_selectedCategory) {
      case FormCategory.training:
        return _trainingProjectTypes;
      case FormCategory.retainer:
        return _retainerProjectTypes;
      case FormCategory.design:
        return _designProjectTypes;
    }
  }

  List<String> get _currentBudgetOptions {
    switch (_selectedCategory) {
      case FormCategory.training:
        return _trainingBudgetOptions;
      case FormCategory.retainer:
        return _retainerBudgetOptions;
      case FormCategory.design:
        return _designBudgetOptions;
    }
  }

  List<String> get _currentDeadlineOptions {
    switch (_selectedCategory) {
      case FormCategory.training:
        return _trainingScheduleOptions;
      case FormCategory.retainer:
        return _retainerDeadlineOptions;
      case FormCategory.design:
        return _designDeadlineOptions;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _organizationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onCategoryChanged(FormCategory category) {
    if (_selectedCategory == category) return;
    setState(() {
      _selectedCategory = category;
      if (_selectedCategory == FormCategory.training) {
        _selectedProjectType = _trainingProjectTypes.first;
        _selectedBudget = 'Not sure yet';
        _selectedDeadline = 'Flexible Dates';
      } else if (_selectedCategory == FormCategory.retainer) {
        _selectedProjectType = _retainerProjectTypes.first;
        _selectedBudget = 'Not sure yet';
        _selectedDeadline = 'Start Immediately';
      } else {
        _selectedProjectType = _designProjectTypes.first;
        _selectedBudget = 'Not sure yet';
        _selectedDeadline = 'Flexible';
      }
    });
  }

  void _sendDirectEmail() {
    final isTraining = _selectedCategory == FormCategory.training;
    final isRetainer = _selectedCategory == FormCategory.retainer;
    final categoryLabel = isTraining
        ? 'Design Training & Workshop'
        : (isRetainer ? 'Monthly Design Retainer' : 'Visual Design Project');
    final subject = Uri.encodeComponent(
      '${isTraining ? "Training Enquiry" : (isRetainer ? "Retainer Enquiry" : "Project Enquiry")}: ${_nameController.text.trim()}',
    );
    final body = Uri.encodeComponent(
      'Category: $categoryLabel\n'
      'Name: ${_nameController.text.trim()}\n'
      'Email: ${_emailController.text.trim()}\n'
      'Organization / Institution: ${_organizationController.text.trim()}\n'
      '${isTraining ? "Topic / Format" : (isRetainer ? "Monthly Volume" : "Project Type")}: $_selectedProjectType\n'
      '${isTraining ? "Budget / Batch Estimate" : (isRetainer ? "Monthly Budget" : "Budget Range")}: $_selectedBudget\n'
      '${isTraining ? "Preferred Schedule" : (isRetainer ? "Start Timeline" : "Deadline")}: $_selectedDeadline\n\n'
      'Details / Goals:\n${_descriptionController.text.trim()}',
    );
    _launchUrl('mailto:${AppConfig.contactEmail}?subject=$subject&body=$body');
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final isTraining = _selectedCategory == FormCategory.training;
    final isRetainer = _selectedCategory == FormCategory.retainer;
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final organization = _organizationController.text.trim();
    final description = _descriptionController.text.trim();
    final categoryStr = isTraining
        ? 'Design Training & Workshop'
        : (isRetainer ? 'Monthly Design Retainer' : 'Visual Design Project');

    // 1. Persist to Supabase Database if available
    if (SupabaseService.isInitialized) {
      await SupabaseService.submitProjectBrief(
        name: name,
        email: email,
        organization: organization,
        category: categoryStr,
        projectType: _selectedProjectType,
        budget: _selectedBudget,
        deadline: _selectedDeadline,
        details: description,
      );
    }

    // 2. Send project brief notification directly to kalaa.png@gmail.com via FormSubmit AJAX endpoint
    try {
      final response = await http.post(
        Uri.parse('https://formsubmit.co/ajax/${AppConfig.contactEmail}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          '_subject':
              '${isTraining ? "New Training Enquiry" : (isRetainer ? "New Retainer Enquiry" : "New Project Brief")}: $name',
          '_template': 'table',
          '_captcha': 'false',
          'Inquiry Category': categoryStr,
          'Name': name,
          'Email': email,
          'Organization / Institution': organization.isEmpty ? 'N/A' : organization,
          isTraining
              ? 'Training Topic / Format'
              : (isRetainer ? 'Monthly Volume' : 'Project Type'): _selectedProjectType,
          isTraining
              ? 'Budget / Batch Estimate'
              : (isRetainer ? 'Monthly Budget' : 'Budget Range'): _selectedBudget,
          isTraining
              ? 'Preferred Schedule'
              : (isRetainer ? 'Start Timeline' : 'Deadline'): _selectedDeadline,
          isTraining
              ? 'Training Goals & Topics'
              : (isRetainer ? 'Retainer Requirements' : 'Project Message'): description,
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
            _errorMessage = 'Failed to send submission. Please use direct email below.';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _errorMessage = 'Network error during submission. Please use direct email below.';
        });
      }
    }
  }

  void _resetForm() {
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _organizationController.clear();
      _descriptionController.clear();
      _selectedCategory = FormCategory.design;
      _selectedProjectType = 'Poster';
      _selectedBudget = 'Not sure yet';
      _selectedDeadline = 'Flexible';
      _isSubmitted = false;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobileOrTablet(context);
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(context);
    final scale = ResponsiveBreakpoints.getTypographyScale(context);
    final isTraining = _selectedCategory == FormCategory.training;
    final isRetainer = _selectedCategory == FormCategory.retainer;

    return Title(
      title: 'Start a Project — ${AppConfig.studioName}',
      color: isDark ? AppColors.bgDark : AppColors.bgLight,
      child: PageScaffold(
        currentPath: '/start',
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
                        ? _buildMobileHero(context, scale, isTraining, isRetainer)
                        : _buildDesktopHero(context, scale, isTraining, isRetainer),
                  ),
                ),
              ),
            ),

            const Divider(color: AppColors.borderLight, height: 1),

            // ── FORM + SIDEBAR ─────────────────────────────────────────
            _ScrollEntranceAnimation(
              staggerIndex: 1,
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
                              _buildFormOrSuccess(isDark, isMobile, scale),
                              const SizedBox(height: 56),
                              _buildWhatHappensNext(isDark, isMobile, scale),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 6,
                                child: _buildFormOrSuccess(isDark, isMobile, scale),
                              ),
                              const SizedBox(width: 64),
                              Expanded(
                                flex: 4,
                                child: _buildWhatHappensNext(isDark, isMobile, scale),
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

  Widget _buildMobileHero(BuildContext context, double scale,
      bool isTraining, bool isRetainer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isTraining
              ? 'BOOK A TRAINING SESSION'
              : (isRetainer ? 'MONTHLY DESIGN PARTNERSHIP' : 'START A PROJECT'),
          style: AppTypography.labelUppercase(
            color: AppColors.textMutedLight,
            scale: scale,
          ).copyWith(letterSpacing: 2.5),
        ),
        const SizedBox(height: 20),
        Text(
          isTraining
              ? "Tell us what you'd like to learn"
              : (isRetainer
                  ? 'Ask about ongoing design support'
                  : "Tell us what you're building"),
          style: AppTypography.heading1(
            color: AppColors.textPrimaryLight,
            scale: scale,
          ).copyWith(fontSize: 30 * scale, height: 1.2),
        ),
        const SizedBox(height: 16),
        Text(
          isTraining
              ? 'Fill out the form below with your learning goals, target software, preferred schedule, and batch size.'
              : (isRetainer
                  ? 'Tell us your monthly graphic requirements, anticipated volume, and priority turnaround expectations.'
                  : 'Fill out the brief below with your project details, scope, and target deadline.'),
          style: AppTypography.bodyLarge(
            color: AppColors.textSecondaryLight,
            scale: scale,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHero(BuildContext context, double scale,
      bool isTraining, bool isRetainer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.posterClay,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              isTraining
                  ? 'BOOK A TRAINING SESSION'
                  : (isRetainer
                      ? 'MONTHLY DESIGN PARTNERSHIP'
                      : 'START A PROJECT'),
              style: AppTypography.labelUppercase(
                color: AppColors.textMutedLight,
                scale: scale,
              ).copyWith(letterSpacing: 2.5),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          isTraining
              ? "Tell us what you'd like to learn"
              : (isRetainer
                  ? 'Ask about ongoing design support'
                  : "Tell us what you're building"),
          style: AppTypography.displayMedium(
            color: AppColors.textPrimaryLight,
            scale: scale,
          ).copyWith(height: 1.05),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Text(
            isTraining
                ? 'Fill out the form below with your learning goals, target software, preferred schedule, and batch size.'
                : (isRetainer
                    ? 'Tell us your monthly graphic requirements, anticipated volume, and priority turnaround expectations.'
                    : 'Fill out the brief below with your project details, scope, and target deadline.'),
            style: AppTypography.bodyLarge(
              color: AppColors.textSecondaryLight,
              scale: scale,
            ),
          ),
        ),
        const SizedBox(height: 28),
        // Metric pills
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            _HeroMetricPill(
              icon: Icons.bolt_rounded,
              label: isTraining ? 'Custom Curriculum' : '24h First Response',
              scale: scale,
            ),
            _HeroMetricPill(
              icon: Icons.folder_zip_outlined,
              label: 'Source Files Included',
              scale: scale,
            ),
            _HeroMetricPill(
              icon: Icons.chat_bubble_outline_rounded,
              label: 'WhatsApp Support',
              scale: scale,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormOrSuccess(bool isDark, bool isMobile, double scale) {
    final isTraining = _selectedCategory == FormCategory.training;
    final isRetainer = _selectedCategory == FormCategory.retainer;

    if (_isSubmitted) {
      return _SubmitSuccessPanel(
        isTraining: isTraining,
        isRetainer: isRetainer,
        onReset: _resetForm,
        onWhatsApp: () =>
            _launchUrl('https://wa.me/${AppConfig.whatsappNumber}'),
        onEmail: () => _launchUrl('mailto:${AppConfig.contactEmail}'),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Category Selector ───────────────────────────────────────
          Text(
            'INQUIRY TYPE',
            style: AppTypography.labelUppercase(
              color: AppColors.textMutedLight,
              scale: scale,
            ).copyWith(letterSpacing: 2.0),
          ),
          const SizedBox(height: 12),
          _CategorySelector(
            selectedCategory: _selectedCategory,
            onChanged: _onCategoryChanged,
            isMobile: isMobile,
            scale: scale,
          ),

          const SizedBox(height: 36),

          // ── Name + Email ─────────────────────────────────────────────
          if (isMobile) ...[
            _StyledTextField(
              controller: _nameController,
              label: 'YOUR NAME',
              hint: 'Alex Morgan',
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
              scale: scale,
            ),
            const SizedBox(height: 20),
            _StyledTextField(
              controller: _emailController,
              label: 'EMAIL ADDRESS',
              hint: 'alex@domain.com',
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Please enter your email';
                if (!v.contains('@') || !v.contains('.')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              scale: scale,
            ),
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _StyledTextField(
                    controller: _nameController,
                    label: 'YOUR NAME',
                    hint: 'Alex Morgan',
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
                    scale: scale,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _StyledTextField(
                    controller: _emailController,
                    label: 'EMAIL ADDRESS',
                    hint: 'alex@domain.com',
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Please enter your email';
                      if (!v.contains('@') || !v.contains('.')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    scale: scale,
                  ),
                ),
              ],
            ),

          const SizedBox(height: 24),

          // ── Organization ─────────────────────────────────────────────
          _StyledTextField(
            controller: _organizationController,
            label: isTraining
                ? 'COLLEGE / INSTITUTION / CLUB / INDIVIDUAL'
                : 'COMPANY / ORGANIZATION / CLUB',
            hint: isTraining
                ? 'e.g. Tech Club, IIT Madras, Design Student, or Self-Learner'
                : 'e.g. Design Club / Tech Startup / Self',
            scale: scale,
          ),

          const SizedBox(height: 32),

          // ── Project Type Chips ───────────────────────────────────────
          Text(
            isTraining
                ? 'TRAINING TOPIC / FORMAT'
                : (isRetainer ? 'ESTIMATED MONTHLY VOLUME' : 'PROJECT TYPE'),
            style: AppTypography.labelUppercase(
              color: AppColors.textMutedLight,
              scale: scale,
            ).copyWith(letterSpacing: 2.0),
          ),
          const SizedBox(height: 12),
          _AnimatedChipGroup(
            options: _currentProjectTypes,
            selectedValue: _selectedProjectType,
            onSelected: (v) => setState(() => _selectedProjectType = v),
            scale: scale,
            accentSelect: true,
          ),

          const SizedBox(height: 28),

          // ── Budget Chips ─────────────────────────────────────────────
          Text(
            isTraining
                ? 'BUDGET / BATCH ESTIMATE'
                : (isRetainer ? 'MONTHLY PLAN BUDGET' : 'BUDGET RANGE'),
            style: AppTypography.labelUppercase(
              color: AppColors.textMutedLight,
              scale: scale,
            ).copyWith(letterSpacing: 2.0),
          ),
          const SizedBox(height: 12),
          _AnimatedChipGroup(
            options: _currentBudgetOptions,
            selectedValue: _selectedBudget,
            onSelected: (v) => setState(() => _selectedBudget = v),
            scale: scale,
            accentSelect: false,
          ),

          const SizedBox(height: 28),

          // ── Deadline/Schedule Chips ──────────────────────────────────
          Text(
            isTraining
                ? 'PREFERRED TRAINING SCHEDULE'
                : (isRetainer ? 'TARGET START DATE' : 'TIMELINE / DEADLINE'),
            style: AppTypography.labelUppercase(
              color: AppColors.textMutedLight,
              scale: scale,
            ).copyWith(letterSpacing: 2.0),
          ),
          const SizedBox(height: 12),
          _AnimatedChipGroup(
            options: _currentDeadlineOptions,
            selectedValue: _selectedDeadline,
            onSelected: (v) => setState(() => _selectedDeadline = v),
            scale: scale,
            accentSelect: false,
          ),

          const SizedBox(height: 28),

          // ── Description ──────────────────────────────────────────────
          _StyledTextField(
            controller: _descriptionController,
            label: isTraining
                ? 'TRAINING GOALS & SPECIFIC TOPICS *'
                : (isRetainer
                    ? 'RETAINER SCOPE & DESIGN REQUIREMENTS *'
                    : 'PROJECT DESCRIPTION & GOALS *'),
            hint: isTraining
                ? 'What tools or skills do you want to learn? (e.g. Photoshop layers, poster composition, Figma UI, 1-on-1 or group size, preferred duration).'
                : (isRetainer
                    ? 'Tell us about your organization or club, weekly design volume needed, turnarounds required, and preferred workflow.'
                    : 'What are you creating? Mention event details, visual preferences, key dates or goals.'),
            maxLines: 5,
            validator: (v) {
              if (v == null || v.trim().length < 10) {
                return isTraining
                    ? 'Please describe your learning goals (at least 10 characters)'
                    : (isRetainer
                        ? 'Please describe your recurring design requirements (at least 10 characters)'
                        : 'Please provide a short description (at least 10 characters)');
              }
              return null;
            },
            scale: scale,
          ),

          // ── Pre-submit Summary ────────────────────────────────────────
          if (_selectedProjectType.isNotEmpty) ...[
            const SizedBox(height: 20),
            _PreSubmitSummary(
              category: _selectedCategory,
              projectType: _selectedProjectType,
              budget: _selectedBudget,
              deadline: _selectedDeadline,
              scale: scale,
            ),
          ],

          // ── Error Message ─────────────────────────────────────────────
          if (_errorMessage != null) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.redAccent.withValues(alpha: 0.06),
                border: Border.all(
                  color: Colors.redAccent.withValues(alpha: 0.4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.error_outline_rounded,
                          color: Colors.redAccent, size: 18),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style:
                              AppTypography.bodySmall(color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _sendDirectEmail,
                    child: Text(
                      'Send via Email App directly →',
                      style: AppTypography.buttonText(color: Colors.redAccent)
                          .copyWith(decoration: TextDecoration.underline, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 28),

          // ── Submit Button ─────────────────────────────────────────────
          _PremiumSubmitButton(
            isLoading: _isSubmitting,
            label: isTraining
                ? 'Submit Training Enquiry'
                : (isRetainer ? 'Submit Retainer Request' : 'Submit Project Brief'),
            onTap: _isSubmitting ? null : _submitForm,
            scale: scale,
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

  Widget _buildWhatHappensNext(bool isDark, bool isMobile, double scale) {
    final isTraining = _selectedCategory == FormCategory.training;

    final steps = isTraining
        ? [
            _TimelineStep(
              number: '01',
              title: 'Goals & Skill Assessment',
              description:
                  'We evaluate your requested topics, current skill level, and schedule preferences.',
            ),
            _TimelineStep(
              number: '02',
              title: 'Customized Syllabus & Quote',
              description:
                  'Within 24 hours, you receive a custom workshop curriculum, live session schedule, and pricing.',
            ),
            _TimelineStep(
              number: '03',
              title: 'Interactive Training & Resources',
              description:
                  'Hands-on live training conducted, accompanied by practice files, design templates, and Q&A.',
            ),
          ]
        : [
            _TimelineStep(
              number: '01',
              title: 'Brief Review',
              description:
                  'We carefully review your goals, deliverables, and timeline requirements.',
            ),
            _TimelineStep(
              number: '02',
              title: 'Initial Proposal',
              description:
                  'Within 24 hours, you receive a clear project quote and suggested direction.',
            ),
            _TimelineStep(
              number: '03',
              title: 'Production & Delivery',
              description:
                  'Designs are created in Figma/Photoshop, shared for feedback, and delivered print-ready.',
            ),
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── WHAT HAPPENS NEXT PANEL ─────────────────────────────
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.bgLight,
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header strip
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: const BoxDecoration(
                  color: AppColors.textPrimaryLight,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.route_rounded, color: Colors.white, size: 16),
                    const SizedBox(width: 10),
                    Text(
                      'WHAT HAPPENS NEXT',
                      style: AppTypography.labelUppercase(
                        color: Colors.white,
                        scale: scale,
                      ).copyWith(letterSpacing: 2.0, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),

              // Steps
              Padding(
                padding: EdgeInsets.all(isMobile ? 20.0 : 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...steps.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final step = entry.value;
                      final isLast = idx == steps.length - 1;
                      return _TimelineItem(step: step, isLast: isLast, scale: scale);
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ── PROMISE CARD ────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            border: Border(
              left: const BorderSide(color: AppColors.posterClay, width: 3),
              top: BorderSide(color: AppColors.borderLight),
              right: BorderSide(color: AppColors.borderLight),
              bottom: BorderSide(color: AppColors.borderLight),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.bolt_rounded, size: 14, color: AppColors.posterClay),
                  const SizedBox(width: 6),
                  Text(
                    'OUR PROMISE',
                    style: AppTypography.labelUppercase(
                      color: AppColors.posterClay,
                      scale: scale,
                    ).copyWith(letterSpacing: 2.0, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                isTraining
                    ? 'Every session is hands-on, tailored, and comes with practice files you keep forever.'
                    : 'First reply within 24h. No vague timelines — just clear scope, fast delivery, and source files.',
                style: AppTypography.bodySmall(
                  color: AppColors.textSecondaryLight,
                  scale: scale,
                ).copyWith(height: 1.55, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ── WHATSAPP BEFORE FILLING ─────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Have questions before filling out?',
                style: AppTypography.bodySmall(
                  color: AppColors.textMutedLight,
                  scale: scale,
                ).copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              _WhatsAppQuickButton(
                onTap: () =>
                    _launchUrl('https://wa.me/${AppConfig.whatsappNumber}'),
                scale: scale,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── CATEGORY SELECTOR ─────────────────────────────────────────────────────────

class _CategorySelector extends StatelessWidget {
  final FormCategory selectedCategory;
  final ValueChanged<FormCategory> onChanged;
  final bool isMobile;
  final double scale;

  const _CategorySelector({
    required this.selectedCategory,
    required this.onChanged,
    required this.isMobile,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      (FormCategory.design, Icons.palette_outlined, 'Design Project'),
      (FormCategory.retainer, Icons.repeat_rounded, 'Monthly Plan'),
      (FormCategory.training, Icons.school_outlined, 'Training'),
    ];

    if (isMobile) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderLight),
          color: AppColors.surfaceLight,
        ),
        padding: const EdgeInsets.all(4),
        child: Column(
          children: categories
              .map((cat) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: _CategoryTabItem(
                      icon: cat.$2,
                      label: cat.$3,
                      isSelected: selectedCategory == cat.$1,
                      onTap: () => onChanged(cat.$1),
                      scale: scale,
                      expand: true,
                    ),
                  ))
              .toList(),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderLight),
        color: AppColors.surfaceLight,
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: categories
            .expand((cat) => [
                  Expanded(
                    child: _CategoryTabItem(
                      icon: cat.$2,
                      label: cat.$3,
                      isSelected: selectedCategory == cat.$1,
                      onTap: () => onChanged(cat.$1),
                      scale: scale,
                      expand: false,
                    ),
                  ),
                  if (cat.$1 != FormCategory.training) const SizedBox(width: 4),
                ])
            .toList(),
      ),
    );
  }
}

class _CategoryTabItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double scale;
  final bool expand;

  const _CategoryTabItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.scale,
    required this.expand,
  });

  @override
  State<_CategoryTabItem> createState() => _CategoryTabItemState();
}

class _CategoryTabItemState extends State<_CategoryTabItem> {
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
          duration: const Duration(milliseconds: 200),
          width: widget.expand ? double.infinity : null,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? AppColors.textPrimaryLight
                : (_isHovered ? AppColors.surfaceSubtleLight : Colors.transparent),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 17,
                color: widget.isSelected
                    ? Colors.white
                    : AppColors.textSecondaryLight,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  widget.label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buttonText(
                    color: widget.isSelected
                        ? Colors.white
                        : AppColors.textPrimaryLight,
                    scale: widget.scale,
                  ).copyWith(fontSize: 13 * widget.scale),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── STYLED TEXT FIELD ─────────────────────────────────────────────────────────

class _StyledTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final int maxLines;
  final double scale;

  const _StyledTextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.maxLines = 1,
    required this.scale,
  });

  @override
  State<_StyledTextField> createState() => _StyledTextFieldState();
}

class _StyledTextFieldState extends State<_StyledTextField> {
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
          ).copyWith(letterSpacing: 1.5, fontSize: 10.5 * widget.scale),
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
              color: const Color(0xFFCBD5E1),
            ),
            filled: true,
            fillColor: _isFocused ? AppColors.bgLight : AppColors.surfaceLight,
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
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}

// ── ANIMATED CHIP GROUP ───────────────────────────────────────────────────────

class _AnimatedChipGroup extends StatelessWidget {
  final List<String> options;
  final String selectedValue;
  final ValueChanged<String> onSelected;
  final double scale;
  final bool accentSelect;

  const _AnimatedChipGroup({
    required this.options,
    required this.selectedValue,
    required this.onSelected,
    required this.scale,
    required this.accentSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = selectedValue == option;
        return _AnimatedChip(
          label: option,
          isSelected: isSelected,
          onTap: () => onSelected(option),
          scale: scale,
          accentSelect: accentSelect,
        );
      }).toList(),
    );
  }
}

class _AnimatedChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double scale;
  final bool accentSelect;

  const _AnimatedChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.scale,
    required this.accentSelect,
  });

  @override
  State<_AnimatedChip> createState() => _AnimatedChipState();
}

class _AnimatedChipState extends State<_AnimatedChip>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _pulse;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  void _handleTap() async {
    await _pulse.forward();
    await _pulse.reverse();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final selectedBg = widget.accentSelect
        ? AppColors.textPrimaryLight
        : AppColors.textPrimaryLight;
    final selectedText = Colors.white;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _handleTap,
        child: ScaleTransition(
          scale: _scaleAnim,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? selectedBg
                  : (_isHovered
                      ? AppColors.surfaceSubtleLight
                      : AppColors.surfaceLight),
              border: Border.all(
                color: widget.isSelected
                    ? selectedBg
                    : (_isHovered
                        ? AppColors.textPrimaryLight
                        : AppColors.borderLight),
                width: widget.isSelected ? 1.5 : 1.0,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              widget.label,
              style: AppTypography.buttonText(
                color: widget.isSelected
                    ? selectedText
                    : AppColors.textPrimaryLight,
                scale: widget.scale,
              ).copyWith(fontSize: 13 * widget.scale),
            ),
          ),
        ),
      ),
    );
  }
}

// ── PRE-SUBMIT SUMMARY ────────────────────────────────────────────────────────

class _PreSubmitSummary extends StatelessWidget {
  final FormCategory category;
  final String projectType;
  final String budget;
  final String deadline;
  final double scale;

  const _PreSubmitSummary({
    required this.category,
    required this.projectType,
    required this.budget,
    required this.deadline,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final categoryLabel = category == FormCategory.training
        ? 'Training'
        : (category == FormCategory.retainer ? 'Monthly Retainer' : 'Design Project');

    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          border: Border(
            left: const BorderSide(
              color: AppColors.textPrimaryLight,
              width: 3,
            ),
            top: BorderSide(color: AppColors.borderLight),
            right: BorderSide(color: AppColors.borderLight),
            bottom: BorderSide(color: AppColors.borderLight),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'YOUR SELECTION',
              style: AppTypography.labelUppercase(
                color: AppColors.textMutedLight,
                scale: scale,
              ).copyWith(fontSize: 10, letterSpacing: 1.5),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _SummaryChip(label: categoryLabel),
                _SummaryChip(label: projectType),
                _SummaryChip(label: budget),
                _SummaryChip(label: deadline),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label;
  const _SummaryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubtleLight,
        border: Border.all(color: AppColors.borderLight),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        label,
        style: AppTypography.bodySmall(
          color: AppColors.textSecondaryLight,
        ).copyWith(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}

// ── TIMELINE ──────────────────────────────────────────────────────────────────

class _TimelineStep {
  final String number;
  final String title;
  final String description;
  const _TimelineStep({
    required this.number,
    required this.title,
    required this.description,
  });
}

class _TimelineItem extends StatelessWidget {
  final _TimelineStep step;
  final bool isLast;
  final double scale;

  const _TimelineItem({
    required this.step,
    required this.isLast,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline column
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.textPrimaryLight,
                shape: BoxShape.circle,
              ),
              child: Text(
                step.number,
                style: AppTypography.labelUppercase(
                  color: Colors.white,
                ).copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 1.5,
                height: 40,
                color: AppColors.borderLight,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  step.title,
                  style: AppTypography.heading3(
                    color: AppColors.textPrimaryLight,
                    scale: scale,
                  ).copyWith(fontSize: 15 * scale),
                ),
                const SizedBox(height: 4),
                Text(
                  step.description,
                  style: AppTypography.bodySmall(
                    color: AppColors.textSecondaryLight,
                    scale: scale,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


// ── WHATSAPP QUICK BUTTON ─────────────────────────────────────────────────────

class _WhatsAppQuickButton extends StatefulWidget {
  final VoidCallback onTap;
  final double scale;
  const _WhatsAppQuickButton({required this.onTap, required this.scale});

  @override
  State<_WhatsAppQuickButton> createState() => _WhatsAppQuickButtonState();
}

class _WhatsAppQuickButtonState extends State<_WhatsAppQuickButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.textPrimaryLight : Colors.transparent,
            border: Border.all(
              color: _isHovered ? AppColors.textPrimaryLight : AppColors.borderLight,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.chat_bubble_outline_rounded,
                size: 15,
                color: _isHovered ? Colors.white : AppColors.textSecondaryLight,
              ),
              const SizedBox(width: 8),
              Text(
                'Chat on WhatsApp',
                style: AppTypography.buttonText(
                  color: _isHovered ? Colors.white : AppColors.textPrimaryLight,
                  scale: widget.scale,
                ).copyWith(fontSize: 13 * widget.scale),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── PREMIUM SUBMIT BUTTON ─────────────────────────────────────────────────────

class _PremiumSubmitButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback? onTap;
  final String label;
  final double scale;

  const _PremiumSubmitButton({
    required this.isLoading,
    required this.onTap,
    required this.label,
    required this.scale,
  });

  @override
  State<_PremiumSubmitButton> createState() => _PremiumSubmitButtonState();
}

class _PremiumSubmitButtonState extends State<_PremiumSubmitButton> {
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
          padding: const EdgeInsets.symmetric(vertical: 20),
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
                      style: AppTypography.buttonText(
                        color: Colors.white,
                        scale: widget.scale,
                      ),
                    ),
                    const SizedBox(width: 12),
                    AnimatedSlide(
                      offset: _isHovered
                          ? const Offset(0.2, 0)
                          : Offset.zero,
                      duration: const Duration(milliseconds: 180),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 17,
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

// ── SUBMIT SUCCESS PANEL ──────────────────────────────────────────────────────

class _SubmitSuccessPanel extends StatefulWidget {
  final bool isTraining;
  final bool isRetainer;
  final VoidCallback onReset;
  final VoidCallback onWhatsApp;
  final VoidCallback onEmail;

  const _SubmitSuccessPanel({
    required this.isTraining,
    required this.isRetainer,
    required this.onReset,
    required this.onWhatsApp,
    required this.onEmail,
  });

  @override
  State<_SubmitSuccessPanel> createState() => _SubmitSuccessPanelState();
}

class _SubmitSuccessPanelState extends State<_SubmitSuccessPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _scaleAnim = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
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
    final title = widget.isTraining
        ? 'Training Enquiry Received!'
        : (widget.isRetainer
            ? 'Retainer Enquiry Received!'
            : 'Project Brief Received!');
    final message = widget.isTraining
        ? 'Thank you for your training enquiry. We will review your learning goals and respond within 24 hours with a custom session outline and schedule options.'
        : (widget.isRetainer
            ? 'Thank you for asking about monthly design support. We will review your requirements and reach out within 24 hours to discuss retainer scope, slots, and workflow.'
            : 'Thank you for sharing your project details. We typically review briefs and respond within 24 hours with timeline estimates and initial concepts.');
    final resetLabel = widget.isTraining
        ? 'Submit another enquiry'
        : (widget.isRetainer
            ? 'Submit another retainer request'
            : 'Submit another brief');

    return FadeTransition(
      opacity: _fadeAnim,
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaleTransition(
              scale: _scaleAnim,
              child: Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: AppColors.textPrimaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              title,
              style: AppTypography.heading1(
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: AppTypography.bodyLarge(
                color: AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _OutlineBtn(label: resetLabel, onTap: widget.onReset),
                _OutlineBtn(label: 'WhatsApp us →', onTap: widget.onWhatsApp),
                _OutlineBtn(label: 'Email us →', onTap: widget.onEmail),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OutlineBtn extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _OutlineBtn({required this.label, required this.onTap});

  @override
  State<_OutlineBtn> createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<_OutlineBtn> {
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

// ── HERO METRIC PILL ─────────────────────────────────────────────────────────

class _HeroMetricPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final double scale;

  const _HeroMetricPill({
    required this.icon,
    required this.label,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        border: Border.all(color: AppColors.borderLight),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.posterClay),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTypography.bodySmall(
              color: AppColors.textSecondaryLight,
              scale: scale,
            ).copyWith(
              fontSize: 12 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
