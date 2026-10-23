import 'package:flutter/material.dart';

import 'services_data.dart';

void main() => runApp(const GlowStudioApp());

class GlowStudioApp extends StatelessWidget {
  const GlowStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glow Studio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6D28D9)),
        useMaterial3: true,
      ),
      home: const BookingPage(),
    );
  }
}

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Service? selectedService;
  int selectedDay = 0;
  String? selectedTime;
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  bool get canConfirm => selectedService != null && selectedTime != null;

  @override
  Widget build(BuildContext context) {
    final days = List.generate(7, (i) => DateTime.now().add(Duration(days: i)));
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Glow Studio'),
            Text(
              'Manchester · Booking (Concept)',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Choose a service',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...services.map((s) {
            final selected = s == selectedService;
            return Card(
              color: selected ? Theme.of(context).colorScheme.primaryContainer : null,
              child: ListTile(
                title: Text(s.name),
                subtitle: Text('${s.minutes} min'),
                trailing: Text('£${s.price.toStringAsFixed(0)}'),
                selected: selected,
                onTap: () => setState(() => selectedService = s),
              ),
            );
          }),
          const SizedBox(height: 24),
          const Text(
            'Choose a day',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (var i = 0; i < days.length; i++)
                ChoiceChip(
                  label: Text(dayLabel(days[i])),
                  selected: selectedDay == i,
                  onSelected: (_) => setState(() => selectedDay = i),
                ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Choose a time',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final t in timeSlots)
                ChoiceChip(
                  label: Text(t),
                  selected: selectedTime == t,
                  onSelected: (_) => setState(() => selectedTime = t),
                ),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Your name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: canConfirm
                ? () {
                    final name = nameController.text.trim().isEmpty
                        ? 'Guest'
                        : nameController.text.trim();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ConfirmationPage(
                          service: selectedService!,
                          day: days[selectedDay],
                          time: selectedTime!,
                          name: name,
                        ),
                      ),
                    );
                  }
                : null,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('Confirm booking', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({
    required this.service,
    required this.day,
    required this.time,
    required this.name,
    super.key,
  });

  final Service service;
  final DateTime day;
  final String time;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking confirmed')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, size: 72, color: Colors.green),
              const SizedBox(height: 16),
              Text(
                'Thanks, $name!',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${service.name} · £${service.price.toStringAsFixed(0)} · ${dayLabel(day)} at $time',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                child: const Text('Back to services'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
