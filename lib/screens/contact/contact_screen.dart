import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../core/config/app_config.dart';
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
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedProjectType = 'Poster';
  String _selectedBudget = 'Not sure yet';
  String _selectedDeadline = 'Flexible';

  bool _isSubmitting = false;
  bool _isSubmitted = false;
  String? _errorMessage;

  final List<String> _projectTypes = [
    'Poster',
    'Social Media',
    'Event / College',
    'Startup',
    'Branding',
    'Presentation',
    'Business Design',
    'Other',
  ];

  final List<String> _budgetOptions = [
    'Under ₹1,000',
    '₹1,000–₹3,000',
    '₹3,000–₹5,000',
    '₹5,000–₹10,000',
    '₹10,000+',
    'Not sure yet',
  ];

  final List<String> _deadlineOptions = [
    'ASAP',
    'Within a week',
    '2–4 weeks',
    '1–2 months',
    'Flexible',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _organizationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _sendDirectEmail() {
    final subject = Uri.encodeComponent('Project Enquiry: ${_nameController.text.trim()}');
    final body = Uri.encodeComponent(
      'Name: ${_nameController.text.trim()}\n'
      'Email: ${_emailController.text.trim()}\n'
      'Organization: ${_organizationController.text.trim()}\n'
      'Project Type: $_selectedProjectType\n'
      'Budget: $_selectedBudget\n'
      'Deadline: $_selectedDeadline\n\n'
      'Message:\n${_descriptionController.text.trim()}',
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

    try {
      final response = await http.post(
        Uri.parse('https://formsubmit.co/ajax/${AppConfig.contactEmail}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          '_subject': 'New Project Enquiry: ${_nameController.text.trim()}',
          '_template': 'table',
          'Name': _nameController.text.trim(),
          'Email': _emailController.text.trim(),
          'Organization / Club': _organizationController.text.trim().isEmpty
              ? 'N/A'
              : _organizationController.text.trim(),
          'Project Type': _selectedProjectType,
          'Budget Range': _selectedBudget,
          'Deadline': _selectedDeadline,
          'Message': _descriptionController.text.trim(),
        }),
      );

      Map<String, dynamic> data = {};
      try {
        data = jsonDecode(response.body);
      } catch (_) {}

      final isSuccess = data['success'] == 'true' || data['success'] == true;
      final serverMsg = data['message']?.toString() ?? '';

      if (response.statusCode >= 200 && response.statusCode < 300 && isSuccess) {
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
          if (serverMsg.toLowerCase().contains('activation') || serverMsg.toLowerCase().contains('activate')) {
            _errorMessage =
                'Form activation required! FormSubmit sent an email to ${AppConfig.contactEmail}. Please open your email inbox, click "Activate Form" in that email, and then click "Send enquiry" again.';
          } else if (serverMsg.isNotEmpty) {
            _errorMessage = serverMsg;
          } else {
            _errorMessage =
                'Failed to send message automatically. Please check your connection or use the direct email button below.';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _errorMessage =
              'Network error during submission. Please check your connection or use the direct email button below.';
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
      _selectedProjectType = 'Poster';
      _selectedBudget = 'Not sure yet';
      _selectedDeadline = 'Flexible';
      _isSubmitted = false;
      _errorMessage = null;
    });
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobile(context);
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(context);
    final scale = ResponsiveBreakpoints.getTypographyScale(context);

    return PageScaffold(
      currentPath: '/contact',
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
                constraints: const BoxConstraints(maxWidth: ResponsiveBreakpoints.maxContentWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'START A PROJECT',
                      style: AppTypography.labelUppercase(
                        color: AppColors.accent,
                        scale: scale,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Let’s work together',
                      style: isMobile
                          ? AppTypography.heading1(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            )
                          : AppTypography.displayLarge(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No complicated brief required. Just tell me what you’re trying to make.',
                      style: AppTypography.bodyLarge(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Divider(),

          // Main Form Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: isMobile ? 36.0 : 64.0),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: ResponsiveBreakpoints.maxContentWidth),
                child: isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFormOrSuccess(isDark, isMobile),
                          const SizedBox(height: 56),
                          _buildAlternativeContacts(isDark),
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
                            child: _buildAlternativeContacts(isDark),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormOrSuccess(bool isDark, bool isMobile) {
    if (_isSubmitted) {
      return Container(
        padding: const EdgeInsets.all(36.0),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          border: Border.all(
            color: AppColors.accent,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle_rounded, size: 48, color: AppColors.accent),
            const SizedBox(height: 24),
            Text(
              'Thanks — your enquiry is on its way.',
              style: AppTypography.heading1(
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'I received your details. I typically respond within 24 hours with visual ideas, timeline options, and next steps.',
              style: AppTypography.bodyLarge(
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: _resetForm,
              style: OutlinedButton.styleFrom(
                foregroundColor: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                side: BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
              child: Text('Submit another project', style: AppTypography.buttonText(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
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
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
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
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
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
          // Name & Email Fields (stacked on mobile, row on desktop)
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

          // Company / Organization Field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'COMPANY / ORGANIZATION / CLUB',
                style: AppTypography.labelUppercase(
                  color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _organizationController,
                style: AppTypography.bodyMedium(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
                decoration: _inputDecoration(isDark, hint: 'e.g. Design Club / Tech Startup / Self'),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Project Type Selector
          Text(
            'PROJECT TYPE',
            style: AppTypography.labelUppercase(
              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _projectTypes.map((type) {
              final isSelected = _selectedProjectType == type;
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => setState(() => _selectedProjectType = type),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.accent : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
                      border: Border.all(
                        color: isSelected ? AppColors.accent : (isDark ? AppColors.borderDark : AppColors.borderLight),
                      ),
                    ),
                    child: Text(
                      type,
                      style: AppTypography.buttonText(
                        color: isSelected ? Colors.white : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),

          // Budget Selector
          Text(
            'BUDGET RANGE',
            style: AppTypography.labelUppercase(
              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _budgetOptions.map((budget) {
              final isSelected = _selectedBudget == budget;
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => setState(() => _selectedBudget = budget),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)
                          : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
                      border: Border.all(
                        color: isSelected
                            ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)
                            : (isDark ? AppColors.borderDark : AppColors.borderLight),
                      ),
                    ),
                    child: Text(
                      budget,
                      style: AppTypography.buttonText(
                        color: isSelected
                            ? (isDark ? AppColors.bgDark : AppColors.bgLight)
                            : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),

          // Deadline Selector
          Text(
            'TIMELINE / DEADLINE',
            style: AppTypography.labelUppercase(
              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _deadlineOptions.map((deadline) {
              final isSelected = _selectedDeadline == deadline;
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => setState(() => _selectedDeadline = deadline),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)
                          : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
                      border: Border.all(
                        color: isSelected
                            ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)
                            : (isDark ? AppColors.borderDark : AppColors.borderLight),
                      ),
                    ),
                    child: Text(
                      deadline,
                      style: AppTypography.buttonText(
                        color: isSelected
                            ? (isDark ? AppColors.bgDark : AppColors.bgLight)
                            : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),

          // Project Description Field
          Text(
            'TELL ME A LITTLE ABOUT THE PROJECT *',
            style: AppTypography.labelUppercase(
              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _descriptionController,
            maxLines: 5,
            style: AppTypography.bodyMedium(
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
            decoration: _inputDecoration(isDark, hint: 'What are you creating? Mention event details, visual preferences, key dates or deliverables.'),
            validator: (value) {
              if (value == null || value.trim().length < 10) {
                return 'Please provide a short description (at least 10 characters)';
              }
              return null;
            },
          ),

          if (_errorMessage != null) ...[
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
                      const Icon(Icons.error_outline_rounded, color: Colors.redAccent),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: AppTypography.bodySmall(color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: _sendDirectEmail,
                    icon: const Icon(Icons.email_outlined, size: 16, color: Colors.redAccent),
                    label: Text(
                      'Send via Email App directly →',
                      style: AppTypography.buttonText(color: Colors.redAccent),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          const SizedBox(height: 16),

          // Submit Button
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
                      'Send enquiry →',
                      style: AppTypography.buttonText(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlternativeContacts(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DIRECT CONTACT',
          style: AppTypography.labelUppercase(color: AppColors.accent),
        ),
        const SizedBox(height: 16),
        Text(
          'Prefer to email or text directly?',
          style: AppTypography.heading2(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'If you already have a prepared project brief or want to discuss ongoing monthly support, reach out directly.',
          style: AppTypography.bodyMedium(
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 28),

        _ContactChannelRow(
          icon: Icons.email_outlined,
          title: 'Email',
          value: AppConfig.contactEmail,
          onTap: () => _launchUrl('mailto:${AppConfig.contactEmail}'),
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        _ContactChannelRow(
          icon: Icons.camera_alt_outlined,
          title: 'Instagram',
          value: AppConfig.instagramHandle,
          onTap: () => _launchUrl(AppConfig.instagramUrl),
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        _ContactChannelRow(
          icon: Icons.chat_bubble_outline_rounded,
          title: 'WhatsApp',
          value: 'Instant Chat Enquiry',
          onTap: () => _launchUrl('https://wa.me/${AppConfig.whatsappNumber}'),
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        _ContactChannelRow(
          icon: Icons.work_outline_rounded,
          title: 'LinkedIn',
          value: 'Studio Profile',
          onTap: () => _launchUrl(AppConfig.linkedinUrl),
          isDark: isDark,
        ),
      ],
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
          color: isDark ? AppColors.borderHoverDark : AppColors.borderHoverLight,
          width: 1.5,
        ),
        borderRadius: BorderRadius.zero,
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
        ),
        borderRadius: BorderRadius.zero,
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
          width: 1.5,
        ),
        borderRadius: BorderRadius.zero,
      ),
    );
  }
}

class _ContactChannelRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;
  final bool isDark;

  const _ContactChannelRow({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 22, color: AppColors.accent),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.bodySmall(
                        color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: AppTypography.heading3(
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_outward_rounded, size: 16, color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
            ],
          ),
        ),
      ),
    );
  }
}
