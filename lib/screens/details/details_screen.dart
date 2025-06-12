import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                      // widgets for Details tab
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
                        // widgets for Tasting notes tab
                      ] else if (selectedTab == 1) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              color: Color(0xFF0B1519),
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
                            const SizedBox(height: 18),
                            Text(
                              'Tasting notes',
                              style: TextStyle(fontSize: 22),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'by ${bottle.tastingNotes?.by}',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 14),
                            Container(
                              width: double.infinity,
                              color: Color(0xFF0B1519),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nose',
                                    style: TextStyle(fontSize: 22),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    bottle.tastingNotes!.nose,
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              color: Color(0xFF0B1519),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Palate',
                                    style: TextStyle(fontSize: 22),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    bottle.tastingNotes!.palate,
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              color: Color(0xFF0B1519),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Finish',
                                    style: TextStyle(fontSize: 22),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    bottle.tastingNotes!.finish,
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Your notes',
                                  style: TextStyle(fontSize: 22),
                                  textAlign: TextAlign.left,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Container(
                              width: double.infinity,
                              color: Color(0xFF0B1519),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nose',
                                    style: TextStyle(fontSize: 22),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    bottle.yourNotes!.nose,
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              color: Color(0xFF0B1519),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Palate',
                                    style: TextStyle(fontSize: 22),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    bottle.yourNotes!.palate,
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              color: Color(0xFF0B1519),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Finish',
                                    style: TextStyle(fontSize: 22),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    bottle.yourNotes!.finish,
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // widgets for History tab
                      ] else if (selectedTab == 2) ...[
                        Container(
                          width: double.infinity,
                          color: Color(0xFF0E1C21),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: bottle.history.map((item) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/timeline.svg',
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'label',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            item.title,
                                            style: const TextStyle(
                                              fontSize: 22,
                                            ),
                                          ),
                                          Text(
                                            item.description,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            width: double.infinity,
                                            color: const Color(0xFF0B1519),
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: Transform.rotate(
                                                    angle:
                                                        45 * 3.1415926535 / 180,
                                                    child: const Icon(
                                                      Icons
                                                          .attach_file_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  iconSize: 16,
                                                  onPressed: () {
                                                    // Your logic
                                                  },
                                                ),
                                                const Text(
                                                  'Attachments',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
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
