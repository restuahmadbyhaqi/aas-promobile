import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Photo {
  final int id;
  final String photographer;
  final String url;
  final String largeImageUrl;
  final String blurredDataUrl;

  Photo({
    required this.id,
    required this.photographer,
    required this.url,
    required this.largeImageUrl,
    required this.blurredDataUrl,
  });
}

class GetDataScreen extends StatefulWidget {
  const GetDataScreen({Key? key}) : super(key: key);

  @override
  State<GetDataScreen> createState() => _GetDataScreenState();
}

class _GetDataScreenState extends State<GetDataScreen> {
  List<Photo> photos = [];
  bool isLoading = true;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    setState(() {
      isLoading = true;
    });

    final String apiKey =
        'erGGse4vw9uU1dPpELBCBEriCDHXz8wWnAxVRw0vY0vI5tDwCA8X6Jye'; // Replace with your actual API key

    // Construct the URL based on topic, page, and API key
    String url =
        'https://api.pexels.com/v1/curated?per_page=20&page=$currentPage';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Photo> fetchedPhotos = [];

        for (var photo in jsonData['photos']) {
          fetchedPhotos.add(Photo(
            id: photo['id'],
            photographer: photo['photographer'],
            url: photo['url'],
            largeImageUrl: photo['src']['large'],
            blurredDataUrl:
                'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjUwIiBoZWlnaHQ9IjE1MCIgdmlld0JveD0iMCAwIDI1MCAxNTAiIHdpZHRoPSIyNTAiIGhlaWdodD0iMTUwIj4KICAgIDxwYXRoIGQ9Ik0xMjUgMCIgZmlsbD0iYmxhY2siIHN0cm9rZT0iIzAwMCIgc3Ryb2tlLXdpZHRoPSIyIi8+Cjwvc3ZnPgo=', // Example blurred data URL
          ));
        }

        setState(() {
          photos = fetchedPhotos;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (error) {
      print('Error fetching photos: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  void nextPage() {
    setState(() {
      currentPage++;
      fetchPhotos();
    });
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        fetchPhotos();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Text('#PAGE $currentPage',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: photos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(photo: photos[index]),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Image.network(
                                  photos[index].largeImageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Photo ${photos[index].id}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: currentPage > 1 ? previousPage : null,
                      child: Text('Previous'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: nextPage,
                      child: Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Photo photo;

  const DetailScreen({required this.photo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              photo.largeImageUrl,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
