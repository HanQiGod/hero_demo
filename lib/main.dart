import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F766E),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF3EFE7),
        useMaterial3: true,
      ),
      home: const HeroExamplePage(),
    );
  }
}

class HeroExamplePage extends StatelessWidget {
  const HeroExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Demo'), centerTitle: false),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          const _IntroCard(),
          const SizedBox(height: 20),
          for (final destination in destinations) ...[
            _DestinationListCard(destination: destination),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'A practical Hero example',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap any card below. The shared poster uses the same Hero tag on '
            'both routes, so Flutter animates it from the list page into the '
            'detail page automatically.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF5B6575),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _DestinationListCard extends StatelessWidget {
  const _DestinationListCard({required this.destination});

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: Key('destination-card-${destination.id}'),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => DestinationDetailPage(destination: destination),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero matches widgets with the same tag across route transitions.
              Hero(
                tag: destination.heroTag,
                child: _DestinationPoster(
                  destination: destination,
                  height: 220,
                  alignment: Alignment.bottomLeft,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                destination.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                destination.subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF5B6575),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    size: 18,
                    color: destination.colors.last,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Open details to see the Hero transition.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF6C7483),
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_rounded),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DestinationDetailPage extends StatelessWidget {
  const DestinationDetailPage({super.key, required this.destination});

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            Row(
              children: [
                IconButton.filledTonal(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
                const Spacer(),
                Text(
                  'Detail page',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: const Color(0xFF6C7483),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Hero(
              tag: destination.heroTag,
              child: _DestinationPoster(
                destination: destination,
                height: 360,
                alignment: Alignment.bottomCenter,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              destination.title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              destination.subtitle,
              style: theme.textTheme.titleMedium?.copyWith(
                color: const Color(0xFF5B6575),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _InfoChip(label: destination.tripLength),
                _InfoChip(label: destination.season),
                _InfoChip(label: destination.focus),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Why this example works',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              destination.description,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.7,
                color: const Color(0xFF334155),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(18),
              child: Text(
                'Source route and destination route both wrap the same visual '
                'element with Hero(tag: ${destination.heroTag}). The framework '
                'handles the interpolation during navigation.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF475569),
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              key: const Key('detail-cta'),
              onPressed: () => Navigator.of(context).pop(),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text('Back to the list'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DestinationPoster extends StatelessWidget {
  const _DestinationPoster({
    required this.destination,
    required this.height,
    required this.alignment,
  });

  final Destination destination;
  final double height;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: destination.colors,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: -24,
            top: -28,
            child: Icon(
              destination.icon,
              size: height * 0.48,
              color: Colors.white.withValues(alpha: 0.18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Align(
              alignment: alignment,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Text(
                      destination.badge,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    destination.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    destination.shortNote,
                    style: const TextStyle(
                      color: Color(0xFFF4F4F5),
                      fontSize: 14,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      side: BorderSide.none,
      backgroundColor: Colors.white,
      visualDensity: VisualDensity.compact,
    );
  }
}

class Destination {
  const Destination({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.shortNote,
    required this.description,
    required this.badge,
    required this.tripLength,
    required this.season,
    required this.focus,
    required this.icon,
    required this.colors,
  });

  final String id;
  final String title;
  final String subtitle;
  final String shortNote;
  final String description;
  final String badge;
  final String tripLength;
  final String season;
  final String focus;
  final IconData icon;
  final List<Color> colors;

  String get heroTag => 'destination-$id';
}

const destinations = <Destination>[
  Destination(
    id: 'cloud-camp',
    title: 'Cloud Camp',
    subtitle: 'Morning fog, pine trails, and a warm cabin.',
    shortNote: 'A compact poster that expands into a full detail view.',
    description:
        'This route demonstrates the most common Hero usage: the list item '
        'contains a preview poster, and the detail page reuses that poster with '
        'the same tag. Flutter lifts the widget into an overlay and animates it '
        'between the two layouts during navigation.',
    badge: 'Shared Hero',
    tripLength: '2-day trip',
    season: 'Spring',
    focus: 'Image transition',
    icon: Icons.landscape_rounded,
    colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
  ),
  Destination(
    id: 'polar-cabin',
    title: 'Polar Cabin',
    subtitle: 'Northern lights and a quiet winter stay.',
    shortNote: 'Same Hero pattern, different content and styling.',
    description:
        'You can repeat this pattern for any card-based UI. The key requirement '
        'is keeping the Hero tag identical on the source and destination '
        'widgets. The surrounding page content can be completely different.',
    badge: 'Reusable Pattern',
    tripLength: '4-night stay',
    season: 'Winter',
    focus: 'Route transition',
    icon: Icons.nightlight_round,
    colors: [Color(0xFF1D4ED8), Color(0xFF7C3AED)],
  ),
  Destination(
    id: 'shore-library',
    title: 'Shore Library',
    subtitle: 'A reading room facing the sea at sunset.',
    shortNote: 'Hero works with any widget, not just images.',
    description:
        'The shared element here is a decorated container, but it could also be '
        'an image, avatar, product card, or custom widget. As long as both '
        'pages expose the same tag, Hero can animate between them.',
    badge: 'Any Widget',
    tripLength: 'Weekend visit',
    season: 'Autumn',
    focus: 'Shared element',
    icon: Icons.menu_book_rounded,
    colors: [Color(0xFFF97316), Color(0xFFEF4444)],
  ),
];
