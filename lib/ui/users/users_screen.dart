import 'package:e_commerce/data/local/storage_repository.dart';
import 'package:e_commerce/data/network/repositories/login_repo.dart';
import 'package:e_commerce/data/network/repositories/user_repo.dart';
import 'package:e_commerce/models/user/user_model.dart';
import 'package:e_commerce/ui/login/login_screen.dart';
import 'package:e_commerce/ui/user_detail/user_detail_screen.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
class UsersScreen extends StatefulWidget {
  const UsersScreen({
    super.key,
    required this.userRepo,
    required this.loginRepo
  });
  final UserRepo userRepo;
  final LoginRepo loginRepo;

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  List<UserModel> users = [];
  bool isLoading = true;
  _fletchUsers()async{
    setState(() {
      isLoading = true;
    });
    users = await widget.userRepo.getUsers();
    print('USERS FETCH FINISHED ${users.length}');

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _fletchUsers();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text('Users',style: TextStyle(
            color: Colors.black
          ),),
        ),
        elevation: 0.3,
        actions: [
          IconButton(
            onPressed: (){
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  title: const Text('Log out'),
                  content: const Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text('No'),),
                    TextButton(
                      onPressed: (){
                        if(StorageRepository.deleteString('token') != null ) {
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen(loginRepo: widget.loginRepo)));
                        }
                      },
                      child: const Text('Yes'),),
                  ],
                );
              });
            },
            icon: const Icon(Icons.logout,color: Colors.red,),
          ),
        ],
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : ListView(
        children: [
          ...List.generate(users.length, (index) {
            print(users[index].name.firstname.capitalize());
            return ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailScreen(userModel: users[index])));
              },
              leading: const Icon(Icons.account_circle_rounded,size: 40,),
              title: Text('${users[index].name.firstname.capitalize()} ${users[index].name.lastname.capitalize()}'),
              trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            );
          }),
        ],
      ),
    );
  }
}
