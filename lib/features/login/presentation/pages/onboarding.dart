import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zema/core/service/firebase.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final firebaseAuth = AuthService();
  late PageController _pageController;
  int _currentPage = 0;
  final TextEditingController _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  void _goToNextPage() async {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      if (_formKey.currentState!.validate()) {
        try {
          final username = _usernameController.text;
          firebaseAuth.updateUserName(username);
          context.go("/");
        } catch (e) {
          print(e);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildPage(
                  image: "assets/images/onboarding1.jpg",
                  title: "Bem-vindo ao Zema!",
                  description:
                      "Aqui você pode ler sobre jogos, adicionar jogos na sua lista de favoritos, comentar e avaliar os jogos que você ama!\nFeito com carinho por um gamer, mostre aos outros como você ama, ou até mesmo não gosta de um jogo 😅",
                ),
                _buildPage(
                  image: "assets/images/onboarding2.jpg",
                  title: "O que fazer?",
                  description:
                      "Nesse app, você pode acessar os detalhes de um jogo, as plataformas disponíveis, comentários e avaliações de outros usuários. \nSeu comentário também pode ser avaliádo por outros usuários.",
                ),
                _buildUsernamePage(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  TextButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text("Voltar"),
                  ),
                ElevatedButton(
                  onPressed: _goToNextPage,
                  child: Text(_currentPage < 2 ? "Próximo" : "Finalizar"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          image,
          height: 300,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            description,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildUsernamePage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            SizedBox(
              height: 56,
            ),
            Text(
              "Vamos lá!",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(
              "Antes de começar, por favor, digite seu nome de usuário",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(label: Text("Username")),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Username is required.";
                }

                if (value.trim().length < 4) {
                  return "Password must be higher than 4 characters";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
