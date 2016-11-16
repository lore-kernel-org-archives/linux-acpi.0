From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: Fix in ACPICA tools broke cross compilation of tools/power/acpi
Date: Wed, 16 Nov 2016 08:43:01 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A28F62C@SHSMSX101.ccr.corp.intel.com>
References: <CAHp75VcyRzKPGQXB736EdvyXm9m3ShnLS3Xyrjnh7iRTE5M-uw@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A25E72C@SHSMSX101.ccr.corp.intel.com>
 <CAHp75Vfp3v-SUk=ot35g9VReexCgYFjr1i=fVwyq1_Xg37ub8g@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A25EA6F@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886A25EBA3@SHSMSX101.ccr.corp.intel.com>
 <CAHp75Veg7XehhF_GcwQC4XxrjJGj6gxqd-sw044vOhE+2aGGBA@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A2618E2@SHSMSX101.ccr.corp.intel.com>
 <CAHp75VccqXjwXg0s-n7r5-MzhzxmYS9AKpphckn=ytZNSkdyRw@mail.gmail.com>
 <CAHp75VcA15mVwUYF75dWdSp=BZmf_KCsE+t5qBfsiXHPMdUJiw@mail.gmail.com>
 <CAHp75VdJ1Nb_qbRX9b=RfDX-8e2tOUvMcbgYx8aMr4COQN3p8Q@mail.gmail.com>
 <CAHp75Vc3aSW09AXzWs5yY=iGSFPcz9zeB1F+dA=cNZTbPUG1Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27267 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933016AbcKPInF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Nov 2016 03:43:05 -0500
In-Reply-To: <CAHp75Vc3aSW09AXzWs5yY=iGSFPcz9zeB1F+dA=cNZTbPUG1Lg@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

SGksIEFuZHkNCg0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gW21haWx0bzphbmR5LnNoZXZjaGVu
a29AZ21haWwuY29tXQ0KPiBTdWJqZWN0OiBSZTogRml4IGluIEFDUElDQSB0b29scyBicm9rZSBj
cm9zcyBjb21waWxhdGlvbiBvZiB0b29scy9wb3dlci9hY3BpDQo+IA0KPiBPbiBUdWUsIE5vdiAx
NSwgMjAxNiBhdCA1OjAxIFBNLCBBbmR5IFNoZXZjaGVua28NCj4gPGFuZHkuc2hldmNoZW5rb0Bn
bWFpbC5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGUgYmVsb3cgKyBzZXZlcmFsIHJ1bnMgKG5lZWQg
dG8gc2VyaWFsaXplIG1ha2VmaWxlLCBieSBkZWZhdWx0IGl0DQo+ID4gcmFjZXMgaW5zdGFsbCB2
cy4gYnVpbGQpICBoZWxwZWQgZXZlbnR1YWxseS4NCj4gDQo+IElzbid0IGJldHRlciBqdXN0IHRv
IHJldmVydCBwYXRjaCBJIG1lbnRpb24gYW5kIGNvbnRpbnVlIGZyb20gd29ya2luZyBjYXNlPw0K
DQpJdCdzIG5vdCBwb3NzaWJsZSB0byByZXZlcnQgdGhhdCBwYXRjaC4NCkl0IGNvbnRhaW5zIGNv
cnJlY3QgaGVhZGVyIGluY2x1c2lvbiBjbGVhbnVwcy4NCldoaWxlIHRoaXMgY2FzZSBpcyBpbiBm
YWN0IGEgc3BlY2lhbCBjYXNlLCBidWdzIGluIHRvb2xzL01ha2VmaWxlIGFyZSB0cmlnZ2VyZWQg
KGFib3V0IE9VVC9TUkMpLg0KDQpPVE9ILCB0aGlzIGNhc2UgaXMgYWN0dWFsbHkgbm90IGEgdmVy
eSB1c2VmdWwgY2FzZS4NCldlIGNhbiBzZWUgbWFueSB0b29scyBidWlsZCBicm9rZW4gZm9yIGNy
b3NzLWNvbXBpbGVycywgYW5kIHRvb2xzL3Bvd2VyL2FjcGkgaXMgbm90IHRoZSBvbmx5IG9uZS4N
CldlIGFyZSBqdXN0IHRvIGltcHJvdmUgaXQuDQoNClRoYW5rcw0KTHYNCg==
