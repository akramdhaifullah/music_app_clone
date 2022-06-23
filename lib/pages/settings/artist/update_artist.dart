// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:music_app_clone/pages/home/home.dart';
import 'package:provider/provider.dart';

import 'package:music_app_clone/main.dart';
import 'package:music_app_clone/models/artist.dart';

class UpdateArtist extends StatefulWidget {
  @override
  State<UpdateArtist> createState() => _UpdateArtistState();
}

class _UpdateArtistState extends State<UpdateArtist> {
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isButtonActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameController.addListener(() {
      final isButtonActive = nameController.text.isNotEmpty;

      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 19, 19, 19),
            leading: backButton(),
            title: const Text(
              'Update Artist',
            ),
            centerTitle: true,
            elevation: 0,
          ),
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            nameField(),
            SizedBox(height: 40),
            deleteButton(),
          ],
        ),
      ),
    );
  }

  Widget backButton() {
    return GestureDetector(
      child: Icon(Icons.arrow_back_ios),
      onTap: () {
        navigatorKey.currentState!.pop();
      },
    );
  }

  Widget nameField() {
    return SizedBox(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: nameController,
              cursorColor: Colors.green,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                fillColor: Color.fromARGB(255, 75, 75, 75),
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (value) {
                ArtistOperations ao = ArtistOperations();
                String checkArtist = nameController.text.trim();
                return ao.checkArtistForUpdate(checkArtist, data);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget deleteButton() {
    return Align(
      alignment: Alignment.center,
      child: MaterialButton(
        child: Text(
          'Check Artist',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        disabledColor: Colors.white10,
        disabledTextColor: Colors.black,
        color: Colors.white,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        minWidth: 120,
        height: 50,
        onPressed: isButtonActive ? updateArtist : null,
      ),
    );
  }

  void updateArtist() {
    FocusScope.of(context).unfocus();
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      navigatorKey.currentState!
          .push(MaterialPageRoute(builder: ((context) => SetNewArtist())));
    }
  }
}

class SetNewArtist extends StatefulWidget {
  @override
  State<SetNewArtist> createState() => _SetNewArtistState();
}

class _SetNewArtistState extends State<SetNewArtist> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isButtonActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameController.addListener(() {
      final isButtonActive = nameController.text.isNotEmpty;

      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 19, 19, 19),
            leading: backButton(),
            title: Consumer<ArtistOperations>(
              builder: (context, value, child) => Text(
                'Update ${navigatorKey.currentContext!.read<ArtistOperations>().getDataName}',
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            nameField(),
            SizedBox(height: 20),
            imageField(),
            SizedBox(height: 40),
            addButton(),
          ],
        ),
      ),
    );
  }

  Widget backButton() {
    return GestureDetector(
      child: Icon(Icons.arrow_back_ios),
      onTap: () {
        navigatorKey.currentState!.pop();
      },
    );
  }

  Widget nameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            controller: nameController,
            cursorColor: Colors.green,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 75, 75, 75),
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          ),
        ),
      ],
    );
  }

  Widget imageField() {
    return SizedBox(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Image URL',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: imageController,
              cursorColor: Colors.green,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                fillColor: Color.fromARGB(255, 75, 75, 75),
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (value) {
                ArtistOperations ao = ArtistOperations();
                String checkArtist = nameController.text.trim();
                return ao.checkArtistsForDuplicate(checkArtist, data);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget addButton() {
    return Align(
      alignment: Alignment.center,
      child: MaterialButton(
        child: Text(
          'Add artist',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        disabledColor: Colors.white10,
        disabledTextColor: Colors.black,
        color: Colors.white,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        minWidth: 120,
        height: 50,
        onPressed: isButtonActive ? setNewArtist : null,
      ),
    );
  }

  void setNewArtist() {
    FocusScope.of(context).unfocus();
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      navigatorKey.currentContext!.read<ArtistOperations>().updateArtist(
          imageController.text.trim(), nameController.text.trim(), data);
    }
  }
}
