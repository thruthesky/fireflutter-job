import 'dart:async';

import 'package:extended/extended.dart';
import 'package:fe/screens/job/fireflutter-job/address_search.model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class JobService {
  static JobService? _instance;
  static JobService get instance {
    if (_instance == null) {
      _instance = JobService();
    }
    return _instance!;
  }

  final apiUrl =
      "https://www.juso.go.kr/addrlink/addrEngApi.do?currentPage=1&countPerPage=100&confmKey=U01TX0FVVEgyMDIyMDQwNzIyMDI0MDExMjQzNzE=&resultType=json&keyword=";

  /// DB 에 저장되는 값이 아래와 같이 동일한 문자로 저장이 된다. 대소문자 및 철자가 동일하다.
  /// 그래서, 검색을 할 때, 동일하게 검색 할 수 있는 것이다.
  final Map<String, List<String>> areas = {
    'Seoul': [
      'Jongno-gu',
      'Jung-gu',
      'Yongsan-gu',
      'Seongdong-gu',
      'Gwangjin-gu',
      'Dongdaemun-gu',
      'Jungnang-gu',
      'Seongbuk-gu',
      'Gangbuk-gu',
      'Dobong-gu',
      'Nowon-gu',
      'Eunpyeong-gu',
      'Seodaemun-gu',
      'Mapo-gu',
      'Yangcheon-gu',
      'Gangseo-gu',
      'Guro-gu',
      'Gumcheon-gu',
      'Yeongdeungpo-gu',
      'Dongjak-gu',
      'Gwanak-gu',
      'Seocho-gu',
      'Gangnam-gu',
      'Songpa-gu',
      'Gangdong',
    ],
    'Busan': [
      'Jung-gu',
      'Seo-gu',
      'Dong-gu',
      'Yeongdo-gu',
      'Busanjin-gu',
      'Dongnae-gu',
      'Nam-gu',
      'Buk-gu',
      'Haeundae-gu',
      'Saha-gu',
      'Geumjeong-gu',
      'Gangseo-gu',
      'Yeonje-gu',
      'Suyeong-gu',
      'Sasang-gu',
      'Gijang-gun',
    ],
    'Daegu': [
      'Jung-gu',
      'Dong-gu',
      'Seo-gu',
      'Nam-gu',
      'Buk-gu',
      'Suseong-gu',
      'Dalseo-gu',
      'Dalseong-gun',
    ],
    'Incheon': [
      'Jung-gu',
      'Dong-gu',
      'Michuhol-gu',
      'Yeonsu-gu',
      'Namdong-gu',
      'Bupyeong-gu',
      'Gyeyang-gu',
      'Seo-gu',
      'Ganghwa-gun',
      'Ongjin-gun',
    ],
    'Gwangju': [
      'Dong-gu',
      'Seo-gu',
      'Nam-gu',
      'Buk-gu',
      'Gwangsan-gu',
    ],
    'Daejeon': [
      'Dong-gu',
      'Jung-gu',
      'Seo-gu',
      'Yuseong-gu',
      'Daedeok-gu',
    ],
    'Ulsan': [
      'Jung-gu',
      'Nam-gu',
      'Dong-gu',
      'Buk-gu',
      'Ulju-gun',
    ],
    'Sejong': [],
    'Gyeonggi-do': [
      'Suwon-si',
      'Jangan-gu',
      'Gwonseon-gu',
      'Paldal-gu',
      'Yeongtong-gu',
      'Seongnam-si',
      'Sujeong-gu',
      'Jungwon-gu',
      'Bundang-gu',
      'Uijeongbu-si',
      'Anyang-si',
      'Manan-gu',
      'Dongan-gu',
      'Bucheon-si',
      'Gwangmyeong-si',
      'Pyeongtaek-si',
      'Dongducheon-si',
      'Ansan-si',
      'Sangnok-gu',
      'Danwon-gu',
      'Goyang-si',
      'Deogyang-gu',
      'Ilsandong-gu',
      'Ilsanseo-gu',
      'Gwacheon-si',
      'Guri-si',
      'Namyangju-si',
      'Osan-si',
      'Siheung-si',
      'Gunpo-si',
      'Uiwang-si',
      'Hanam -si',
      'Yongin-si',
      'Cheoin-gu',
      'Giheung-gu',
      'Suji-gu',
      'Paju-si',
      'Icheon-si',
      'Anseong-si',
      'Gimpo-si',
      'Hwaseong-si',
      'Gwangju-si',
      'Yangju-si',
      'Pocheon-si',
      'Yeoju-si',
      'Yeoncheon-gun',
      'Gapyeong-gun',
      'Yangpyeong-gun',
    ],
    'Gangwon-do': [
      'Chuncheon-si',
      'Wonju-si',
      'Gangneung-si',
      'Donghae-si',
      'Taebaek-si',
      'Sokcho-si',
      'Samcheok-si',
      'Hongcheon-gun',
      'Hoengseong-gun',
      'Yeongwol-gun',
      'Pyongchang-gun',
      'Jeongseon-gun',
      'Cheorwon-gun',
      'Hwacheon-gun',
      'Yanggu-gun',
      'Inje-gun',
      'Goseong-gun',
      'Yangyang-gun',
    ],
    'Chungcheongbuk-do': [
      'Cheongju-si',
      'Sangdang-gu',
      'Seowon-gu',
      'Heungdeok-gu',
      'Cheongwon-gu',
      'Chungju-si',
      'Jecheon-si',
      'Boeun-gun',
      'Okcheon-gun',
      'Yeongdong-gun',
      'Jeungpyeong -gun',
      'Jincheon-gun',
      'Goesan-gun',
      'Umseong-gun',
      'Danyang-gun',
    ],
    'Chungcheongnam-do': [
      'Cheonan-si',
      'Dongnam-gu',
      'Sebuk-gu',
      'Gongju-si',
      'Boryeong-si',
      'Asan-si',
      'Seosan-si',
      'Nonsan-si',
      'Gyeryong-si',
      'Dangjin-si',
      'Gumsan-gun',
      'Buyeo-gun',
      'Socheon-gun',
      'Cheongyang-gun',
      'Hongseong-gun',
      'Yesan-gun',
      'Taean-gun',
    ],
    'Jeollabuk-do': [
      'Jeonju-si',
      'Wansan-gu',
      'Deokjin-gu',
      'Gunsan-si',
      'Iksan-si',
      'Jeongeup-si',
      'Namwon-si',
      'Gimje-si',
      'Wanju-gun',
      'Jinan-gun',
      'Muju-gun',
      'Jangsu-gun',
      'Imsil-gun',
      'Sunchang-gun',
      'Gochang-gun',
      'Buan-gun',
    ],
    'Jeollanam-do': [
      'Mokpo-si',
      'Yeosu-si',
      'Suncheon-si',
      'Naju-si',
      'Gwangyang-si',
      'Damyang-gun',
      'Gokseong-gun',
      'Gurye-gun',
      'Goheung-gun',
      'Boseong-gun',
      'Hwasun-gun',
      'Jangheung-gun',
      'Gangjin-gun',
      'Haenam-gun',
      'Yeongam-gun',
      'Muan-gun',
      'Hampyeong-gun',
      'Yeonggwang-gun',
      'Jangseong-gun',
      'Wando-gun',
      'Jindo-gun',
      'Sinan-gun',
    ],
    'Gyeongsangbuk-do': [
      'Pohang-si',
      'Nam-gu',
      'Buk-gu',
      'Gyeongju-si',
      'Gimcheon-si',
      'Andong-si',
      'Gumi-si',
      'Yeongju-si',
      'Yeongcheon-si',
      'Sangju-si',
      'Mungyeong-si',
      'Gyeongsan-si',
      'Gunwi-gun',
      'Uiseong-gun',
      'Cheongsong-gun',
      'Yeongyang-gun',
      'Yeongdeok-gun',
      'Cheongdo-gun',
      'Goryeong-gun',
      'Seongju-gun',
      'Chilgok-gun',
      'Yecheon-gun',
      'Bonghwa-gun',
      'Uljin-gun',
      'Ulleung-gun',
    ],
    'Gyeongsangnam-do': [
      'Changwon-si',
      'Uichang-gu',
      'Seongsan-gu',
      'Masanhappo-gu',
      'Masanhoewon-gu',
      'Jinhae-gu',
      'Jinju-si',
      'Tongyeong-si',
      'Sacheon-si',
      'Gimhae-si',
      'Miryang-si',
      'Geoje-si',
      'Yangsan-si',
      'Uiryeong-gun',
      'Haman-gun',
      'Changnyeong-gun',
      'Goseong-gun',
      'Namhae-gun',
      'Hadong-gun',
      'Sancheong-gun',
      'Hamyang-gun',
      'Geochang-gun',
      'Hapcheon-gun',
    ],
    'Jeju-do': [
      'Jeju-si',
      'Seogwipo-si',
    ],
  };

  final Map<String, String> categories = {
    'accountant': 'Accountant',
    'call-center': 'Call center',
    'construction': 'Construction',
    'cook': 'Cook, Chef, Backer',
    'customer-service': 'Customer service',
    'education': 'Education, Academic, Teacher',
    'entertainer': 'Entertainer, Musician',
    'factory-work': 'Factory work',
    'farm-work': 'Farm work',
    'management': 'Management',
    'marketing': 'Marketing, Advertising',
    'office-work': 'Office work, Clerk, Cashier',
    'sales': 'Sales, Waiter, Agent',
    'it': 'Tech & IT',
    'travel': 'Tour guide, Travel',
  };

  Future<AddressModel?> inputAddress(context) async {
    return showDialog<AddressModel?>(
      context: context,
      builder: (context) {
        final input = TextEditingController();
        AddressSearchModel? search;
        return StatefulBuilder(
          builder: ((context, setState) {
            Future getAddresses([String keyword = '']) async {
              final url = apiUrl + input.text;
              final dio = Dio();
              final res = await dio.get(url);
              search = AddressSearchModel.fromJson(res.data);
              setState(() => {});
            }

            // Timer(Duration(milliseconds: 500), () {
            //   input.text = "Yeoksam";
            //   if (search != null) return;
            //   getAddresses(input.text);
            // });

// Yeoksam Miryang-si
            return AlertDialog(
              title: Text(
                'Search address',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: input,
                          decoration: InputDecoration(label: Text("Input address.")),
                          onSubmitted: getAddresses,
                        ),
                      ),
                      IconButton(
                        onPressed: getAddresses,
                        icon: Icon(Icons.send),
                      )
                    ],
                  ),
                  spaceXs,
                  Text(
                    'i.e) 536-9, Sinsa-dong',
                    style: TextStyle(fontSize: 11),
                  ),
                  spaceSm,
                  if (search == null) Text('Input address and send'),
                  if (search != null && search!.totalCount == 0)
                    Text("No address found, try again."),
                  if (search != null && search!.totalCount > 0)
                    Container(
                      height: 200,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: search!.addresses
                              .map(
                                (e) => GestureDetector(
                                  onTap: () => Navigator.of(context).pop(e),
                                  behavior: HitTestBehavior.opaque,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${e.roadAddr}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      spaceXxs,
                                      Text(
                                        '${e.korAddr}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  if (search != null && search!.totalCount > 100)
                    Column(
                      children: [
                        spaceXs,
                        Text(
                          '* Warning - there are too much addresses by the search and cannot dispaly all. Please narrow the search.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    )
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
