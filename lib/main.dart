import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

// URL de base de votre API PHP en local (pour Chrome / Linux)
const String apiBaseUrl = 'http://localhost:8000';

void main() {
  runApp(const MonCvApp());
}

// ============================================================================
// 1. VOS DONNÉES PERSONNELLES (CV & COORDONNÉES)
// ============================================================================
class CvData {
  static const String nomComplet = "Joël Kiteba";
  static const String titreProfil =
      "Développeur Mobile Senior (Flutter & Android)";
  static const String photoProfilUrl = "assets/images/joel.jpg";
  static const String biographie =
      "Professionnel en Réseau Informatique spécialisé dans la conception d'applications performantes, intuitives et sécurisées avec Flutter, Dart et Android natif.";

  static const List<Map<String, String>> formations = [
    {
      "diplome": "Licence en Génie Logiciel & Systèmes d'Information",
      "ecole": "Université Libre des Pays des Grands Lacs (ULPGL)",
      "annee": "2020 - 2023",
    },
    {
      "diplome": "Certification Développement Mobile Multiplateforme",
      "ecole": "Google Developer Training",
      "annee": "2024",
    },
  ];

  static const List<Map<String, String>> experiences = [
    {
      "poste": "Développeur Mobile Flutter (Emploi)",
      "entreprise": "TechSolutions RDC",
      "periode": "2024 - Présent",
      "description": "Architecture et déploiement d'applications mobiles de gestion financière et logistique avec intégration d'API REST.",
    },
    {
      "poste": "Développeur Android / Flutter (Stage)",
      "entreprise": "Kivu Digital Hub",
      "periode": "2023 (6 mois)",
      "description": "Création d'interfaces utilisateurs réactives, gestion d'état et maintenance d'applications en production.",
    },
    {
      "poste": "Projet : Application de Suivi Médical",
      "entreprise": "Projet Personnel / Freelance",
      "periode": "2023",
      "description": "Développement d'une application fonctionnant hors-ligne (SQLite) avec synchronisation cloud.",
    },
  ];

  static const List<String> competencesTechniques = [
    "Flutter & Dart",
    "Android (Kotlin / Java)",
    "Git & GitHub",
    "API REST & Firebase",
    "SQLite / Hive",
    "Clean Architecture",
    "Material Design 3",
  ];

  static const Map<String, String> langues = {
    "Français": "Courant (Langue de travail)",
    "Anglais": "Technique / Professionnel",
    "Swahili": "Langue maternelle",
  };

  static const List<String> centresInteret = [
    "Architecture logicielle",
    "Veille technologique",
    "Open Source",
    "Football",
    "Lecture",
  ];

  // --- COORDONNÉES ---
  static const String telephone = "+243 838696468";
  static const String email = "joelkiteba@gmail.com";
  static const String adresse = "Quartier Katindo, Goma, Nord-Kivu, RDC";
  static const String linkedin = "https://linkedin.com";
  static const String github = "https://github.com";
  static const String facebook = "https://facebook.com";
}

// ============================================================================
// 2. CONFIGURATION DE L'APPLICATION
// ============================================================================
class MonCvApp extends StatelessWidget {
  const MonCvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Portfolio Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          brightness: Brightness.light,
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// ============================================================================
// PAGE (1) : CONNEXION (CONNECTÉE À POST /accounts/login)
// ============================================================================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _identifiantController = TextEditingController();
  final TextEditingController _motDePasseController = TextEditingController();
  bool _masquerMotDePasse = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _identifiantController.dispose();
    _motDePasseController.dispose();
    super.dispose();
  }

  Future<void> _seConnecter() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/accounts/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _identifiantController.text.trim(),
          'password': _motDePasseController.text,
        }),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (!mounted) return;

      if (response.statusCode == 200 && data['success'] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const MainNavigationPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade700,
            content: Text(data['message'] ?? 'Email ou mot de passe incorrect'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade700,
          content: Text('Impossible de joindre le serveur : $e'),
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: colorScheme.primaryContainer,
                        child: Icon(
                          Icons.person_pin,
                          size: 40,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Connexion",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Accédez à mon CV, ma famille et mes contacts",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _identifiantController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Veuillez entrer votre email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _motDePasseController,
                        obscureText: _masquerMotDePasse,
                        decoration: InputDecoration(
                          labelText: "Mot de passe",
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _masquerMotDePasse
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _masquerMotDePasse = !_masquerMotDePasse;
                              });
                            },
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez entrer votre mot de passe";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: FilledButton(
                          onPressed: _isLoading ? null : _seConnecter,
                          child: _isLoading
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Se connecter",
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// NAVIGATION PRINCIPALE (APRÈS CONNEXION)
// ============================================================================
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});
  @override
  State createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State {
  int _selectedIndex = 0;
  final List _pages = const [
    AccueilCvPage(),
    FamilleApiPage(),
    EtudiantsApiPage(),
    ContactsPage(),
  ];
  final List _titres = const [
    "Mon CV",
    "Ma Famille (API)",
    "Étudiants (API)",
    "Mes Coordonnées",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titres[_selectedIndex]),
        actions: [
          IconButton(
            tooltip: "Déconnexion",
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            selectedIcon: Icon(Icons.badge),
            label: "Mon CV",
          ),
          NavigationDestination(
            icon: Icon(Icons.family_restroom_outlined),
            selectedIcon: Icon(Icons.family_restroom),
            label: "Famille",
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: "Étudiants",
          ),
          NavigationDestination(
            icon: Icon(Icons.contact_phone_outlined),
            selectedIcon: Icon(Icons.contact_phone),
            label: "Contacts",
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// PAGE (2) : MON CV
// ============================================================================
class AccueilCvPage extends StatelessWidget {
  const AccueilCvPage({super.key});
  Widget _titreSection(BuildContext context, String titre, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            titre,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: const AssetImage(CvData.photoProfilUrl),
                  onBackgroundImageError: (_, __) {},
                ),
                const SizedBox(height: 12),
                Text(
                  CvData.nomComplet,
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  CvData.titreProfil,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(CvData.biographie, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
        _titreSection(context, "Expériences Professionnelles", Icons.work),
        ...CvData.experiences.map(
          (exp) => Card(
            child: ListTile(
              title: Text(
                exp["poste"] ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${exp["entreprise"]} (${exp["periode"]})\n${exp["description"]}",
              ),
              isThreeLine: true,
            ),
          ),
        ),
        _titreSection(context, "Formations", Icons.school),
        ...CvData.formations.map(
          (f) => Card(
            child: ListTile(
              title: Text(
                f["diplome"] ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${f["ecole"]} • ${f["annee"]}"),
            ),
          ),
        ),
        _titreSection(context, "Compétences Techniques", Icons.code),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: CvData.competencesTechniques
              .map((comp) => Chip(label: Text(comp)))
              .toList(),
        ),
        _titreSection(context, "Langues", Icons.language),
        ...CvData.langues.entries.map(
          (e) => ListTile(
            dense: true,
            leading: const Icon(Icons.check_circle_outline),
            title: Text(e.key),
            subtitle: Text(e.value),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// PAGE (3) : MA FAMILLE (CONNECTÉE À GET /famille-membres)
// ============================================================================
class FamilleApiPage extends StatefulWidget {
  const FamilleApiPage({super.key});
  @override
  State createState() => _FamilleApiPageState();
}

class _FamilleApiPageState extends State {
  late Future<List> _membresFuture;
  @override
  void initState() {
    super.initState();
    _membresFuture = _fetchMembres();
  }

  Future<List> _fetchMembres() async {
    final response = await http.get(Uri.parse('$apiBaseUrl/famille-membres'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      if (body['success'] == true) {
        return body['data'] as List;
      }
    }
    throw Exception('Erreur lors du chargement des membres');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _membresFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Erreur : ${snapshot.error}'),
            ),
          );
        }
        final membres = snapshot.data ?? [];
        if (membres.isEmpty) {
          return const Center(
            child: Text('Aucun membre de famille enregistré dans MySQL.'),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _membresFuture = _fetchMembres();
            });
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: membres.length,
            itemBuilder: (context, index) {
              final m = membres[index];
              final String? imageUrl = m['image_url'];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl)
                        : null,
                    child: imageUrl == null ? const Icon(Icons.person) : null,
                  ),
                  title: Text(
                    '${m['nom']} ${m['postnom']} ${m['prenom']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${m['parente']} • Né(e) à ${m['lieu_naissance']} le ${m['date_naissance']}',
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// ============================================================================
// PAGE (4) : ÉTUDIANTS (CONNECTÉE À GET /etudiants)
// ============================================================================
class EtudiantsApiPage extends StatefulWidget {
  const EtudiantsApiPage({super.key});
  @override
  State createState() => _EtudiantsApiPageState();
}

class _EtudiantsApiPageState extends State {
  late Future<List> _etudiantsFuture;
  @override
  void initState() {
    super.initState();
    _etudiantsFuture = _fetchEtudiants();
  }

  Future<List> _fetchEtudiants() async {
    final response = await http.get(Uri.parse('$apiBaseUrl/etudiants'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      if (body['success'] == true) {
        return body['data'] as List;
      }
    }
    throw Exception('Erreur lors du chargement des étudiants');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _etudiantsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Erreur : ${snapshot.error}'));
        }
        final etudiants = snapshot.data ?? [];
        if (etudiants.isEmpty) {
          return const Center(
            child: Text('Aucun étudiant enregistré dans MySQL.'),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _etudiantsFuture = _fetchEtudiants();
            });
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: etudiants.length,
            itemBuilder: (context, index) {
              final e = etudiants[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.school)),
                  title: Text(
                    '${e['nom']} ${e['postnom']} ${e['prenom']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${e['adresse']} • ${e['telephone']}'),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// ============================================================================
// PAGE (5) : MES COORDONNÉES
// ============================================================================
class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});
  Future _ouvrirLien(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.phone),
            title: const Text("Téléphone"),
            subtitle: const Text(CvData.telephone),
            onTap: () => _ouvrirLien("tel:${CvData.telephone}"),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.email),
            title: const Text("Email"),
            subtitle: const Text(CvData.email),
            onTap: () => _ouvrirLien("mailto:${CvData.email}"),
          ),
        ),
        Card(
          child: const ListTile(
            leading: Icon(Icons.location_on),
            title: Text("Adresse"),
            subtitle: Text(CvData.adresse),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.business),
            title: const Text("LinkedIn"),
            subtitle: const Text(CvData.linkedin),
            onTap: () => _ouvrirLien(CvData.linkedin),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.code),
            title: const Text("GitHub"),
            subtitle: const Text(CvData.github),
            onTap: () => _ouvrirLien(CvData.github),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.facebook),
            title: const Text("Facebook"),
            subtitle: const Text("Profil Facebook"),
            onTap: () => _ouvrirLien(CvData.facebook),
          ),
        ),
      ],
    );
  }
}
