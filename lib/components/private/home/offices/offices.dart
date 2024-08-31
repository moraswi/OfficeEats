import 'package:flutter/material.dart';
import 'package:eats/shared/app_colors.dart';
import 'package:eats/shared/bottom_nav_bar.dart';

class OfficePage extends StatefulWidget {
  var routeName = '/office';

  @override
  _OfficePageState createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Office Eats',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Enjoy effortless, delicious meals delivered right to your office door.',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/image1.webp',
                        width: 160,
                        height: 160,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Other scrollable content here

                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/officePackImage1.jpg',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Office Pack: Moreleta park',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: AppColors.primaryColor,
                                          size: 20),
                                      Text('Gauteng, Moreleta, worts street',
                                          style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home', (Route<dynamic> route) => true);
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: RoundedBottomBar(
        selectedIndex: 0,
      ),
    );
  }
}
