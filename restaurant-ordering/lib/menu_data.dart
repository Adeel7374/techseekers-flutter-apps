class Dish {
  const Dish({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.isVeg = false,
    this.isSpicy = false,
  });

  final String name;
  final String description;
  final double price;
  final String category;
  final bool isVeg;
  final bool isSpicy;
}

const List<Dish> menu = [
  Dish(
    name: 'Tomato Basil Soup',
    description: 'Slow-cooked tomatoes, fresh basil, sourdough on the side.',
    price: 6.50,
    category: 'Starters',
    isVeg: true,
  ),
  Dish(
    name: 'Loaded Nachos',
    description: 'Cheese sauce, salsa, jalapenos and sour cream.',
    price: 8.00,
    category: 'Starters',
    isVeg: true,
    isSpicy: true,
  ),
  Dish(
    name: 'Northern Burger',
    description: 'Beef patty, cheddar, caramelised onion, house sauce, fries.',
    price: 13.50,
    category: 'Mains',
  ),
  Dish(
    name: 'Peri Peri Chicken',
    description: 'Chargrilled chicken, peri peri sauce, rice and salad.',
    price: 12.00,
    category: 'Mains',
    isSpicy: true,
  ),
  Dish(
    name: 'Margherita Pizza',
    description: 'San Marzano tomato, fior di latte, basil, wood-fired base.',
    price: 11.00,
    category: 'Mains',
    isVeg: true,
  ),
  Dish(
    name: 'Veggie Tagine',
    description: 'Moroccan-spiced vegetables, couscous, toasted almonds.',
    price: 10.50,
    category: 'Mains',
    isVeg: true,
  ),
  Dish(
    name: 'Chocolate Brownie',
    description: 'Warm brownie, vanilla ice cream, chocolate sauce.',
    price: 6.00,
    category: 'Desserts',
    isVeg: true,
  ),
  Dish(
    name: 'Mango Lassi',
    description: 'Chilled mango, yoghurt and a hint of cardamom.',
    price: 4.50,
    category: 'Drinks',
    isVeg: true,
  ),
  Dish(
    name: 'Fresh Mint Lemonade',
    description: 'Hand-shaken lemonade with crushed mint and ice.',
    price: 4.00,
    category: 'Drinks',
    isVeg: true,
  ),
];

const List<String> categories = [
  'All',
  'Starters',
  'Mains',
  'Desserts',
  'Drinks',
];
