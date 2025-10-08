import 'package:flutter/material.dart';
import '../models/cleaning_service_model.dart';

class CleaningServicesGrid extends StatelessWidget {
  const CleaningServicesGrid({super.key});

  static final List<CleaningServiceModel> _services = [
    CleaningServiceModel(
      id: '1',
      name: 'Deep House Cleaning',
      description:
          'Complete deep cleaning of your entire home (4-5 hrs, 2-3 cleaners)',
      price: 3750.0, // Average of ₱2,500–₱5,000
      duration: 5,
      icon: Icons.home,
      color: Colors.blue,
    ),
    CleaningServiceModel(
      id: '2',
      name: 'Kitchen Cleaning',
      description: 'Thorough kitchen cleaning including appliances',
      price: 1750.0, // Average of ₱1,000–₱2,500
      duration: 2,
      icon: Icons.kitchen,
      color: Colors.orange,
    ),
    CleaningServiceModel(
      id: '3',
      name: 'Bathroom Cleaning',
      description: 'Complete bathroom sanitization and cleaning',
      price: 1150.0, // Average of ₱800–₱1,500
      duration: 1,
      icon: Icons.bathtub,
      color: Colors.teal,
    ),
    CleaningServiceModel(
      id: '4',
      name: 'Window Cleaning',
      description:
          'Interior and exterior window cleaning (depends on number of windows/floors)',
      price: 850.0, // Average of ₱500–₱1,200
      duration: 1,
      icon: Icons.window,
      color: Colors.cyan,
    ),
    CleaningServiceModel(
      id: '5',
      name: 'Carpet Cleaning',
      description: 'Professional carpet and upholstery cleaning (per room/sqm)',
      price: 2250.0, // Average of ₱1,500–₱3,000
      duration: 3,
      icon: Icons.cleaning_services,
      color: Colors.brown,
    ),
    CleaningServiceModel(
      id: '6',
      name: 'Office Cleaning',
      description:
          'Commercial office space cleaning (depends on size, small office)',
      price: 4500.0, // Average of ₱3,000–₱6,000
      duration: 4,
      icon: Icons.business,
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Services',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.85, // Fixed aspect ratio for uniform card size
          ),
          itemCount: _services.length,
          itemBuilder: (context, index) {
            return ServiceCard(service: _services[index]);
          },
        ),
      ],
    );
  }
}

class ServiceCard extends StatelessWidget {
  final CleaningServiceModel service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          _showServiceDetails(context);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                service.color.withValues(alpha: 0.1),
                service.color.withValues(alpha: 0.05),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: service.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      service.icon,
                      color: service.color,
                      size: 24,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '₱${service.price.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: service.color,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Text(
                        service.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${service.duration}h',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showServiceDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(service.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(service.description),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Price: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('₱${service.price.toStringAsFixed(2)}'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Duration: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${service.duration} hours'),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${service.name} added to cart!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Book Now'),
            ),
          ],
        );
      },
    );
  }
}
