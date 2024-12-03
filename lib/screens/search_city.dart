import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  String _result = "";
  List<String> _storedData = [];

  @override
  void initState() {
    super.initState();
    _loadStoredData();
  }

  void _loadStoredData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedData = prefs.getStringList('weatherData') ?? [];
    });
  }

  Future<void> _saveData(String cityName, double tempC) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String weatherData = "City: $cityName, Temperature: $tempC°C";
    _storedData.add(weatherData);
    await prefs.setStringList('weatherData', _storedData);

    setState(() {});
  }

  Future<void> _deleteData(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedData.removeAt(index);
    });
    await prefs.setStringList('weatherData', _storedData);
  }

  Future<Map<String, dynamic>> getCity(String search) async {
    String query = search.isNotEmpty ? search : "rajkot";

    try {
      Response res = await get(
        Uri.parse(
            "https://api.weatherapi.com/v1/forecast.json?key=3c5009be4d49494f9d245829232208&q=$query&days=1&aqi=no&alerts=no"),
      );

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception(
            'Failed to fetch weather data: ${res.statusCode} - ${res.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  void _searchCity() async {
    String city = _cityController.text.trim();

    try {
      Map<String, dynamic> cityData = await getCity(city);

      String cityName = cityData['location']['name'];
      double tempC = cityData['current']['temp_c'];

      setState(() {
        _result = "City: $cityName\nTemperature: $tempC°C";
      });
      await _saveData(cityName, tempC);
    } catch (e) {
      setState(() {
        _result = e.toString();
      });
    }
  }

  void _navigateToDetails(String cityName) {
    Navigator.of(context).pushNamed("/", arguments: cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade700,
        title: Text("City Weather Search", style: GoogleFonts.roboto()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [  SizedBox(height: 40),
            Container(
              height: 115,
              decoration: BoxDecoration(
                color: Colors.blue.shade700.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.roboto(),
                      labelText: "  Enter city name",
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: OutlinedButton(
                      onPressed: _searchCity,
                      child: Text(
                        "Search",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Text(
              "Current Weather:",
            style:
            GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.blue.shade700.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  _result.isNotEmpty ? _result : "No data fetched yet.",
                  style: GoogleFonts.roboto(fontSize: 16),
                ),
              ),
            ),  SizedBox(height: 40),
            Divider(),
            SizedBox(height: 10),
            Text(
              "Stored Weather Data:",
              style:
              GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _storedData.length,
                itemBuilder: (context, index) {
                  String cityName =
                  _storedData[index].split(",")[0].split(":")[1].trim();
                  return Card(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade700.withOpacity(0.2),
                        border: Border.all(color: Colors.blueAccent.shade700),
                      ),
                      child: ListTile(
                        title: Text(
                          _storedData[index],
                          style: GoogleFonts.roboto(fontSize: 14),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => _deleteData(index),
                        ),
                        onTap: () {
                          _navigateToDetails(cityName);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}