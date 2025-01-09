import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationScreen extends StatelessWidget {
  void _launchURL() async {
    const url = 'https://www.d-tt.nl';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print("Error launching URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF7F7F7), Color(0xFFF7F7F7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 4.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'From a student room in 2010 to a full-service digital agency in the heart of Amsterdam. Our story is one of growth and creativity. We - over 50 enthusiastic strategists, designers, developers, and testers - work together daily on the most beautiful projects for clients ranging from startups to multinationals. With diverse objectives and resources, we are challenged to create digital solutions that are both innovative and effective. This journey has made us rich in experience, flexible, and incredibly versatile.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            const Text(
              'Design and Development',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Images/dtt_banner/hdpi/dtt_banner.png',
                  height: 60,
                ),
                const SizedBox(width: 15),
                const Text(
                  'By DTT ',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                GestureDetector(
                  onTap: _launchURL,
                  child: const Text(
                    'd-tt.nl',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          
          ],
        ),
      ),
    );
  }
}
