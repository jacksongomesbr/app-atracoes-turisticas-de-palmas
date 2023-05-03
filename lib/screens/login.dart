import 'package:app_turismo_palmas/screens/home.dart';
import 'package:flutter/material.dart';

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({Key? key}) : super(key: key);

  @override
  State<PaginaLogin> createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  late String username;
  late String password;
  bool enviando = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(28),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Atrações Turísticas de Palmas',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  enabled: !enviando,
                  decoration: InputDecoration(
                    hintText: 'Nome de usuário',
                    helperText: 'Forneça seu nome de usuário',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe o nome do usuário';
                    }
                    setState(() {
                      username = value.trim();
                    });
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  enabled: !enviando,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    helperText: 'Forneça sua senha',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe a sua senha';
                    }
                    setState(() {
                      password = value.trim();
                    });
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: enviando
                          ? null
                          : () {
                              print('esqueceu a senha?');
                            },
                      child: Text('Esqueceu sua senha?'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: enviando
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    enviando = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Aguarde...'),
                                    ),
                                  );
                                  if (username == 'admin' &&
                                      password == 'admin') {
                                    await Future.delayed(
                                      const Duration(seconds: 5),
                                      () {
                                        setState(() {
                                          enviando = false;
                                        });
                                        Navigator.pushNamed(context, '/home');
                                      },
                                    );
                                  } else {
                                    await Future.delayed(
                                      const Duration(seconds: 5),
                                      () {
                                        setState(() {
                                          enviando = false;
                                        });
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  Text('Entrar no aplicativo'),
                                              content: Text(
                                                  'Não foi possível acessar sua '
                                                  'área de usuário porque '
                                                  'as informações '
                                                  '(nome de usuário e senha) '
                                                  'estão incorretas. \n\n'
                                                  'Por favor, verifique as '
                                                  'informações e tente '
                                                  'novamente dentro de '
                                                  'alguns instantes.'),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  }
                                }
                                _formKey.currentState!.reset();
                        },
                        child: enviando ? Text('Aguarde...') : Text('Entrar'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('Ainda não tem uma conta de usuário?'),
                    ),
                    TextButton(
                      onPressed: enviando
                          ? null
                          : () {
                              print('criar conta');
                            },
                      child: const Text('Criar conta'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
