import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';
import '../../widgets/layout/page_scaffold.dart';

enum FormCategory { design, training }

class StartProjectScreen extends StatefulWidget {
  const StartProjectScreen({super.key});

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
    'Social Media',
    'Event / College',
    'Startup',
    'Branding',
    'Presentation',
    'Business Design',
    'Other Design',
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

  final List<String> _trainingScheduleOptions = [
    'This Week / ASAP',
    'Within 2 Weeks',
    'Flexible Dates',
  ];

  List<String> get _currentProjectTypes =>
      _selectedCategory == FormCategory.training
      ? _trainingProjectTypes
      : _designProjectTypes;

  List<String> get _currentBudgetOptions =>
      _selectedCategory == FormCategory.training
      ? _trainingBudgetOptions
      : _designBudgetOptions;

  List<String> get _currentDeadlineOptions =>
      _selectedCategory == FormCategory.training
      ? _trainingScheduleOptions
      : _designDeadlineOptions;

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
      } else {
        _selectedProjectType = _designProjectTypes.first;
        _selectedBudget = 'Not sure yet';
        _selectedDeadline = 'Flexible';
      }
    });
  }

  void _sendDirectEmail() {
    final isTraining = _selectedCategory == FormCategory.training;
    final subject = Uri.encodeComponent(
      '${isTraining ? "Training Enquiry" : "Project Enquiry"}: ${_nameController.text.trim()}',
    );
    final body = Uri.encodeComponent(
      'Category: ${isTraining ? "Design Training & Workshop" : "Visual Design Project"}\n'
      'Name: ${_nameController.text.trim()}\n'
      'Email: ${_emailController.text.trim()}\n'
      'Organization / Institution: ${_organizationController.text.trim()}\n'
      '${isTraining ? "Topic / Format" : "Project Type"}: $_selectedProjectType\n'
      '${isTraining ? "Budget / Batch Estimate" : "Budget Range"}: $_selectedBudget\n'
      '${isTraining ? "Preferred Schedule" : "Deadline"}: $_selectedDeadline\n\n'
      'Details / Goals:\n${_descriptionController.text.trim()}',
    );
    _launchUrl('mailto:${AppConfig.contactEmail}?subject=$subject&body=$body');
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final isTraining = _selectedCategory == FormCategory.training;

    try {
      final response = await http.post(
        Uri.parse('https://formsubmit.co/ajax/${AppConfig.formSubmitHash}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          '_subject':
              '${isTraining ? "New Training Enquiry" : "New Project Brief"}: ${_nameController.text.trim()}',
          '_template': 'table',
          'Inquiry Category': isTraining
              ? 'Design Training & Workshop'
              : 'Visual Design Project',
          'Name': _nameController.text.trim(),
          'Email': _emailController.text.trim(),
          'Organization / Institution':
              _organizationController.text.trim().isEmpty
              ? 'N/A'
              : _organizationController.text.trim(),
          isTraining ? 'Training Topic / Format' : 'Project Type':
              _selectedProjectType,
          isTraining ? 'Budget / Batch Estimate' : 'Budget Range':
              _selectedBudget,
          isTraining ? 'Preferred Schedule' : 'Deadline': _selectedDeadline,
          isTraining ? 'Training Goals & Topics' : 'Project Message':
              _descriptionController.text.trim(),
        }),
      );

      Map<String, dynamic> data = {};
      try {
        data = jsonDecode(response.body);
      } catch (_) {}

      final isSuccess = data['success'] == 'true' || data['success'] == true;
      final serverMsg = data['message']?.toString() ?? '';

      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          isSuccess) {
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
                'Failed to send submission. Please use direct email below.';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _errorMessage =
              'Network error during submission. Please use direct email below.';
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
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(
      context,
    );
    final scale = ResponsiveBreakpoints.getTypographyScale(context);
    final isTraining = _selectedCategory == FormCategory.training;

    return Title(
      title: 'Start a Project — StudioProof',
      color: isDark ? AppColors.bgDark : AppColors.bgLight,
      child: PageScaffold(
        currentPath: '/start',
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: horizontalPadding,
                right: horizontalPadding,
                top: isMobile ? 36.0 : 64.0,
                bottom: 32.0,
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: ResponsiveBreakpoints.maxContentWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isTraining
                            ? 'BOOK A TRAINING SESSION'
                            : 'START A PROJECT',
                        style: AppTypography.labelUppercase(
                          color: AppColors.accent,
                          scale: scale,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        isTraining
                            ? 'Tell us what you’d like to learn'
                            : 'Tell us what you’re building',
                        style: isMobile
                            ? AppTypography.heading1(
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                              )
                            : AppTypography.displayLarge(
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                              ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        isTraining
                            ? 'Fill out the form below with your learning goals, target software, preferred schedule, and batch size.'
                            : 'Fill out the brief below with your project details, scope, and target deadline.',
                        style: AppTypography.bodyLarge(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Divider(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
              height: 1,
            ),

            // Brief Builder Form Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 36.0 : 64.0,
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
                            _buildFormOrSuccess(isDark, isMobile),
                            const SizedBox(height: 48),
                            _buildBriefGuidelines(isDark, isMobile),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 6,
                              child: _buildFormOrSuccess(isDark, isMobile),
                            ),
                            const SizedBox(width: 64),
                            Expanded(
                              flex: 4,
                              child: _buildBriefGuidelines(isDark, isMobile),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector(bool isDark, bool isMobile) {
    if (isMobile) {
      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Column(
          children: [
            _CategoryTabButton(
              icon: Icons.palette_outlined,
              label: 'Design Project',
              isSelected: _selectedCategory == FormCategory.design,
              onTap: () => _onCategoryChanged(FormCategory.design),
              isDark: isDark,
            ),
            const SizedBox(height: 4),
            _CategoryTabButton(
              icon: Icons.school_outlined,
              label: 'Training / Workshop',
              isSelected: _selectedCategory == FormCategory.training,
              onTap: () => _onCategoryChanged(FormCategory.training),
              isDark: isDark,
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _CategoryTabButton(
              icon: Icons.palette_outlined,
              label: 'Design Project',
              isSelected: _selectedCategory == FormCategory.design,
              onTap: () => _onCategoryChanged(FormCategory.design),
              isDark: isDark,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _CategoryTabButton(
              icon: Icons.school_outlined,
              label: 'Training / Workshop',
              isSelected: _selectedCategory == FormCategory.training,
              onTap: () => _onCategoryChanged(FormCategory.training),
              isDark: isDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormOrSuccess(bool isDark, bool isMobile) {
    final isTraining = _selectedCategory == FormCategory.training;

    if (_isSubmitted) {
      return Container(
        padding: const EdgeInsets.all(36.0),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          border: Border.all(color: AppColors.accent, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              size: 48,
              color: AppColors.accent,
            ),
            const SizedBox(height: 24),
            Text(
              isTraining
                  ? 'Training Enquiry Received!'
                  : 'Project Brief Received!',
              style: AppTypography.heading1(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isTraining
                  ? 'Thank you for your training enquiry. We will review your learning goals and respond within 24 hours with a custom session outline and schedule options.'
                  : 'Thank you for sharing your project details. We typically review briefs and respond within 24 hours with timeline estimates and initial concepts.',
              style: AppTypography.bodyLarge(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: _resetForm,
              style: OutlinedButton.styleFrom(
                foregroundColor: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                side: BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
              ),
              child: Text(
                isTraining ? 'Submit another enquiry' : 'Submit another brief',
                style: AppTypography.buttonText(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final nameField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR NAME *',
          style: AppTypography.labelUppercase(
            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _nameController,
          style: AppTypography.bodyMedium(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
          decoration: _inputDecoration(isDark, hint: 'Alex Morgan'),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
      ],
    );

    final emailField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EMAIL ADDRESS *',
          style: AppTypography.labelUppercase(
            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailController,
          style: AppTypography.bodyMedium(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
          decoration: _inputDecoration(isDark, hint: 'alex@domain.com'),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your email';
            }
            if (!value.contains('@') || !value.contains('.')) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
      ],
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Selector Switcher
          Text(
            'INQUIRY TYPE',
            style: AppTypography.labelUppercase(
              color: isDark
                  ? AppColors.textMutedDark
                  : AppColors.textMutedLight,
            ),
          ),
          const SizedBox(height: 10),
          _buildCategorySelector(isDark, isMobile),

          const SizedBox(height: 28),

          if (isMobile) ...[
            nameField,
            const SizedBox(height: 20),
            emailField,
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: nameField),
                const SizedBox(width: 20),
                Expanded(child: emailField),
              ],
            ),

          const SizedBox(height: 24),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isTraining
                    ? 'COLLEGE / INSTITUTION / CLUB / INDIVIDUAL'
                    : 'COMPANY / ORGANIZATION / CLUB',
                style: AppTypography.labelUppercase(
                  color: isDark
                      ? AppColors.textMutedDark
                      : AppColors.textMutedLight,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _organizationController,
                style: AppTypography.bodyMedium(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
                decoration: _inputDecoration(
                  isDark,
                  hint: isTraining
                      ? 'e.g. Tech Club, IIT Madras, Design Student, or Self-Learner'
                      : 'e.g. Design Club / Tech Startup / Self',
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          Text(
            isTraining ? 'TRAINING TOPIC / FORMAT' : 'PROJECT TYPE',
            style: AppTypography.labelUppercase(
              color: isDark
                  ? AppColors.textMutedDark
                  : AppColors.textMutedLight,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _currentProjectTypes.map((type) {
              final isSelected = _selectedProjectType == type;
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => setState(() => _selectedProjectType = type),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.accent
                          : (isDark
                                ? AppColors.surfaceDark
                                : AppColors.surfaceLight),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.accent
                            : (isDark
                                  ? AppColors.borderDark
                                  : AppColors.borderLight),
                      ),
                    ),
                    child: Text(
                      type,
                      style: AppTypography.buttonText(
                        color: isSelected
                            ? Colors.white
                            : (isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),

          Text(
            isTraining ? 'BUDGET / BATCH ESTIMATE' : 'BUDGET RANGE',
            style: AppTypography.labelUppercase(
              color: isDark
                  ? AppColors.textMutedDark
                  : AppColors.textMutedLight,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _currentBudgetOptions.map((budget) {
              final isSelected = _selectedBudget == budget;
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => setState(() => _selectedBudget = budget),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight)
                          : (isDark
                                ? AppColors.surfaceDark
                                : AppColors.surfaceLight),
                      border: Border.all(
                        color: isSelected
                            ? (isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight)
                            : (isDark
                                  ? AppColors.borderDark
                                  : AppColors.borderLight),
                      ),
                    ),
                    child: Text(
                      budget,
                      style: AppTypography.buttonText(
                        color: isSelected
                            ? (isDark ? AppColors.bgDark : AppColors.bgLight)
                            : (isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),

          Text(
            isTraining ? 'PREFERRED TRAINING SCHEDULE' : 'TIMELINE / DEADLINE',
            style: AppTypography.labelUppercase(
              color: isDark
                  ? AppColors.textMutedDark
                  : AppColors.textMutedLight,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _currentDeadlineOptions.map((deadline) {
              final isSelected = _selectedDeadline == deadline;
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => setState(() => _selectedDeadline = deadline),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight)
                          : (isDark
                                ? AppColors.surfaceDark
                                : AppColors.surfaceLight),
                      border: Border.all(
                        color: isSelected
                            ? (isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight)
                            : (isDark
                                  ? AppColors.borderDark
                                  : AppColors.borderLight),
                      ),
                    ),
                    child: Text(
                      deadline,
                      style: AppTypography.buttonText(
                        color: isSelected
                            ? (isDark ? AppColors.bgDark : AppColors.bgLight)
                            : (isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),

          Text(
            isTraining
                ? 'TRAINING GOALS & SPECIFIC TOPICS *'
                : 'PROJECT DESCRIPTION & GOALS *',
            style: AppTypography.labelUppercase(
              color: isDark
                  ? AppColors.textMutedDark
                  : AppColors.textMutedLight,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _descriptionController,
            maxLines: 5,
            style: AppTypography.bodyMedium(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
            decoration: _inputDecoration(
              isDark,
              hint: isTraining
                  ? 'What tools or skills do you want to learn? (e.g. Photoshop layers, poster composition, Figma UI, 1-on-1 or group size, preferred duration).'
                  : 'What are you creating? Mention event details, visual preferences, key dates or deliverables.',
            ),
            validator: (value) {
              if (value == null || value.trim().length < 10) {
                return isTraining
                    ? 'Please describe your learning goals (at least 10 characters)'
                    : 'Please provide a short description (at least 10 characters)';
              }
              return null;
            },
          ),

          if (_errorMessage != null) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.redAccent.withValues(alpha: 0.1),
                border: Border.all(color: Colors.redAccent),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: AppTypography.bodySmall(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: _sendDirectEmail,
                    icon: const Icon(
                      Icons.email_outlined,
                      size: 16,
                      color: Colors.redAccent,
                    ),
                    label: Text(
                      'Send via Email App directly →',
                      style: AppTypography.buttonText(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      isTraining
                          ? 'Submit training enquiry →'
                          : 'Submit project brief →',
                      style: AppTypography.buttonText(color: Colors.white),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'By submitting this form, you agree to our Privacy Policy & Terms.',
            style: AppTypography.bodySmall(
              color: isDark
                  ? AppColors.textMutedDark
                  : AppColors.textMutedLight,
            ).copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildBriefGuidelines(bool isDark, bool isMobile) {
    final isTraining = _selectedCategory == FormCategory.training;

    return Container(
      padding: EdgeInsets.all(isMobile ? 24.0 : 32.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WHAT HAPPENS NEXT',
            style: AppTypography.labelUppercase(color: AppColors.accent),
          ),
          const SizedBox(height: 16),
          Text(
            isTraining ? '1. Goals & Skill Assessment' : '1. Brief Review',
            style: AppTypography.heading3(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isTraining
                ? 'We evaluate your requested topics, current skill level, and schedule preferences.'
                : 'We carefully review your goals, deliverables, and timeline requirements.',
            style: AppTypography.bodySmall(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            isTraining
                ? '2. Customized Syllabus & Quote'
                : '2. Initial Proposal',
            style: AppTypography.heading3(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isTraining
                ? 'Within 24 hours, you receive a custom workshop curriculum, live session schedule, and pricing.'
                : 'Within 24 hours, you receive a clear project quote and suggested direction.',
            style: AppTypography.bodySmall(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            isTraining
                ? '3. Interactive Training & Resources'
                : '3. Production & Delivery',
            style: AppTypography.heading3(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isTraining
                ? 'Hands-on live training conducted, accompanied by practice files, design templates, and Q&A.'
                : 'Designs are created in Figma/Photoshop, shared for feedback, and delivered print-ready.',
            style: AppTypography.bodySmall(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(bool isDark, {required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTypography.bodyMedium(
        color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
      ),
      filled: true,
      fillColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      contentPadding: const EdgeInsets.all(16.0),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
        borderRadius: BorderRadius.zero,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: isDark
              ? AppColors.borderHoverDark
              : AppColors.borderHoverLight,
          width: 1.5,
        ),
        borderRadius: BorderRadius.zero,
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.zero,
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
        borderRadius: BorderRadius.zero,
      ),
    );
  }
}

class _CategoryTabButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _CategoryTabButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.accent : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected
                    ? Colors.white
                    : (isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: AppTypography.buttonText(
                    color: isSelected
                        ? Colors.white
                        : (isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
