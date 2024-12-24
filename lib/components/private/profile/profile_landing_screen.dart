import 'package:flutter/material.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileLandingPage extends StatefulWidget {
  var routeName = '/profilelanding';

  @override
  _ProfileLandingPageState createState() => _ProfileLandingPageState();
}

class _ProfileLandingPageState extends State<ProfileLandingPage> {
  String getFirstName = "";
  String getEmail = "";

  @override
  void initState() {
    super.initState();
    getSharedPreferenceData();
  }

  // getSharedPreferenceData
  Future<void> getSharedPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      getFirstName = prefs.getString('firstName') ?? '';
      getEmail = prefs.getString('email') ?? '';
    });
  }

  final List<String> itemNames = [
    'My profile',
    'Change my password',
    // 'Payments method',
    'Log out'
  ]; // List of item names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset('assets/images/food3.jpeg'),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  getFirstName,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                ),
                Text(
                  getEmail,
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/feedback', (Route<dynamic> route) => true);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        side: BorderSide.none,
                        shape: StadiumBorder()),
                    child: const Text(
                      'Rate App',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),

          //options
          Column(
            children: [
              const SizedBox(height: 280),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(15, 32, 15, 32),
                  itemCount: itemNames.length, // Number of items in the list
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigate to different sections/screens based on the item index
                            if (index == 0) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/myprofile', (Route<dynamic> route) => true);
                            } else if (index == 1) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/changepassword',
                                  (Route<dynamic> route) => true);
                            }
                            // else if (index == 2) {
                            //   Navigator.of(context).pushNamedAndRemoveUntil(
                            //       '/home', (Route<dynamic> route) => true);
                            // }
                            else if (index == 2) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/logIn', (Route<dynamic> route) => true);
                            }
                          },
                          child: Container(
                            height: 65,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEFEFF0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                            child: Center(
                              child: ListTile(
                                title: Text(
                                  itemNames[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 19,
                                    color: index ==
                                            itemNames.length -
                                                1 //setting the 4th item to be red
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward,
                                  color: index ==
                                          itemNames.length -
                                              1 //setting the 4th item to be red
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: RoundedBottomBar(
        selectedIndex: 3,
      ),
    );
  }
}
