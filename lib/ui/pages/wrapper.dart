part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User firebaseUser = Provider.of<User>(context);

    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        // prevPageEvent = GoToSplashPage();
        // BlocProvider.of<PageBloc>(context).add(prevPageEvent);
        //context.watch<PageBloc>().add(prevPageEvent);
        return SplashPage();
        //Get.off(SplashPage());
      }
    } else {
      BlocProvider.of<UserBloc>(context).add(LoadUser(firebaseUser.uid));
      BlocProvider.of<TicketBloc>(context).add(GetTickets(firebaseUser.uid));
      // context.watch<UserBloc>().add(LoadUser(firebaseUser.uid));
      // context.watch<TicketBloc>().add(GetTickets(firebaseUser.uid));

      //prevPageEvent = GoToMainPage();

      return MainPage();

      //Get.off(MainPage());

      // BlocProvider.of<PageBloc>(context).add(prevPageEvent);
      // context.watch<PageBloc>().add(prevPageEvent);

      // if (!(prevPageEvent is GoToMainPage)) {
      //   BlocProvider.of<UserBloc>(context).add(LoadUser(firebaseUser.uid));
      //   BlocProvider.of<TicketBloc>(context).add(GetTickets(firebaseUser.uid));
      //   // context.watch<UserBloc>().add(LoadUser(firebaseUser.uid));
      //   // context.watch<TicketBloc>().add(GetTickets(firebaseUser.uid));

      //   prevPageEvent = GoToMainPage();
      //   BlocProvider.of<PageBloc>(context).add(prevPageEvent);
      //   // context.watch<PageBloc>().add(prevPageEvent);
      // }
    }

    return MainPage();

    // return BlocListener<PageBloc, PageState>(
    //   listener: (context, pageState) {
    //     if (pageState is OnSplashPage) {
    //       return Get.off(SplashPage());
    //     } else if (pageState is OnLoginPage) {
    //       return Get.to(SignInPage());
    //     }
    //   },
    //   child: Container(),
    // );

    // return BlocBuilder<PageBloc, PageState>(
    //   builder: (_, pageState) => (pageState is OnSplashPage)
    //       ? Get.off(SplashPage())
    //       : (pageState is OnLoginPage)
    //           ? Get.to(SignInPage())
    //           : (pageState is OnRegistrationPage)
    //               ? SignUpPage(pageState.registrationData)
    //               : (pageState is OnPreferencePage)
    //                   ? PreferencePage(pageState.registrationData)
    //                   : (pageState is OnAccountConfirmationPage)
    //                       ? AccountConfirmationPage(pageState.registrationData)
    //                       : (pageState is OnMovieDetailPage)
    //                           ? MovieDetailPage(pageState.movie)
    //                           : (pageState is OnSelectSchedulePage)
    //                               ? SelectSchedulePage(pageState.movieDetail)
    //                               : (pageState is OnSelectSeatPage)
    //                                   ? SelectSeatPage(pageState.ticket)
    //                                   : (pageState is OnCheckoutPage)
    //                                       ? CheckoutPage(pageState.ticket)
    //                                       : (pageState is OnSuccessPage)
    //                                           ? SuccessPage(pageState.ticket,
    //                                               pageState.transaction)
    //                                           : (pageState
    //                                                   is OnTicketDetailPage)
    //                                               ? TicketDetailPage(
    //                                                   pageState.ticket)
    //                                               : (pageState is OnProfilePage)
    //                                                   ? ProfilePage(
    //                                                       user: pageState.user)
    //                                                   : (pageState
    //                                                           is OnEditProfilePage)
    //                                                       ? EditProfilePage(
    //                                                           pageState.user)
    //                                                       : (pageState
    //                                                               is OnMainPage)
    //                                                           ? MainPage(
    //                                                               bottomNavbarIndex:
    //                                                                   pageState
    //                                                                       .bottomNavigationIndex)
    //                                                           : (pageState
    //                                                                   is OnTopUpPage)
    //                                                               ? TopUpPage(
    //                                                                   pageState
    //                                                                       .pageEvent)
    //                                                               : (pageState
    //                                                                       is OnWalletPage)
    //                                                                   ? WalletPage(
    //                                                                       pageState
    //                                                                           .pageEvent)
    //                                                                   : Container(),
    // );
  }
}
