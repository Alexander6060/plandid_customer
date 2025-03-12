import 'package:flutter/material.dart';

class ServiceProvider {
  final String name;
  final String title;
  final String location;
  final String imageUrl;
  final String description;
  bool enabled;

  ServiceProvider({
    required this.name,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.enabled,
  });
}

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  final List<ServiceProvider> _providers = [
    ServiceProvider(
      name: 'John Smith',
      title: 'Photographer',
      location: 'New York, NY',
      imageUrl:
          'https://picsum.photos/id/1011/400/600', // Placeholder image URL
      description:
          'John is a professional photographer with 10 years of experience.'
          ' He specializes in weddings, portraits, and event photography.'
          ' John’s portfolio features work in various publications, and he'
          ' prides himself on capturing each special moment flawlessly.',
      enabled: true,
    ),
    ServiceProvider(
      name: 'Anna Johnson',
      title: 'Caterer',
      location: 'Los Angeles, CA',
      imageUrl:
          'https://picsum.photos/id/1018/400/600', // Placeholder image URL
      description:
          'Anna is an accomplished caterer known for her unique twists on'
          ' classic dishes. She provides full-service catering, from menu'
          ' creation to setup and cleanup, ensuring a stress-free experience.',
      enabled: true,
    ),
    ServiceProvider(
      name: 'Michael Lee',
      title: 'Event Planner',
      location: 'San Francisco, CA',
      imageUrl:
          'https://picsum.photos/id/1021/400/600', // Placeholder image URL
      description:
          'Michael is an event planner specializing in corporate events and'
          ' large-scale conventions. His attention to detail and organizational'
          ' skills help deliver flawless experiences for all attendees.',
      enabled: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: _providers.length,
        itemBuilder: (context, index) {
          final provider = _providers[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(provider.imageUrl),
            ),
            trailing: IconButton(
              icon: Icon(
                provider.enabled ? Icons.bookmark : Icons.bookmark_border,
                // color: provider.enabled ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  provider.enabled = !provider.enabled;
                });
              },
            ),
            title: Text(provider.name),
            subtitle: Text('${provider.title} / ${provider.location}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          ServiceProviderDetailPage(provider: provider),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ServiceProviderDetailPage extends StatelessWidget {
  final ServiceProvider provider;

  const ServiceProviderDetailPage({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(provider.name), backgroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Provider image
            SizedBox(
              width: 150,
              height: 150,
              child: ClipOval(
                child: Image.network(provider.imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 16),
            // Provider info
            Text(
              provider.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              '${provider.title} : ${provider.location}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            // Description
            Text(
              provider.description,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
