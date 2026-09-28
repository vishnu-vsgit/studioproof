/// Studio Proof - Centralized Application Configuration
class AppConfig {
  static const String studioName = 'Kalaa.png';
  static const String studioTagline = 'Independent Graphic Design Studio';
  static const String designerTitle = 'Graphic Designer & Student';
  static const String designerBioHeadline = 'Clear visual direction. Designed for real impact.';
  
  // Primary Contact Info
  static const String contactEmail = 'kalaa.png@gmail.com';
  static const String formSubmitHash = 'kalaa.png@gmail.com';
  static const String whatsappNumber = '918778944493';
  static const String phoneNumber = '+91 87789 44493';
  static const String phoneUrl = 'tel:+918778944493';
  static const String instagramHandle = '@kalaaaa.png';
  static const String instagramUrl = 'https://instagram.com/kalaaaa.png';

  // Supabase Backend Configuration
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://godwozrmgvuxuthzamrh.supabase.co',
  );
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdvZHdvenJtZ3Z1eHV0aHphbXJoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODc4MTA5NzMsImV4cCI6MjEwMzM4Njk3M30.Z60FC9erYdAJjusySpxyrxN1E1ElngtWJ5kkHzF64xs',
  );
  
  // Primary Tools used
  static const List<String> primaryTools = [
    'Figma',
    'Adobe Photoshop',
  ];
  
  // Client Types
  static const List<String> clientTypes = [
    'Colleges & Campus Clubs',
    'Student Organizations',
    'Event Organizers',
    'Tech & Early-stage Startups',
    'Small Businesses & Shops',
    'Creators & Individuals',
  ];

  // Services offered
  static const List<String> serviceCategories = [
    'Poster & Campaign Design',
    'Social Media Design',
    'Event & College Design',
    'Startup Design',
    'Business Design',
    'Design Training & Workshops',
    'Custom Projects',
  ];
}
