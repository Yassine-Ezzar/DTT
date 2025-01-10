import 'package:dtt/House%20Details%20Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';  
import 'package:geolocator/geolocator.dart'; 
import 'package:http/http.dart' as http;  
import 'dart:convert';  

class OverviewScreen extends StatefulWidget {
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  Position? userLocation;
  List<dynamic> houses = []; 
  List<dynamic> filteredHouses = []; 
  TextEditingController _searchController = TextEditingController();  
  bool showNoResults = false; 

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _fetchHouses();
  }

  Future<void> _fetchHouses() async {
    final response = await http.get(
      Uri.parse('https://intern.d-tt.nl/api/house'),
      headers: {
        'Access-Key': '98bww4ezuzfePCYFxJEWyszbUXc7dxRx',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> fetchedHouses = jsonDecode(response.body);

      
      fetchedHouses.sort((a, b) {
        double priceA = (a['price'] as num?)?.toDouble() ?? 0.0;
        double priceB = (b['price'] as num?)?.toDouble() ?? 0.0;
        return priceA.compareTo(priceB);  
      });

      setState(() {
        houses = fetchedHouses;
        filteredHouses = fetchedHouses;
      });
    } else {
      throw Exception('Failed to load houses');
    }
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        userLocation = position;
      });
    }
  }

  double _calculateDistance(double lat1, double lon1) {
    if (userLocation != null) {
      double lat2 = userLocation!.latitude;
      double lon2 = userLocation!.longitude;
      return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000; 
    }
    return 0.0;  
  }

  void _onSearch() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredHouses = houses.where((house) {
        String city = (house['city'] ?? '').toLowerCase();
        String zip = (house['zip'] ?? '').toLowerCase();
        return city.contains(query) || zip.contains(query);
      }).toList();

      // Sort filtered houses by price
      filteredHouses.sort((a, b) {
        double priceA = (a['price'] as num?)?.toDouble() ?? 0.0;
        double priceB = (b['price'] as num?)?.toDouble() ?? 0.0;
        return priceA.compareTo(priceB);
      });

      showNoResults = filteredHouses.isEmpty && query.isNotEmpty;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _onSearch();  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DTT Real Estate'),
        backgroundColor: Color(0xFFF7F7F7),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFEBEBEB), 
                    offset: Offset(0, 4),      
                    blurRadius: 6,             
                  ),
                ],
                borderRadius: BorderRadius.zero, 
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for a home...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero, 
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        suffixIcon: IconButton(
                          icon: SvgPicture.asset(
                            _searchController.text.isEmpty
                                ? 'assets/Icons/ic_search.svg'  
                                : 'assets/Icons/ic_close.svg',  
                            width: 24,
                            height: 24,
                          ),
                          onPressed: _searchController.text.isEmpty ? _onSearch : _clearSearch,  
                        ),
                      ),
                      onChanged: (_) => _onSearch(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: showNoResults 
                ? _buildNoResultsMessage() 
                : _buildHouseList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/Images/search_state_empty.png', height: 300),
          SizedBox(height: 20),
          Text(
            'No results found!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 10),
          Text('Perhaps try another search?'),
        ],
      ),
    );
  }

 Widget _buildHouseList() {
  return AnimatedList(
    key: GlobalKey<AnimatedListState>(),
    initialItemCount: filteredHouses.length,
    itemBuilder: (context, index, animation) {
      var house = filteredHouses[index];

      double latitude = (house['latitude'] as num?)?.toDouble() ?? 0.0;
      double longitude = (house['longitude'] as num?)?.toDouble() ?? 0.0;

      double distance = _calculateDistance(latitude, longitude);

      String imageUrl = 'assets/Images/one.png';

      return _buildAnimatedListItem(
        house: house,
        animation: animation,
        distance: distance,
        imageUrl: imageUrl,
      );
    },
  );
}

Widget _buildAnimatedListItem({
  required dynamic house,
  required Animation<double> animation,
  required double distance,
  required String imageUrl,
}) {
  return SizeTransition(
    sizeFactor: animation,
    axis: Axis.vertical,
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HouseDetailScreen(
              price: (house['price'] as num?)?.toDouble() ?? 0.0,
              description: house['description'] ?? 'No description available',
              imageUrl: imageUrl,
              bedrooms: house['bedrooms'] ?? 0,
              bathrooms: house['bathrooms'] ?? 0,
              size: house['size'] ?? 0,
              distance: distance,
              latitude: (house['latitude'] as num?)?.toDouble() ?? 0.0,
              longitude: (house['longitude'] as num?)?.toDouble() ?? 0.0,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${house['price']}',
                      style: TextStyle(
                        fontSize: 18,
                        color: const Color(0xFFCC000000),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      house['zip'] ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/Icons/ic_bed.svg',
                          width: 16,
                          height: 16,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${house['bedrooms'] ?? 0}',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 8),
                        SvgPicture.asset(
                          'assets/Icons/ic_bath.svg',
                          width: 16,
                          height: 16,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${house['bathrooms'] ?? 0}',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 8),
                        SvgPicture.asset(
                          'assets/Icons/ic_layers.svg',
                          width: 16,
                          height: 16,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${house['size'] ?? 0} m²',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 8),
                        SvgPicture.asset(
                          'assets/Icons/ic_location.svg',
                          width: 16,
                          height: 16,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${distance.toStringAsFixed(2)} km',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}
