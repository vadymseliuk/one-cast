import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../blocs/collection/collection_bloc.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  void _onNotification() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: (BlocBuilder<CollectionBloc, CollectionState>(
          builder: (context, state) {
            if (state is CollectionLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CollectionLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My collection',
                          style: TextStyle(fontSize: 32, color: Colors.white),
                        ),
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.notifications_none,
                                color: Colors.white,
                              ),
                              onPressed: _onNotification,
                            ),
                            Positioned(
                              right: 12,
                              bottom: 12,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: state.bottles.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.65,
                          ),
                      itemBuilder: (context, index) {
                        final bottle = state.bottles[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/details',
                              arguments: bottle,
                            );
                          },
                          child: Card(
                            color: Colors.blueGrey[900],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    bottle.imagePath,
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        bottle.title,
                                        style: const TextStyle(fontSize: 22),
                                      ),
                                      Text(
                                        bottle.year,
                                        style: const TextStyle(fontSize: 22),
                                      ),
                                      Text(
                                        '(${bottle.amount})',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('No collection found.'));
            }
          },
        )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF0B1519),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/scan.svg',
              width: 24,
              height: 24,
            ),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/squares_four.svg',
              width: 24,
              height: 24,
            ),
            label: 'Collection',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/bottle.svg',
              width: 24,
              height: 24,
            ),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/gear_six.svg',
              width: 24,
              height: 24,
            ),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          // Handle tab change
        },
      ),
    );
  }
}
