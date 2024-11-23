import 'package:flutter/material.dart';

void main() {
  runApp(const FilmApp());
}

class FilmApp extends StatelessWidget {
  const FilmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FilmHomePage(),
    );
  }
}

class Film {
  final String title;
  final String genre;
  final String cast;
  final String description;
  final String posterUrl;

  Film({
    required this.title,
    required this.genre,
    required this.cast,
    required this.description,
    required this.posterUrl,
  });
}

class FilmHomePage extends StatefulWidget {
  const FilmHomePage({super.key});

  @override
  _FilmHomePageState createState() => _FilmHomePageState();
}

class _FilmHomePageState extends State<FilmHomePage> {
  final List<Film> _films = [
    Film(
      title: "Pengabdi Setan",
      genre: "Horor",
      cast: "Tara Basro, Bront Palarae, Ayu Laksmi",
      description: "Kisah teror keluarga setelah ibu mereka meninggal.",
      posterUrl: "https://upload.wikimedia.org/wikipedia/id/e/e1/Pengabdi_Setan_poster.jpg",
    ),
    Film(
      title: "Laskar Pelangi",
      genre: "Drama",
      cast: "Ikranagara, Cut Mini, Zulfanny",
      description: "Kisah perjuangan anak-anak Belitung dalam meraih pendidikan.",
      posterUrl: "https://upload.wikimedia.org/wikipedia/id/thumb/1/17/Laskar_Pelangi_film.jpg/220px-Laskar_Pelangi_film.jpg",
    ),
  ];

  void _addFilm(Film film) {
    setState(() {
      _films.add(film);
    });
  }

  void _updateFilm(int index, Film updatedFilm) {
    setState(() {
      _films[index] = updatedFilm;
    });
  }

  void _deleteFilm(int index) {
    setState(() {
      _films.removeAt(index);
    });
  }

  void _showFilmForm([int? index]) {
    final isEditing = index != null;
    final film = isEditing ? _films[index!] : null;

    final titleController = TextEditingController(text: film?.title);
    final genreController = TextEditingController(text: film?.genre);
    final castController = TextEditingController(text: film?.cast);
    final descriptionController = TextEditingController(text: film?.description);
    final posterController = TextEditingController(text: film?.posterUrl);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? "Edit Film" : "Add Film"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Judul"),
              ),
              TextField(
                controller: genreController,
                decoration: const InputDecoration(labelText: "Genre"),
              ),
              TextField(
                controller: castController,
                decoration: const InputDecoration(labelText: "Daftar Pemain"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Deskripsi"),
              ),
              TextField(
                controller: posterController,
                decoration: const InputDecoration(labelText: "URL Poster"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final newFilm = Film(
                title: titleController.text,
                genre: genreController.text,
                cast: castController.text,
                description: descriptionController.text,
                posterUrl: posterController.text,
              );

              if (isEditing) {
                _updateFilm(index!, newFilm);
              } else {
                _addFilm(newFilm);
              }
              Navigator.pop(context);
            },
            child: Text(isEditing ? "Update" : "Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Film Manager"),
      ),
      body: ListView.builder(
        itemCount: _films.length,
        itemBuilder: (context, index) {
          final film = _films[index];
          return Card(
            child: ListTile(
              leading: Image.network(film.posterUrl, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(film.title),
              subtitle: Text("${film.genre} - Pemain: ${film.cast}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showFilmForm(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteFilm(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFilmForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
