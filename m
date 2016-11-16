From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: Fix in ACPICA tools broke cross compilation of tools/power/acpi
Date: Wed, 16 Nov 2016 08:48:30 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A28F642@SHSMSX101.ccr.corp.intel.com>
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
Received: from mga09.intel.com ([134.134.136.24]:27863 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752307AbcKPIse (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Nov 2016 03:48:34 -0500
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

SGksDQoNCj4gRnJvbTogWmhlbmcsIEx2DQo+IFN1YmplY3Q6IFJFOiBGaXggaW4gQUNQSUNBIHRv
b2xzIGJyb2tlIGNyb3NzIGNvbXBpbGF0aW9uIG9mIHRvb2xzL3Bvd2VyL2FjcGkNCj4gDQo+IEhp
LCBBbmR5DQo+IA0KPiA+IEZyb206IEFuZHkgU2hldmNoZW5rbyBbbWFpbHRvOmFuZHkuc2hldmNo
ZW5rb0BnbWFpbC5jb21dDQo+ID4gU3ViamVjdDogUmU6IEZpeCBpbiBBQ1BJQ0EgdG9vbHMgYnJv
a2UgY3Jvc3MgY29tcGlsYXRpb24gb2YgdG9vbHMvcG93ZXIvYWNwaQ0KPiA+DQo+ID4gT24gVHVl
LCBOb3YgMTUsIDIwMTYgYXQgNTowMSBQTSwgQW5keSBTaGV2Y2hlbmtvDQo+ID4gPGFuZHkuc2hl
dmNoZW5rb0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiBUaGUgYmVsb3cgKyBzZXZlcmFs
IHJ1bnMgKG5lZWQgdG8gc2VyaWFsaXplIG1ha2VmaWxlLCBieSBkZWZhdWx0IGl0DQo+ID4gPiBy
YWNlcyBpbnN0YWxsIHZzLiBidWlsZCkgIGhlbHBlZCBldmVudHVhbGx5Lg0KPiA+DQo+ID4gSXNu
J3QgYmV0dGVyIGp1c3QgdG8gcmV2ZXJ0IHBhdGNoIEkgbWVudGlvbiBhbmQgY29udGludWUgZnJv
bSB3b3JraW5nIGNhc2U/DQo+IA0KPiBJdCdzIG5vdCBwb3NzaWJsZSB0byByZXZlcnQgdGhhdCBw
YXRjaC4NCj4gSXQgY29udGFpbnMgY29ycmVjdCBoZWFkZXIgaW5jbHVzaW9uIGNsZWFudXBzLg0K
PiBXaGlsZSB0aGlzIGNhc2UgaXMgaW4gZmFjdCBhIHNwZWNpYWwgY2FzZSwgYnVncyBpbiB0b29s
cy9NYWtlZmlsZSBhcmUgdHJpZ2dlcmVkIChhYm91dCBPVVQvU1JDKS4NCj4gDQo+IE9UT0gsIHRo
aXMgY2FzZSBpcyBhY3R1YWxseSBub3QgYSB2ZXJ5IHVzZWZ1bCBjYXNlLg0KPiBXZSBjYW4gc2Vl
IG1hbnkgdG9vbHMgYnVpbGQgYnJva2VuIGZvciBjcm9zcy1jb21waWxlcnMsIGFuZCB0b29scy9w
b3dlci9hY3BpIGlzIG5vdCB0aGUgb25seSBvbmUuDQo+IFdlIGFyZSBqdXN0IHRvIGltcHJvdmUg
aXQuDQoNCldlIGNhbiBjbGVhcmx5IHNlZSB0aGF0Og0KMS4gdGhlIGNvbW1pdCBpcyBjb3JyZWN0
LCBpdCBjYW4gY2xlYW5seSBzb3J0IHRoZSBpbmNsdXNpb24gb3JkZXJzLg0KMi4gdG9vbHMvcG93
ZXIvYWNwaSBidWlsZCBpcyBzdGlsbCB3b3JraW5nLCBqdXN0IGhhdmUgaXNzdWVzIHdpdGggY3Jv
c3MgdG9vbGNoYWlucy4NCjMuIHRoZSBzdHJpY3QgaW5jbHVzaW9uIG9yZGVyIChzaWduYWwuaCkg
aXRzZWxmIGlzIGEgYnVnIC0gYmVjYXVzZSB0b29sY2hhaW4gaXNzdWUgYW5kIEFDUElDQSB0cmlj
ay4NCjQuIHRvb2xzL3Bvd2VyL2FjcGkgbWFrZWZpbGVzIGFyZSBub3QgaGFuZGxpbmcgT1VUL1NS
QyBjb3JyZWN0bHkuDQpTbyB3aHkgZG8gd2UgbmVlZCB0byByZXZlcnQgY29ycmVjdCB0aGluZyB0
byBzdXBwb3J0IGEgYnVnZ3kgYmVoYXZpb3I/DQpXZSBhcmUganVzdCBmaW5kaW5nIGEgd2F5IHRv
IG1ha2UgdG9vbHMvcG93ZXIvYWNwaSBidWlsZCBtb3JlIHJvYnVzdCBmb3Igc3VjaCBhIGJ1Z2d5
IGJlaGF2aW9yLg0KDQpUaGFua3MNCkx2DQo=
