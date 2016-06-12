From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 0/4] ACPI 2.0: Enable TermList interpretion for table
 loading
Date: Sun, 12 Jun 2016 01:02:57 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BBCC54B@SHSMSX101.ccr.corp.intel.com>
References: <cover.1463109824.git.lv.zheng@intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BBA2A9A@SHSMSX101.ccr.corp.intel.com>
 <CAJZ5v0gYBKC0GxBpFH-jOca7ide-pGc9R1bfi9PCSZgiB1hSAg@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E883BBA4649@SHSMSX101.ccr.corp.intel.com>
 <76932cf4-c292-d711-d390-f451b66c3f9c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:19166 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098AbcFLBDA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Jun 2016 21:03:00 -0400
In-Reply-To: <76932cf4-c292-d711-d390-f451b66c3f9c@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

SGksDQoNCj4gRnJvbTogV3lzb2NraSwgUmFmYWVsIEoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MiAwLzRdIEFDUEkgMi4wOiBFbmFibGUgVGVybUxpc3QgaW50ZXJwcmV0aW9uIGZvcg0KPiB0YWJs
ZSBsb2FkaW5nDQo+IA0KPiBPbiA1LzIwLzIwMTYgMjo1NyBBTSwgWmhlbmcsIEx2IHdyb3RlOg0K
PiA+IEhpLCBSYWZhZWwNCj4gPg0KPiA+PiBGcm9tOiByand5c29ja2lAZ21haWwuY29tIFttYWls
dG86cmp3eXNvY2tpQGdtYWlsLmNvbV0gT24gQmVoYWxmDQo+IE9mDQo+ID4+IFJhZmFlbCBKLiBX
eXNvY2tpDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMC80XSBBQ1BJIDIuMDogRW5hYmxl
IFRlcm1MaXN0IGludGVycHJldGlvbiBmb3INCj4gdGFibGUNCj4gPj4gbG9hZGluZw0KPiA+Pg0K
PiA+PiBPbiBUdWUsIE1heSAxNywgMjAxNiBhdCAyOjI5IEFNLCBaaGVuZywgTHYgPGx2LnpoZW5n
QGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4+PiBIaSwgUmFmYWVsDQo+ID4+Pg0KPiA+Pj4gQ2Fu
IHdlIHF1ZXVlIHRoaXMgdXAgaW4gbGludXgtbmV4dD8NCj4gPj4+IEFTTFRTIHJlY3Vyc2l2ZSB0
ZXN0cyBhcmUgZG9uZSBpbiBBQ1BJQ0EgdXBzdHJlYW0gYW5kIG5vIHJlZ3Jlc3Npb25zDQo+IGNh
biBiZQ0KPiA+PiBzZWVuLg0KPiA+Pj4gV2UgbmVlZCBtb3JlIHRlc3RzIGFyb3VuZCB0aGlzIGV4
cGVyaW1lbnRhbCBjaGFuZ2UgZnJvbSB0aGUgcmVhbA0KPiB1c2VycyB0bw0KPiA+PiBoYXZlIHRo
ZSBjaGFuY2VzIHRvIGxlYXJuIHRoZSB1bmtub3duIGNhc2VzLg0KPiA+Pj4gSWYgdGhleSByZXBv
cnRlZCByZWdyZXNzaW9ucywgd2UgY291bGQgc3RvcCB0aGUgcmVncmVzc2lvbnMgYnkNCj4gcmV2
ZXJ0aW5nDQo+ID4+IFtQQVRDSCA0LzRdLg0KPiA+Pj4gU28gaXQgc2hvdWxkIGJlIHNhZmUgdG8g
ZG8gc3VjaCBleHBlcmltZW50cyBpbiB0aGUgTGludXggdXBzdHJlYW0uDQo+ID4+PiBUaGFua3Mg
aW4gYWR2YW5jZS4NCj4gPj4gVGhlcmUgaXMgYSBydWxlIHRoYXQgZHVyaW5nIGEgbWVyZ2Ugd2lu
ZG93IGxpbnV4LW5leHQgc2hvdWxkIG9ubHkNCj4gPj4gY29udGFpbiBtYXRlcmlhbCBmb3IgdGhh
dCBtZXJnZSB3aW5kb3cuICBUaGF0IGlzLCBjdXJyZW50bHkgbGludXgtbmV4dA0KPiA+PiBzaG91
bGQgb25seSBjb250YWluIG1hdGVyaWFsIHRhcmdldGVkIGF0IHY0LjcuDQo+ID4+DQo+ID4+IEZv
ciB0aGlzIHJlYXNvbiwgSSBjYW4ndCBwdXQgdGhlIHNlcmllcyBpbnRvIGxpbnV4LW5leHQgcmln
aHQgbm93LCBidXQNCj4gPj4gSSdsbCBkbyB0aGF0IGFzIHNvb24gYXMgNC43LXJjMSBpcyByZWxl
YXNlZC4NCj4gPiBbTHYgWmhlbmddDQo+ID4gR3JlYXQhDQo+ID4gVGhhbmtzIGZvciB0aGUgaW5m
b3JtYXRpb24uDQo+IA0KPiBVbmZvcnR1bmF0ZWx5LCBpdCBpcyByZXBvcnRlZCB0aGF0IHRoZSBz
ZXJpZXMgYWN0dWFsbHkgY2F1c2VzIHByb2JsZW1zDQo+IHRvIGhhcHBlbi4NCj4gDQo+IEkgc2Vu
dCB5b3UgYSBDQyBvZiBteSByZXNwb25zZSB0byB0aGUgcmVwb3J0IGluIHF1ZXN0aW9uIGVhcmxp
ZXIgdG9kYXkuDQpbTHYgWmhlbmddIA0KQ291bGQgdGhlIHByb2JsZW0gYmUgc3RvcHBlZCBieSBy
ZXZlcnRpbmcgUEFUQ0ggNC80Pw0KTGV0IG1lIGNoZWNrIHdpdGggdGhlIHJlcG9ydGVyIHRvIGxl
YXJuIHRoZSBjYXNlLg0KDQpUaGFua3MgYW5kIGJlc3QgcmVnYXJkcw0KLUx2DQo=
