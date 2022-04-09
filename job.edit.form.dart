import 'package:extended/extended.dart';
import 'package:fe/screens/job/fireflutter-job/address_search.model.dart';
import 'package:fe/screens/job/fireflutter-job/job.service.dart';
import 'package:flutter/material.dart';

/// 직업 입력 양식
///
/// TODO: 먼저, 글/코멘트 쓰기/수정/삭제 를 HTTP 로 할 수 있도록 해야 한다. 그리고 포인트 증/감을 카테고리 별로 설정 할 수 있도록 해야 한다.
/// TODO: Working Hourse 를 선택 하여, 1시간, 2시간, ... 14시간 까지 선택 할 수 있도록 한다.
/// TODO: Working days 를 1 day in a week 와 같이 해서 1 day, 2 day, ... 7 day 까지 선택 할 수 있도록 한다.
/// TODO: 숙식제공 옵션을 두고 선택 할 수 있도록 한다.
/// TODO: Salary 를 월 110 만 이하, 120 만, 130 만 .... 400 만, 그리고 400 만 이상으로 선택 하도록 한다.
///
class JobEditForm extends StatefulWidget {
  const JobEditForm({
    Key? key,
    required this.onError,
  }) : super(key: key);

  final Function onError;

  @override
  State<JobEditForm> createState() => _JobEditFormState();
}

class _JobEditFormState extends State<JobEditForm> {
  final companyName = TextEditingController();
  final phoneNumber = TextEditingController();
  final mobileNumber = TextEditingController();
  final email = TextEditingController();
  final jobCategory = TextEditingController();
  final workingHours = TextEditingController();
  final detailAddress = TextEditingController();
  final aboutUs = TextEditingController();
  final numberOfHiring = TextEditingController();
  final jobDescription = TextEditingController();
  final requirement = TextEditingController();
  final duty = TextEditingController();
  final salary = TextEditingController();
  final benefit = TextEditingController();

  AddressModel? addr;

  getAddress() async {
    addr = await JobService.instance.inputAddress(context);
    print(addr);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Timer(Duration(milliseconds: 100), getAddress);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Create a job opening'),
        TextField(
          controller: companyName,
          decoration: InputDecoration(
            labelText: "Company name",
          ),
        ),
        TextField(
          controller: mobileNumber,
          decoration: InputDecoration(
            labelText: "Mobile phone number",
          ),
        ),
        TextField(
          controller: phoneNumber,
          decoration: InputDecoration(
            labelText: "Office phone number",
          ),
        ),
        TextField(
          controller: email,
          decoration: InputDecoration(
            labelText: "Email address",
          ),
        ),
        GestureDetector(
          onTap: getAddress,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Address'),
                if (addr == null)
                  Text('* Select your address.')
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${addr?.roadAddr}'),
                      Text('${addr?.korAddr}'),
                    ],
                  ),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      'Select',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                    spaceSm,
                  ],
                )
              ],
            ),
          ),
        ),
        if (addr != null)
          TextField(
            controller: detailAddress,
            decoration: InputDecoration(
              labelText: "Input detail address",
            ),
          ),
        TextField(
          controller: jobCategory,
          decoration: InputDecoration(
            labelText: "Job category(industry) - @todo select box",
          ),
        ),
        Select(
          defaultLabel: "Select job category",
          options: JobService.instance.categories,
          onChanged: (v) {
            print(v);
          },
        ),
        TextField(
          controller: aboutUs,
          decoration: InputDecoration(
            labelText: "About us",
          ),
        ),
        TextField(
          controller: numberOfHiring,
          decoration: InputDecoration(
            labelText: "Number of hiring",
          ),
        ),
        TextField(
          controller: workingHours,
          decoration: InputDecoration(
            labelText: "Working hours",
          ),
        ),
        TextField(
          controller: jobDescription,
          decoration: InputDecoration(
            labelText: "Job description(details of what workers will do)",
          ),
        ),
        TextField(
          controller: requirement,
          decoration: InputDecoration(
            labelText: "Requirements and qualifications",
          ),
        ),
        TextField(
          controller: duty,
          decoration: InputDecoration(
            labelText: "Duties and responsibilities",
          ),
        ),
        TextField(
          controller: salary,
          decoration: InputDecoration(
            labelText: "Salary",
          ),
        ),
        TextField(
          controller: benefit,
          decoration: InputDecoration(
            labelText: "benefits(free meals, dormitory, transporation, etc)",
          ),
        ),
        Divider(),

        /// daesung gimhae
        ElevatedButton(
          onPressed: () async {
            try {
              final extra = {
                'companyName': companyName.text,
                'phoneNumber': phoneNumber.text,
                'mobileNumber': mobileNumber.text,
                'email': email.text,
                'jobCategory': jobCategory.text,
                'workingHours': workingHours.text,
                'detailAddress': detailAddress.text,
                'aboutUs': aboutUs.text,
                'numberOfHiring': numberOfHiring.text,
                'jobDescription': jobDescription.text,
                'requirement': requirement.text,
                'duty': duty.text,
                'salary': salary.text,
                'benefit': benefit.text,
                'roadAddr': addr?.roadAddr ?? '',
                'korAddr': addr?.korAddr ?? '',
                'zipNo': addr?.zipNo ?? '',
                'siNm': addr?.siNm ?? '',
                'sggNm': addr?.sggNm ?? '',
                'emdNm': addr?.emdNm ?? '',
              };
              print(extra);
              // await PostApi.instance.create(category: 'job_openings', extra: extra);
            } catch (e) {
              widget.onError(e);
            }
          },
          child: Text('Submit'),
        )
      ],
    );
  }
}
