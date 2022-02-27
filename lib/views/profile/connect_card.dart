import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

List<Map<String, String>> sampleSocialInfo = [
  {
    'display': 'Instagram',
    'url': 'www.apple.com',
    'category': 'Instagram',
  },
  {
    'display': 'Facebook',
    'url': 'www.apple.com',
    'category': 'Facebook',
  },
  {
    'display': 'Twitter',
    'url': 'www.apple.com',
    'category': 'Twitter',
  },
  {
    'display': 'danfu@stanford.edu',
    'url': 'www.apple.com',
    'category': 'mail',
  },
  {
    'display': 'www.danfu.org',
    'url': 'www.apple.com',
    'category': 'compass',
  },
];

class ConnectCard extends StatelessWidget {
  const ConnectCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.of(context).size.width * 0.21,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Connect',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w900
            ),
          ),
          const SizedBox(height: 2),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sampleSocialInfo.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 0,
                leading: Icon(
                  FeatherIconsMap[sampleSocialInfo[index]['category']?.toLowerCase()],
                  size: 20,
                ),
                title: Text(
                  sampleSocialInfo[index]['display'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
