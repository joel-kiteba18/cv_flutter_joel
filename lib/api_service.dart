import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const String _apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:8000',
);

class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class FamilleMembre {
  const FamilleMembre({
    required this.nom,
    required this.postnom,
    required this.prenom,
    required this.parente,
    required this.lieuNaissance,
    required this.dateNaissance,
    this.imageUrl,
  });

  final String nom;
  final String postnom;
  final String prenom;
  final String parente;
  final String lieuNaissance;
  final String dateNaissance;
  final String? imageUrl;

  String get nomComplet => '$prenom $nom $postnom'.trim();

  factory FamilleMembre.fromJson(Map<String, dynamic> json) {
    String readString(String key) {
      final Object? value = json[key];
      if (value is String) return value;
      if (value is num) return value.toString();
      throw ApiException('La réponse API ne contient pas le champ "$key".');
    }

    final Object? imageUrl = json['image_url'];
    return FamilleMembre(
      nom: readString('nom'),
      postnom: readString('postnom'),
      prenom: readString('prenom'),
      parente: readString('parente'),
      lieuNaissance: readString('lieu_naissance'),
      dateNaissance: readString('date_naissance'),
      imageUrl: imageUrl is String && imageUrl.isNotEmpty ? imageUrl : null,
    );
  }
}

class ApiService {
  static Uri _endpoint(String path) {
    final String baseUrl = _apiBaseUrl.replaceFirst(RegExp(r'/+$'), '');
    return Uri.parse('$baseUrl$path');
  }

  static Future<Map<String, dynamic>> _postJson(
    String path,
    Map<String, String> body,
  ) async {
    final http.Response response;
    try {
      response = await http
          .post(
            _endpoint(path),
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));
    } on TimeoutException {
      throw const ApiException('Le serveur API ne répond pas à temps.');
    } on http.ClientException {
      throw const ApiException(
        'Impossible de joindre l’API. Vérifiez que le serveur est démarré et que son adresse est correcte.',
      );
    }

    return _readResponse(response);
  }

  static Future<void> login(String email, String password) async {
    await _postJson('/accounts/login', {'email': email, 'password': password});
  }

  static Future<void> register(String email, String password) async {
    await _postJson('/accounts/register', {
      'email': email,
      'password': password,
    });
  }

  static Future<List<FamilleMembre>> getMembresFamille() async {
    final http.Response response;
    try {
      response = await http
          .get(_endpoint('/famille-membres'))
          .timeout(const Duration(seconds: 15));
    } on TimeoutException {
      throw const ApiException('Le serveur API ne répond pas à temps.');
    } on http.ClientException {
      throw const ApiException(
        'Impossible de joindre l’API. Vérifiez que le serveur est démarré et que son adresse est correcte.',
      );
    }

    final Map<String, dynamic> payload = _readResponse(response);
    final Object? data = payload['data'];
    if (data is! List) {
      throw const ApiException('La réponse API des membres est invalide.');
    }

    return data.map((Object? item) {
      if (item is! Map<String, dynamic>) {
        throw const ApiException('Un membre reçu de l’API est invalide.');
      }
      return FamilleMembre.fromJson(item);
    }).toList();
  }

  static Map<String, dynamic> _readResponse(http.Response response) {
    final Object? decoded;
    try {
      decoded = jsonDecode(response.body);
    } on FormatException {
      throw ApiException('Réponse API invalide (HTTP ${response.statusCode}).');
    }

    if (decoded is! Map<String, dynamic>) {
      throw ApiException('Réponse API invalide (HTTP ${response.statusCode}).');
    }
    if (response.statusCode < 200 ||
        response.statusCode >= 300 ||
        decoded['success'] != true) {
      final Object? message = decoded['message'];
      throw ApiException(
        message is String
            ? message
            : 'Erreur API (HTTP ${response.statusCode}).',
      );
    }
    return decoded;
  }
}
