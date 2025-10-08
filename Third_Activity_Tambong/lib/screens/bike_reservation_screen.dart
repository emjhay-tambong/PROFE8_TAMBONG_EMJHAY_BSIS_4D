import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/reservation.dart';
import '../data/reservation_storage.dart';

// Requirements 1, 8, 9, 10: Form with TextFormField, date/time pickers, text controller, and data storage
class BikeReservationScreen extends StatefulWidget {
  const BikeReservationScreen({super.key});

  @override
  State<BikeReservationScreen> createState() => _BikeReservationScreenState();
}

class _BikeReservationScreenState extends State<BikeReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Requirement 9: Controller to capture and display text
  final _nameController = TextEditingController();
  final _durationController = TextEditingController();
  
  // Bike types dropdown
  String _selectedBikeType = 'Mountain Bike';
  final List<String> _bikeTypes = [
    'Mountain Bike',
    'Road Bike',
    'Electric Bike',
    'Hybrid Bike',
    'BMX Bike',
  ];
  
  final Map<String, double> _bikePrices = {
    'Mountain Bike': 125.0, // Average of ₱100-₱150
    'Road Bike': 160.0, // Average of ₱120-₱200
    'Electric Bike': 325.0, // Average of ₱250-₱400
    'Hybrid Bike': 200.0, // Average of ₱150-₱250
    'BMX Bike': 100.0, // Average of ₱80-₱120
  };
  
  // Requirement 8: Date and time picker variables
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  
  // Requirement 9: Variable to display captured text
  String _displayedName = '';
  double _calculatedAmount = 0.0;
  
  final ReservationStorage _storage = ReservationStorage();

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  // Requirement 8: Date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Requirement 8: Time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Requirement 9: Display captured text after button press
  void _displayCapturedText() {
    if (_nameController.text.isNotEmpty) {
      setState(() {
        _displayedName = _nameController.text;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Name captured: $_displayedName'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _calculateTotal() {
    if (_durationController.text.isNotEmpty) {
      final duration = int.tryParse(_durationController.text) ?? 0;
      final pricePerHour = _bikePrices[_selectedBikeType] ?? 0.0;
      setState(() {
        _calculatedAmount = duration * pricePerHour;
      });
    }
  }

  // Requirement 10: Save data and display below
  void _submitReservation() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final duration = int.parse(_durationController.text);
      final pricePerHour = _bikePrices[_selectedBikeType] ?? 0.0;
      final totalAmount = duration * pricePerHour;
      
      final reservation = Reservation(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        customerName: _nameController.text,
        bikeType: _selectedBikeType,
        pickupDate: _selectedDate,
        pickupTime: _selectedTime.format(context),
        duration: duration,
        totalAmount: totalAmount,
        createdAt: DateTime.now(),
      );
      
      // Requirement 10: Save to local list
      _storage.addReservation(reservation);
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Reservation Confirmed!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Customer: ${reservation.customerName}'),
                const SizedBox(height: 8),
                Text('Bike Type: ${reservation.bikeType}'),
                const SizedBox(height: 8),
                Text('Pickup Date: ${DateFormat('MMM dd, yyyy').format(reservation.pickupDate)}'),
                const SizedBox(height: 8),
                Text('Pickup Time: ${reservation.pickupTime}'),
                const SizedBox(height: 8),
                Text('Duration: ${reservation.duration} hours'),
                const SizedBox(height: 8),
                Text(
                  'Total: ₱${reservation.totalAmount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Clear form
                _nameController.clear();
                _durationController.clear();
                setState(() {
                  _selectedBikeType = 'Mountain Bike';
                  _selectedDate = DateTime.now();
                  _selectedTime = TimeOfDay.now();
                  _displayedName = '';
                  _calculatedAmount = 0.0;
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Bike'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Icon(
                Icons.directions_bike,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 20),
              Text(
                'Reserve Your Bike',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              
              // Requirement 1: Simple TextFormField for username
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Customer Name',
                  prefixIcon: const Icon(Icons.person),
                  hintText: 'Enter your name',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.check_circle),
                    tooltip: 'Capture name',
                    onPressed: _displayCapturedText,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) => _displayCapturedText(),
              ),
              
              // Requirement 9: Display captured text
              if (_displayedName.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Welcome, $_displayedName!',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              
              // Bike type dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedBikeType,
                decoration: const InputDecoration(
                  labelText: 'Bike Type',
                  prefixIcon: Icon(Icons.pedal_bike),
                ),
                items: _bikeTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text('$type - ₱${_bikePrices[type]?.toInt()}/hr'),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedBikeType = newValue!;
                    _calculateTotal();
                  });
                },
              ),
              const SizedBox(height: 20),
              
              // Requirement 8: Date picker
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Pickup Date',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('EEEE, MMM dd, yyyy').format(_selectedDate),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Requirement 8: Time picker
              InkWell(
                onTap: () => _selectTime(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Pickup Time',
                    prefixIcon: Icon(Icons.access_time),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedTime.format(context),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Duration field
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(
                  labelText: 'Duration (hours)',
                  prefixIcon: Icon(Icons.timer),
                  hintText: 'Enter rental duration',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter duration';
                  }
                  final duration = int.tryParse(value);
                  if (duration == null || duration <= 0) {
                    return 'Please enter a valid duration';
                  }
                  return null;
                },
                onChanged: (value) => _calculateTotal(),
              ),
              const SizedBox(height: 20),
              
              // Display calculated amount
              if (_calculatedAmount > 0)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Estimated Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₱${_calculatedAmount.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 30),
              
              // Submit button
              ElevatedButton(
                onPressed: _submitReservation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'CONFIRM RESERVATION',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Requirement 10: Display submitted data count
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Total Reservations: ${_storage.count}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

