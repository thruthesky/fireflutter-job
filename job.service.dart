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
      'Suwon city',
      'Jangan-gu',
      'Gwonseon-gu',
      'Paldal-gu',
      'Yeongtong-gu',
      'Seongnam city',
      'Sujeong-gu',
      'Jungwon-gu',
      'Bundang-gu',
      'Uijeongbu city',
      'Anyang city',
      'Manan-gu',
      'Dongan-gu',
      'Bucheon city',
      'Gwangmyeong city',
      'Pyeongtaek city',
      'Dongducheon city',
      'Ansan city',
      'Sangnok-gu',
      'Danwon-gu',
      'Goyang city',
      'Deogyang-gu',
      'Ilsandong-gu',
      'Ilsanseo-gu',
      'Gwacheon city',
      'Guri city',
      'Namyangju city',
      'Osan city',
      'Siheung city',
      'Gunpo city',
      'Uiwang city',
      'Hanam  city',
      'Yongin city',
      'Cheoin-gu',
      'Giheung-gu',
      'Suji-gu',
      'Paju city',
      'Icheon city',
      'Anseong city',
      'Gimpo city',
      'Hwaseong city',
      'Gwangju city',
      'Yangju city',
      'Pocheon city',
      'Yeoju city',
      'Yeoncheon-gun',
      'Gapyeong-gun',
      'Yangpyeong-gun',
    ],
    'Gangwon-do': [
      'Chuncheon city',
      'Wonju city',
      'Gangneung city',
      'Donghae city',
      'Taebaek city',
      'Sokcho city',
      'Samcheok city',
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
      'Cheongju city',
      'Sangdang-gu',
      'Seowon-gu',
      'Heungdeok-gu',
      'Cheongwon-gu',
      'Chungju city',
      'Jecheon city',
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
      'Cheonan city',
      'Dongnam-gu',
      'Sebuk-gu',
      'Gongju city',
      'Boryeong city',
      'Asan city',
      'Seosan city',
      'Nonsan city',
      'Gyeryong city',
      'Dangjin city',
      'Gumsan-gun',
      'Buyeo-gun',
      'Socheon-gun',
      'Cheongyang-gun',
      'Hongseong-gun',
      'Yesan-gun',
      'Taean-gun',
    ],
    'Jeollabuk-do': [
      'Jeonju city',
      'Wansan-gu',
      'Deokjin-gu',
      'Gunsan city',
      'Iksan city',
      'Jeongeup city',
      'Namwon city',
      'Gimje city',
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
      'Mokpo city',
      'Yeosu city',
      'Suncheon city',
      'Naju city',
      'Gwangyang city',
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
      'Pohang city',
      'Nam-gu',
      'Buk-gu',
      'Gyeongju city',
      'Gimcheon city',
      'Andong city',
      'Gumi city',
      'Yeongju city',
      'Yeongcheon city',
      'Sangju city',
      'Mungyeong city',
      'Gyeongsan city',
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
      'Changwon city',
      'Uichang-gu',
      'Seongsan-gu',
      'Masanhappo-gu',
      'Masanhoewon-gu',
      'Jinhae-gu',
      'Jinju city',
      'Tongyeong city',
      'Sacheon city',
      'Gimhae city',
      'Miryang city',
      'Geoje city',
      'Yangsan city',
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
      'Jeju city',
      'Seogwipo city',
    ],
  };

  Future inputAddress(context) async {
    return showDialog(
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
              print(search);
              setState(() => {});
              print(search?.addresses);
            }

// Yeoksam
            return AlertDialog(
              title: Text('Yo'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: input,
                          decoration: InputDecoration(label: Text("input address")),
                          onSubmitted: getAddresses,
                        ),
                      ),
                      IconButton(
                        onPressed: getAddresses,
                        icon: Icon(Icons.send),
                      )
                    ],
                  ),
                  Text(
                    'i.e) 536-9, Sinsa-dong',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  if (search == null) Text('Input address and send'),
                  if (search != null && search!.totalCount == 0)
                    Text("No address found, try again."),
                  if (search != null && search!.totalCount > 0)
                    Container(
                      height: 200,
                      child: Column(
                        children: search!.addresses.map((e) => Text('e;')).toList(),
                      ),
                    )
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Select'),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}