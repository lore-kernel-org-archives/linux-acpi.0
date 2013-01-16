From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 4/5] ACPICA: GPE support: remove unnecessary newline
 from error messages
Date: Wed, 16 Jan 2013 17:17:58 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E357E51E19@ORSMSX101.amr.corp.intel.com>
References: <1354189996-14431-1-git-send-email-colin.king@canonical.com>
 <1354189996-14431-5-git-send-email-colin.king@canonical.com>
 <2225709.xIUb3ZBS1U@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10038 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755726Ab3APRSB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2013 12:18:01 -0500
In-Reply-To: <2225709.xIUb3ZBS1U@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Colin King <colin.king@canonical.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

RG9uZSwgdGhhbmtzLg0KQm9iDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBSYWZhZWwgSi4gV3lzb2NraSBbbWFpbHRvOnJqd0BzaXNrLnBsXQ0KPiBTZW50OiBUdWVz
ZGF5LCBKYW51YXJ5IDE1LCAyMDEzIDI6MjkgUE0NCj4gVG86IE1vb3JlLCBSb2JlcnQNCj4gQ2M6
IENvbGluIEtpbmc7IExlbiBCcm93bjsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCA0LzVdIEFDUElDQTogR1BFIHN1cHBvcnQ6IHJlbW92ZSB1bm5lY2Vz
c2FyeSBuZXdsaW5lDQo+IGZyb20gZXJyb3IgbWVzc2FnZXMNCj4gDQo+IEhpIEJvYiwNCj4gDQo+
IFRoaXMgYXBwZWFycyB0byBiZSB1cHN0cmVhbSBBQ1BJQ0EgbWF0ZXJpYWwuDQo+IA0KPiBUaGFu
a3MsDQo+IFJhZmFlbA0KPiANCj4gDQo+IE9uIFRodXJzZGF5LCBOb3ZlbWJlciAyOSwgMjAxMiAx
MTo1MzoxNSBBTSBDb2xpbiBLaW5nIHdyb3RlOg0KPiA+IEZyb206IENvbGluIElhbiBLaW5nIDxj
b2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+ID4NCj4gPiBBQ1BJX0VSUk9SKCkgYWxyZWFkeSBh
cHBlbmRzIGEgbmV3bGluZSwgc28gdGhlcmUgaXMgbm8gbmVlZCBmb3IgdGhlDQo+ID4gZXJyb3Ig
bWVzc2FnZXMgdG8gaW5jbHVkZSBvbmUgdG9vLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ29s
aW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9hY3BpL2FjcGljYS9od2dwZS5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2FjcGkvYWNwaWNhL2h3Z3BlLmMgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2h3Z3BlLmMNCj4gPiBp
bmRleCBkYjQwNzY1Li42MTBlZDcyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9hY3Bp
Y2EvaHdncGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvaHdncGUuYw0KPiA+IEBA
IC0xMzQsNyArMTM0LDcgQEAgYWNwaV9od19sb3dfc2V0X2dwZShzdHJ1Y3QgYWNwaV9ncGVfZXZl
bnRfaW5mbw0KPiAqZ3BlX2V2ZW50X2luZm8sIHUzMiBhY3Rpb24pDQo+ID4gIAkJYnJlYWs7DQo+
ID4NCj4gPiAgCWRlZmF1bHQ6DQo+ID4gLQkJQUNQSV9FUlJPUigoQUVfSU5GTywgIkludmFsaWQg
R1BFIEFjdGlvbiwgJXVcbiIsIGFjdGlvbikpOw0KPiA+ICsJCUFDUElfRVJST1IoKEFFX0lORk8s
ICJJbnZhbGlkIEdQRSBBY3Rpb24sICV1IiwgYWN0aW9uKSk7DQo+ID4gIAkJcmV0dXJuIChBRV9C
QURfUEFSQU1FVEVSKTsNCj4gPiAgCX0NCj4gPg0KPiA+DQo+IC0tDQo+IEkgc3BlYWsgb25seSBm
b3IgbXlzZWxmLg0KPiBSYWZhZWwgSi4gV3lzb2NraSwgSW50ZWwgT3BlbiBTb3VyY2UgVGVjaG5v
bG9neSBDZW50ZXIuDQo=
