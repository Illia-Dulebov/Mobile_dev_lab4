import 'dart:io';

import 'package:edu_books_flutter/bloc/authorization/auth_bloc.dart';
import 'package:edu_books_flutter/bloc/authorization/auth_event.dart';
import 'package:edu_books_flutter/bloc/authorization/auth_state.dart';
import 'package:edu_books_flutter/models/user_model.dart';

import 'package:edu_books_flutter/styles/text_styles.dart';
import 'package:edu_books_flutter/widgets/buttons/cart_button.dart';
import 'package:edu_books_flutter/widgets/buttons/primary_buttons.dart';
import 'package:edu_books_flutter/widgets/buttons/svg_icon_buttons.dart';
import 'package:edu_books_flutter/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class AccountEditPage extends StatelessWidget {
  const AccountEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            isMobile
                ? SizedBox()
                : SvgPicture.asset(
                    'assets/images/background_desktop.svg',
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill,
                  ),
            Padding(
              padding: EdgeInsets.only(top: isMobile ? 0.0 : 220.0),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    isMobile
                        ? SvgPicture.asset(
                            'assets/images/background.svg',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          )
                        : SizedBox(),
                    Padding(
                      padding: isMobile
                          ? EdgeInsets.fromLTRB(0, 130, 0, 50)
                          : EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Center(
                        child: SizedBox(
                          width: isMobile ? double.infinity : 1000,
                          child: BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) => {
                              if (state.updateUserStatus == Status.success)
                                {
                                  Navigator.pop(context),
                                }
                            },
                            listenWhen: (previous, current) =>
                                current.updateUserStatus == Status.success,
                            builder: (context, state) {
                              if (state.updateUserStatus == Status.loading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF6957FE),
                                  ),
                                );
                              }

                              return UserInfo(
                                user: state.user!,
                                errorMessages: state.errorMessages ?? [],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height / 1.7,
              child: CartButton(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: NavBar(
                currentIndex: -1,
                svgIconButton: SvgIconButton(
                  width: isMobile ? 20 : 34,
                  height: isMobile ? 20 : 34,
                  assetName: 'assets/icons/arrow_back.svg',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                withAccountIcon: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatefulWidget {
  const UserInfo({
    Key? key,
    required this.user,
    required this.errorMessages,
  }) : super(key: key);

  final UserModel user;
  final List<dynamic> errorMessages;

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    emailController.text = widget.user.email;
    nameController.text = widget.user.name;
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1000;

    getImageGallery() async {
      final picker = ImagePicker();

      var image = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1000,
        maxWidth: 1000,
      );

      if (image != null) {
        BlocProvider.of<AuthBloc>(context).add(
          UploadAvatar(file: File(image.path)),
        );
      }
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Stack(
            children: [
              Container(
                width: isMobile ? 95 : 115,
                height: isMobile ? 95 : 115,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primaryColors[0],
                    width: 3.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 3.0 : 4.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.user.avatar,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: primaryColors[0],
                    child: IconButton(
                      splashRadius: 17,
                      onPressed: () {
                        getImageGallery();
                      },
                      icon: Icon(
                        Icons.add_to_photos,
                        size: 20,
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 45),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Привіт, ",
                  style: TextStyle(
                    color: primaryColors[1],
                    fontFamily: 'Manrope',
                    fontSize: isMobile ? 18 : 20,
                  ),
                ),
                TextSpan(
                  text: widget.user.name,
                  style: TextStyle(
                    color: primaryColors[1],
                    fontSize: isMobile ? 18 : 20,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: isMobile ? double.infinity : 400,
          child: Column(
            children: [
              Padding(
                padding: isMobile
                    ? EdgeInsets.fromLTRB(25, 0, 25, 15)
                    : EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: NameField(
                    nameController: nameController, isMobile: isMobile),
              ),
              Padding(
                padding: isMobile
                    ? EdgeInsets.fromLTRB(25, 0, 25, 0)
                    : EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: EmailField(
                    emailController: emailController, isMobile: isMobile),
              ),
              widget.errorMessages.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        widget.errorMessages.join('\n'),
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 55),
          child: SizedBox(
            width: 181,
            height: 42,
            child: PrimaryButtonWithIcon(
              icon: Icon(
                Icons.save_outlined,
                size: 17,
                color: Colors.white,
              ),
              title: 'зберегти',
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(
                  UserInfoUpdate(
                    email: emailController.text,
                    name: nameController.text,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    required this.emailController,
    required this.isMobile,
  }) : super(key: key);

  final TextEditingController emailController;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      autocorrect: false,
      cursorColor: Color(0xff181B19),
      style: TextStyle(
        color: Color(0xff181B19),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail_outline,
          color: primaryColors[1],
          size: isMobile ? 20 : 25,
        ),
        filled: true,
        isDense: true,
        fillColor: Color(0xffF2F3F2),
        contentPadding: EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}

class NameField extends StatelessWidget {
  const NameField({
    Key? key,
    required this.nameController,
    required this.isMobile,
  }) : super(key: key);

  final TextEditingController nameController;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      autocorrect: false,
      cursorColor: Color(0xff181B19),
      style: TextStyle(
        color: Color(0xff181B19),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person_outline,
          color: primaryColors[1],
          size: isMobile ? 20 : 25,
        ),
        filled: true,
        isDense: true,
        fillColor: Color(0xffF2F3F2),
        contentPadding: EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
