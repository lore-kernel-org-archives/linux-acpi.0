From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH v2 5/7] ACPI / x86: introduce acpi_os_readable() support
Date: Tue, 10 Nov 2015 13:56:49 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE640286728CF@shsmsx102.ccr.corp.intel.com>
References: <cover.1446790780.git.lv.zheng@intel.com>
	<cover.1447143067.git.lv.zheng@intel.com>
	<c54877289d7742727b2395147167590ed2f24d8a.1447143067.git.lv.zheng@intel.com>
	<36DF59CE26D8EE47B0655C516E9CE6402867258C@shsmsx102.ccr.corp.intel.com>
 <CAHp75VdeXWqcvrfYszjLj63zmZffRLh8ytGzSO+6d31TgbBaNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:65497 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbbKJN4y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Nov 2015 08:56:54 -0500
In-Reply-To: <CAHp75VdeXWqcvrfYszjLj63zmZffRLh8ytGzSO+6d31TgbBaNw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>

SGksIFNoZXZjaGVua28sDQpUaGFua3MgZm9yIHlvdSByZXZpZXcNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gW21haWx0bzphbmR5LnNoZXZj
aGVua29AZ21haWwuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxMCwgMjAxNSA5OjA0
IFBNDQo+IFRvOiBDaGVuLCBZdSBDDQo+IENjOiBaaGVuZywgTHY7IEx2IFpoZW5nOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IFd5
c29ja2ksIFJhZmFlbCBKOyBCcm93biwgTGVuDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNS83
XSBBQ1BJIC8geDg2OiBpbnRyb2R1Y2UgYWNwaV9vc19yZWFkYWJsZSgpIHN1cHBvcnQNCj4gDQo+
IE9uIFR1ZSwgTm92IDEwLCAyMDE1IGF0IDExOjQyIEFNLCBDaGVuLCBZdSBDIDx5dS5jLmNoZW5A
aW50ZWwuY29tPiB3cm90ZToNCj4gPiBIaSwgTHYNCj4gPiBTb3JyeSBmb3IgbXkgbGF0ZSBmZWVk
YmFjayBvbiB0aGUgcGF0Y2gsIG9uZSBtaW5vciBuaXQgYmVsb3c6DQo+IA0KPiA+PiArICAgICBz
dGFydF9wZm4gPSBwYWdlX3RvX3Bmbih2aXJ0X3RvX3BhZ2UocG9pbnRlcikpOw0KPiA+PiArICAg
ICBlbmRfcGZuID0gcGFnZV90b19wZm4odmlydF90b19wYWdlKHBvaW50ZXIgKyBsZW5ndGgpKTsN
Cj4gPiBDb252ZXJ0IHBvaW50ZXIgdG8gY2hhciogZmlyc3Q/DQo+ID4gZW5kX3BmbiA9IHBhZ2Vf
dG9fcGZuKHZpcnRfdG9fcGFnZSgoY2hhciopcG9pbnRlciArIGxlbmd0aCkpOw0KPiANCj4gV2h5
IGRvIHlvdSBuZWVkIHRoYXQ/DQo+IHZvaWQgKiArIHNpemVfdCA9IGNoYXIgKiArIHNpemVfdA0K
PiANCkh1bSwgSSB3YXMgdW5kZXIgaW1wcmVzc2lvbiBpdCB3YXMgYSBwb2ludGVyLCBzbyBJIGNv
bnZlcnRlZCBpdCB0byBjaGFyKiBmb3Igc2FmZXR5LA0KYnV0IGl0IHNlZW1zIGEgd3JvbmcgaW1w
cmVzc2lvbixhbmQgSSd2ZSBqdXN0IHRlc3RlZCBpdCBvbiBnY2MsIGl0IGlzIE9LIHdpdGhvdXQN
CmNoYXIqLg0KDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28N
Cg==
