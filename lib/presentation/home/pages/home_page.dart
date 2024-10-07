import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_project/common/widgets/appbar/base_app_bar.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/presentation/home/widgets/news_songs.dart';
import 'package:spotify_project/presentation/home/widgets/play_list.dart';
import 'package:spotify_project/presentation/profile/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
        hideBack: true,
        action: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ));
          },
          icon: const Icon(
            Icons.person_2_rounded,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _homeArtistCard(),
            const SizedBox(height: 20),
            _tab(),
            SizedBox(
              height: 250,
              child: TabBarView(
                controller: _tabController,
                children: [
                  const NewsSongs(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const PlayList(),
          ],
        ),
      ),
    );
  }

  Widget _homeArtistCard() {
    return Container(
      height: 140,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              AppVectors.homeArtist,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 60),
              child: Image.asset(
                AppImages.artist,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tab() {
    return TabBar(
      controller: _tabController,
      // isScrollable: true,
      indicatorColor: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      tabs: const [
        Text(
          "News",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Vidoes",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Artists",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Podcast",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
