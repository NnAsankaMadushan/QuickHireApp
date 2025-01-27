import 'package:chatting_app/Screens/home_page.dart';
import 'package:chatting_app/Screens/messaging_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyJobsScreen extends StatelessWidget {
  const MyJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Jobs'),
        backgroundColor: Color(0xFF9E72C3).withOpacity(0.2),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.secondaryContainer,
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: sampleJobs.length,
          itemBuilder: (context, index) {
            final job = sampleJobs[index];
            return JobCard(job: job)
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 100 * index),
                )
                .slideX();
          },
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF9E72C3).withOpacity(0.2),
                  child: const Icon(
                    Icons.work_outline,
                    color: Color(0xFF9E72C3),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        'Posted by ${job.employerName}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9E72C3).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '\$${job.price}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: const Color(0xFF9E72C3),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              context,
              Icons.location_on_outlined,
              job.location,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              context,
              Icons.access_time,
              '${job.date} at ${job.time}',
            ),
            const SizedBox(height: 16),
            Text(
              job.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MessagingScreen(userId: 1),
                      ),
                    );
                  },
                  icon: const Icon(Icons.message_outlined),
                  label: const Text('Message'),
                ),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HomePage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow_outlined),
                  label: const Text('Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}

class Job {
  final String title;
  final String employerName;
  final String location;
  final String date;
  final String time;
  final String description;
  final double price;

  const Job({
    required this.title,
    required this.employerName,
    required this.location,
    required this.date,
    required this.time,
    required this.description,
    required this.price,
  });
}

// Sample data - Replace this with your actual data from a database or API
final List<Job> sampleJobs = [
  Job(
    title: 'House Cleaning',
    employerName: 'Jane Smith',
    location: '123 Main St, City',
    date: 'Jan 28, 2025',
    time: '10:00 AM',
    description:
        'General house cleaning including dusting, vacuuming, and bathroom cleaning. Expected duration: 3 hours.',
    price: 75.00,
  ),
  Job(
    title: 'Garden Maintenance',
    employerName: 'Mike Johnson',
    location: '456 Park Ave, City',
    date: 'Jan 29, 2025',
    time: '2:00 PM',
    description:
        'Lawn mowing, weeding, and general garden maintenance. Tools will be provided.',
    price: 60.00,
  ),
  // Add more sample jobs as needed
];
