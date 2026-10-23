class Service {
  const Service(this.name, this.price, this.minutes);

  final String name;
  final double price;
  final int minutes;
}

const services = [
  Service('Haircut', 29, 45),
  Service('Beard Trim', 25, 30),
  Service('Colour & Cut', 65, 90),
  Service('Facial', 45, 60),
  Service('Hot Towel Shave', 30, 30),
  Service('Kids Cut', 18, 30),
];

const timeSlots = ['09:00', '10:30', '12:00', '13:30', '15:00', '16:30', '18:00'];

const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String dayLabel(DateTime date) {
  return '${weekdays[date.weekday - 1]} ${date.day} ${months[date.month - 1]}';
}
