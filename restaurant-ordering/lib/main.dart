import 'package:flutter/material.dart';

import 'menu_data.dart';

void main() => runApp(const NorthernForkApp());

class NorthernForkApp extends StatelessWidget {
  const NorthernForkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Northern Fork',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B4332),
        ),
        useMaterial3: true,
      ),
      home: const MenuPage(),
    );
  }
}

class Cart extends ChangeNotifier {
  final Map<Dish, int> items = {};

  int get count => items.values.fold(0, (a, b) => a + b);

  double get total => items.entries.fold(
        0,
        (sum, e) => sum + e.key.price * e.value,
      );

  void add(Dish dish) {
    items[dish] = (items[dish] ?? 0) + 1;
    notifyListeners();
  }

  void remove(Dish dish) {
    final qty = items[dish] ?? 0;
    if (qty <= 1) {
      items.remove(dish);
    } else {
      items[dish] = qty - 1;
    }
    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }
}

final Cart cart = Cart();

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String selected = 'All';

  @override
  Widget build(BuildContext context) {
    final dishes = selected == 'All'
        ? menu
        : menu.where((d) => d.category == selected).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('The Northern Fork'),
            Text(
              'Manchester · Northern Quarter',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: categories.map((c) {
                final isActive = c == selected;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(c),
                    selected: isActive,
                    onSelected: (_) => setState(() => selected = c),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: dishes.length,
              itemBuilder: (context, i) {
                final dish = dishes[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      dish.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  if (dish.isVeg)
                                    const _Tag('Veg'),
                                  if (dish.isSpicy)
                                    const _Tag('Spicy'),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                dish.description,
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '£${dish.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        FilledButton(
                          onPressed: () => setState(() => cart.add(dish)),
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: cart,
        builder: (context, _) {
          if (cart.count == 0) return const SizedBox.shrink();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: FilledButton(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CheckoutPage()),
                  );
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'View basket · ${cart.count} items · '
                    '£${cart.total.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label, style: const TextStyle(fontSize: 11)),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isDelivery = false;
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your basket')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...cart.items.entries.map((e) {
            final dish = e.key;
            return ListTile(
              title: Text(dish.name),
              subtitle: Text('£${dish.price.toStringAsFixed(2)} each'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => setState(() => cart.remove(dish)),
                  ),
                  Text('${e.value}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => cart.add(dish)),
                  ),
                ],
              ),
            );
          }),
          const Divider(),
          ListTile(
            title: const Text('Total'),
            trailing: Text(
              '£${cart.total.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: false, label: Text('Pickup')),
              ButtonSegment(value: true, label: Text('Delivery')),
            ],
            selected: {isDelivery},
            onSelectionChanged: (s) => setState(() => isDelivery = s.first),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Your name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: cart.count == 0
                ? null
                : () {
                    final name = nameController.text.trim().isEmpty
                        ? 'Guest'
                        : nameController.text.trim();
                    cart.clear();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => ConfirmationPage(name: name),
                      ),
                    );
                  },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('Place order', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your order is confirmed. We will let you know as soon as '
                'it is ready.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.of(context).popUntil(
                  (route) => route.isFirst,
                ),
                child: const Text('Back to menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
