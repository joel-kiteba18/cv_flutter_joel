import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MonCvApp());
}

// ============================================================================
// 1. VOS DONNÉES PERSONNELLES (MODIFIEZ UNIQUEMENT CETTE SECTION)
// ============================================================================
class CvData {
  // --- PAGE 2 : VOTRE CV ---
  static const String nomComplet = "Joël Kiteba";
  static const String titreProfil =
      "Développeur Mobile Senior (Flutter & Android)";
  static const String photoProfilUrl = "assets/images/joel.jpg"; // Remplacez par le chemin de votre photo dans le dossier assets/images
  static const String biographie =
      "Professionnel en programmation mobile, spécialisé dans la conception d'applications performantes, intuitives et sécurisées avec Flutter, Dart et Android natif.";

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

  // --- PAGE 3 : VOTRE FAMILLE ---
  static const List<Map<String, String>> famille = [
    {
      "nom": "Jean-Claude Kiteba",
      "lien": "Père",
      "profession": "Commerçant",
      "photo": "https://pravatar.cc",
    },
    {
      "nom": "Christine Baguni",
      "lien": "Mère",
      "profession": "Enseignante",
      "photo": "https://pravatar.cc",
    },
    {
      "nom": "Rachel Baguni",
      "lien": "Sœur",
      "profession": "Médecin Généraliste",
      "photo": "https://pravatar.cc",
    },
    {
      "nom": "Jonas Kiteba",
      "lien": "Frère",
      "profession": "Étudiant Electronicien",
      "photo": "https://pravatar.cc",
    },
  ];

  // --- PAGE 4 : VOS COORDONNÉES ---
  static const String telephone = "+243 838696468";
  static const String email = "joelkiteba@gmail.com";
  static const String adresse = "Quartier Katindo, Goma, Nord-Kivu, RDC";
  static const String linkedin = "www.linkedin.com/in/joel-kiteba-144757367";
  static const String github = "https://github.com/joel-kiteba18";
  static const String facebook =
      "https://www.facebook.com/profile.php?id=61573650112011";
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
// PAGE (1) : CONNEXION
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

  @override
  void dispose() {
    _identifiantController.dispose();
    _motDePasseController.dispose();
    super.dispose();
  }

  void _seConnecter() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const MainNavigationPage(),
        ),
      );
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
                        decoration: const InputDecoration(
                          labelText: "Identifiant",
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Veuillez entrer votre identifiant";
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
                        child: FilledButton.icon(
                          onPressed: _seConnecter,
                          icon: const Icon(Icons.login),
                          label: const Text(
                            "Se connecter",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Utilisez le code avec précaution.
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
// NAVIGATION PRINCIPALE (BOTTOM NAVIGATION BAR + DÉCONNEXION)
// ============================================================================
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});
  @override
  State createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State {
  int _indexActuel = 0;
  late final List pages = const [AccueilCvPage(), FamillePage(), ContactPage()];
  final List _titres = const ["Accueil - Mon CV", "Ma Famille", "Contact"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titres[_indexActuel],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: "Se déconnecter",
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
      body: IndexedStack(
        index: _indexActuel,
        children: List<Widget>.from(pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indexActuel,
        onDestinationSelected: (int index) {
          setState(() {
            _indexActuel = index;
          });
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
            icon: Icon(Icons.contact_phone_outlined),
            selectedIcon: Icon(Icons.contact_phone),
            label: "Contact",
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// PAGE (2) : ACCUEIL (CV COMPLET)
// ============================================================================
class AccueilCvPage extends StatelessWidget {
  const AccueilCvPage({super.key});
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Carte Profil
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 52,
                    backgroundColor: colorScheme.primaryContainer,
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/joel.jpg",
                        width: 104,
                        height: 104,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (
                              BuildContext context,
                              Object error,
                              StackTrace? stackTrace,
                            ) {
                              return Icon(
                                Icons.person,
                                size: 50,
                                color: colorScheme.primary,
                              );
                            },
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    CvData.nomComplet,
                    style: Theme.of(context).textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    CvData.titreProfil,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(CvData.biographie, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Expériences (Stages, projets, emplois)
          _titreSection(
            context,
            Icons.work_outline,
            "Expériences (Emplois, Stages, Projets)",
          ),
          ...CvData.experiences.map(
            (Map<String, String> exp) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp["poste"] ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${exp["entreprise"] ?? ""} • ${exp["periode"] ?? ""}",
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(exp["description"] ?? ""),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Formation
          _titreSection(context, Icons.school_outlined, "Formation"),
          ...CvData.formations.map(
            (Map<String, String> form) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Icon(Icons.school, color: colorScheme.primary),
                title: Text(
                  form["diplome"] ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${form["ecole"] ?? ""} (${form["annee"] ?? ""})",
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Compétences techniques
          _titreSection(context, Icons.code, "Compétences Techniques"),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: CvData.competencesTechniques
                    .map(
                      (String skill) => Chip(
                        label: Text(skill),
                        backgroundColor: colorScheme.secondaryContainer,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Compétences linguistiques
          _titreSection(context, Icons.language, "Compétences Linguistiques"),
          Card(
            child: Column(
              children: CvData.langues.entries
                  .map(
                    (MapEntry<String, String> e) => ListTile(
                      dense: true,
                      leading: const Icon(Icons.translate, size: 20),
                      title: Text(
                        e.key,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(e.value),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          // Centres d'intérêt
          _titreSection(context, Icons.interests_outlined, "Centres d'intérêt"),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: CvData.centresInteret
                    .map(
                      (String interet) => Chip(
                        avatar: const Icon(Icons.star_border, size: 18),
                        label: Text(interet),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titreSection(BuildContext context, IconData icon, String titre) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              titre,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// PAGE (3) : FAMILLE
// ============================================================================
class FamillePage extends StatelessWidget {
  const FamillePage({super.key});
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: CvData.famille.length,
      itemBuilder: (BuildContext context, int index) {
        final Map<String, String> membre = CvData.famille[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundColor: colorScheme.primaryContainer,
                  child: ClipOval(
                    child: Image.network(
                      membre["photo"] ?? "",
                      width: 68,
                      height: 68,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (
                            BuildContext context,
                            Object error,
                            StackTrace? stackTrace,
                          ) {
                            return Icon(
                              Icons.person,
                              size: 32,
                              color: colorScheme.primary,
                            );
                          },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        membre["nom"] ?? "",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          membre["lien"] ?? "",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.work_outline,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              membre["profession"] ?? "",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ============================================================================
// PAGE (4) : CONTACT
// ============================================================================
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});
  Future ouvrirLien(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    try {
      final bool ok = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!ok && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Impossible d'ouvrir : $url")));
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Aucune application compatible trouvée."),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(
                  Icons.contact_mail_rounded,
                  size: 48,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  "Mes Coordonnées",
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Appuyez sur un contact pour lancer l'action",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(Icons.phone, color: colorScheme.primary),
                ),
                title: const Text("Téléphone"),
                subtitle: const Text(CvData.telephone),
                trailing: const Icon(Icons.call_made, size: 18),
                onTap: () => ouvrirLien(
                  context,
                  "tel:${CvData.telephone.replaceAll(' ', '')}",
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(Icons.email, color: colorScheme.primary),
                ),
                title: const Text("E-mail"),
                subtitle: const Text(CvData.email),
                trailing: const Icon(Icons.call_made, size: 18),
                onTap: () => ouvrirLien(
                  context,
                  "mailto:${CvData.email}?subject=Contact depuis votre application CV",
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(Icons.location_on, color: colorScheme.primary),
                ),
                title: const Text("Adresse"),
                subtitle: const Text(CvData.adresse),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorScheme.secondaryContainer,
                  child: Icon(
                    Icons.business_center,
                    color: colorScheme.secondary,
                  ),
                ),
                title: const Text("LinkedIn"),
                subtitle: const Text(CvData.linkedin),
                trailing: const Icon(Icons.open_in_new, size: 18),
                onTap: () => ouvrirLien(context, CvData.linkedin),
              ),
              const Divider(height: 1),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorScheme.secondaryContainer,
                  child: Icon(Icons.code, color: colorScheme.secondary),
                ),
                title: const Text("GitHub"),
                subtitle: const Text(CvData.github),
                trailing: const Icon(Icons.open_in_new, size: 18),
                onTap: () => ouvrirLien(context, CvData.github),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
