import 'package:about_canada/model/details.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../model/apis/api_response.dart';
import '../../model/country.dart';
import '../../resource/app_colors.dart';
import '../../resource/app_constants.dart';
import '../../resource/app_styles.dart';
import '../../utils/CachedImage.dart';
import '../../view_model/country_view_model.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchInputController = TextEditingController();

  var _countryFuture;

  List<Details>? _detailsSearchList = [];
  List<Details>? _detailsList = [];

  String? _appBarTitle = AppConstants.loadingTitle;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _countryFuture = Provider.of<CountryViewModel>(context, listen: false).fetchCountryData();
    });

  }

  @override
  Widget build(BuildContext context) {

    ApiResponse countryResponse = Provider.of<CountryViewModel>(context).countryResponse;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: FutureBuilder(
        future: _countryFuture,
        builder: (context, snapshot) => Text(_appBarTitle!)
        )
    ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: AppColors.white,
          child: Column(
            children: <Widget>[
              buildSearchWidget(),
              Expanded(child: getCountryDetailsWidget(context, countryResponse)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key(AppConstants.floatingButtonKey),
        onPressed: () {
          Provider.of<CountryViewModel>(context, listen: false).fetchCountryData();
        },
        child: const Icon(Icons.refresh),
        backgroundColor: AppColors.primary,
      ),
    );
  }


  /// Builds Search text field widget
  Container buildSearchWidget() {
    return Container(
              margin: const EdgeInsets.all(AppConstants.spaceMedium),
              decoration: BoxDecoration(
                color: AppColors.grey.withAlpha(AppConstants.alphaMedium),
                borderRadius: const BorderRadius.all(Radius.circular(AppConstants.radiusBig)),
              ),
              child: TextField(
                  key: const Key(AppConstants.searchViewKey),
                  textAlignVertical: TextAlignVertical.center,
                  controller: _searchInputController,
                  keyboardType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(AppConstants.onlyAlphabets)),
                  ],
                  onChanged: onSearchTextChanged,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: AppConstants.spaceMedium),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: AppConstants.enterTitle,
                      suffixIcon: IconButton(onPressed: (){
                      }, icon: Icon(Icons.search, color: AppColors.grey,))
                  )
              ),
            );
  }


  ///Builds Search info widget
  SizedBox buildSearchInfoWidget() {
    return SizedBox(
      height: AppConstants.containerBig,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: AppConstants.containerSmall, color: AppColors.grey,),
            const SizedBox(height: AppConstants.spaceBig,),
            const Text(AppConstants.enterTitle),
          ],
        ),
      ),
    );
  }


  ///Builds Country details widget with api response
  Widget getCountryDetailsWidget(BuildContext context, ApiResponse apiResponse) {
    Country? country = apiResponse.data;

    if(country!=null){
      setState(() {
        _appBarTitle = country.title;

        country.rows.removeWhere((e) => e.title == null && e.description == null && e.imageHref == null);
        _detailsList = country.rows;


        print("_detailsList : "+_detailsList!.length.toString());
        print("_appBarTitle : "+_appBarTitle.toString());
      });
    }

    switch (apiResponse.status) {
      case Status.LOADING:
        return buildLoadingWidget();
      case Status.COMPLETED:
        return _detailsSearchList!.isNotEmpty || _searchInputController.text.isNotEmpty ?
        Scrollbar(
          child: ListView.builder(
            key: const Key(AppConstants.searchListViewKey),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _detailsSearchList!.length,
            itemBuilder: (BuildContext context, int index) {
              Details data = _detailsSearchList![index];
              return buildDetailsItem(data);
            },
          ),
        ):Scrollbar(
          child: ListView.builder(
            key: const Key(AppConstants.normalListViewKey),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _detailsList!.length,
            itemBuilder: (BuildContext context, int index) {
              Details data = _detailsList![index];
              return buildDetailsItem(data);
            },
          ),
        );
      case Status.ERROR:
        return buildErrorWidget();
      case Status.INITIAL:
      default:
        return Container();
    }
  }


  ///Builds loading indicator with circular progress indicator
  SizedBox buildLoadingWidget() => const SizedBox(
    key: Key(AppConstants.loadingWidgetKey),
      height: AppConstants.containerBig, child: Center(child: CircularProgressIndicator()));


  ///Builds error widget when api response return error
  SizedBox buildErrorWidget() {
    return const SizedBox(
      key: Key(AppConstants.errorViewKey),
      height: AppConstants.containerBig,
      child: Center(
        child: Text(AppConstants.errorLoadingData),
      ),
    );
  }


  ///Builds List item for details list
  Widget buildDetailsItem(Details details){
    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceBig),
      margin: const EdgeInsets.only(left: AppConstants.spaceMedium, right: AppConstants.spaceMedium,  bottom: AppConstants.spaceSmall, top: AppConstants.spaceSmall),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(AppConstants.radiusBig)),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withAlpha(AppConstants.alphaMedium),
            spreadRadius: AppConstants.dimensionSmall,
            blurRadius: AppConstants.dimensionMedium,
            offset: const Offset(AppConstants.dimensionZero, AppConstants.dimensionSmall), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          details.imageHref!= null ?CachedImage(url: details.imageHref ?? '') : Container(),
          details.imageHref!= null ? const SizedBox(height: AppConstants.spaceMedium,) : Container(),
          details.title!= null ? Text(details.title ?? '', style: AppStyles.textTitleBlackBold,) : Container(),
          details.description!= null ? const SizedBox(height: AppConstants.spaceSmall,) : Container(),
          details.description!= null ? Flexible(child: Text(details.description ?? '', style: AppStyles.textDetailBlack, )):Container(),
        ],
      ),
    );
  }


  ///Search listener for searching title in text field
  onSearchTextChanged(String text) async {
    _detailsSearchList!.clear();
    if (text.isEmpty) {
      setState(() {
        _detailsSearchList = _detailsSearchList;
      });
      return;
    }

    for (var obj in _detailsList!) {
      if (obj.title != null && obj.title.toLowerCase().contains(text)){
        _detailsSearchList!.add(obj);
      }
    }
    setState(() {
      _detailsSearchList = _detailsSearchList;
    });
  }
}