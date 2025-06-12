import 'package:flutter/material.dart';
import '../../models/bottle.dart';
import '../../widgets/toggle_buttons.dart';

class DetailsScreen extends StatefulWidget {
  final Bottle? bottle;
  const DetailsScreen({super.key, this.bottle});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String selectedType = 'Genuine Bottle (Unopened)';
  int selectedTab = 0;

  final List<String> tabLabels = ['Details', 'Tasting notes', 'History'];

  @override
  Widget build(BuildContext context) {
    final bottle =
        widget.bottle ?? ModalRoute.of(context)!.settings.arguments as Bottle?;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // fit width
            children: [
              // Top Row with Title and Close button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Genesis Collection',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0B1519),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),

              // Dropdown with gear icon, background, no underline
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B1519),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.settings, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedType,
                            dropdownColor: const Color(0xFF0B1519),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            style: const TextStyle(color: Colors.white),
                            items:
                                <String>[
                                  'Genuine Bottle (Unopened)',
                                  'Opened Bottle',
                                  'Replica',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedType = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottle image or placeholder
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: bottle != null
                    ? Image.asset(bottle.imagePath, height: 200)
                    : Container(height: 200),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFF122329),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bottle: ${bottle!.amount}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        bottle.title,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Color(0xFF122329),
                        child: MyToggleButtons(
                          selectedTab: selectedTab,
                          onTabChanged: (index) {
                            setState(() {
                              selectedTab = index;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (selectedTab == 0) ...[
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: bottle.details.map((item) {
                            return SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['label'] ?? '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    item['value'] ?? '',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ] else if (selectedTab == 1) ...[
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 40,
                              color: Color(0xFF122329),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Text('Content for tab 1'),
                          ],
                        ),

                        // Other widgets for tab 1
                      ] else if (selectedTab == 2) ...[
                        Text('Content for tab 2'),
                        // Other widgets for tab 2
                      ],
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    '+ Add to my collection',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
