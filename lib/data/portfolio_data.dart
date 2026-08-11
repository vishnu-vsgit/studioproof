import '../models/project_model.dart';

class PortfolioData {
  static const List<Project> projects = [
    Project(
      id: 'sync-guests',
      title: 'SYNC 2026 — Special Guests',
      category: 'College Fest Poster',
      year: '2026',
      tagline: 'Inaugural session guest announcement poster for SYNC 2026 at Ahalia School of Engineering & Technology.',
      clientType: 'College Fest / Ahalia Engineering',
      description: 'Custom event poster design announcing special guests for the inaugural session of SYNC 2026.',
      deliverables: [
        'Special Guest Reveal Poster',
        'Instagram Announcement Graphic',
        'Print & Stage Collateral',
      ],
      imageAsset: 'assets/images/work_1.jpg',
      aspectRatio: 0.77,
    ),
    Project(
      id: 'sync-say-yes',
      title: 'SAY YES TO SYNC 2026',
      category: 'Hackathon Campaign',
      year: '2026',
      tagline: 'High-contrast rooftop banner creative for the Human x AI Hackathon Prelims Registration.',
      clientType: 'Hackathon / CodeFlow Studio',
      description: 'Bold promotional creative designed for prelims registration announcements across social feeds and digital platforms.',
      deliverables: [
        'Campaign Key Visual',
        'Prelims Registration Graphic',
        'Social Media Promo',
      ],
      imageAsset: 'assets/images/work_2.jpg',
      aspectRatio: 0.77,
    ),
    Project(
      id: 'sync-countdown',
      title: 'SYNC 2026 — 5 Days To Go',
      category: 'Countdown Poster',
      year: '2026',
      tagline: 'Teaser countdown poster featuring glass block lighting: "AI is the tool. You are the edge."',
      clientType: 'College Event Series',
      description: 'Minimalist countdown visual designed to build momentum ahead of the main 2-day event.',
      deliverables: [
        'Countdown Teaser Graphic',
        'Social Media Stories',
        'Digital Screen Poster',
      ],
      imageAsset: 'assets/images/work_3.jpg',
      aspectRatio: 0.77,
    ),
  ];

  static Project? getProjectById(String id) {
    try {
      return projects.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
