import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

void main() async {
  final url = 'https://jldc.me/anubis/subdomains/';

  print("Creator: H4D3ZS");

  // Get the website name from user input
  print('Enter the website name: ');
  final websiteName = await inputFromUser();

  try {
    final response = await http.get(Uri.parse('$url$websiteName'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Check for the specific structure you need
      if (jsonData is List<dynamic>) {
        final subdomains = jsonData;

        // Sort the subdomains list alphabetically
        subdomains.sort();

        print('Subdomains for $websiteName:');
        for (var subdomain in subdomains) {
          print(subdomain);
        }

        // Save the subdomains to a text file
        final outputFile = File('subdomain_list.txt');
        await outputFile.writeAsString(subdomains.join('\n'));
      } else {
        print('Response does not contain the expected structure.');
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}

// Function to get user input
Future<String> inputFromUser() async {
  return (stdin.readLineSync() ?? '');
}
