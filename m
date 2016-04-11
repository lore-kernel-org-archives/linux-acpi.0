From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 1/3] ACPI / tables: Move table override mechanisms to
 tables.c
Date: Mon, 11 Apr 2016 23:27:01 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB7E94A@SHSMSX101.ccr.corp.intel.com>
References: <cover.1460100857.git.lv.zheng@intel.com>
	<3ef8c14e35fc835260f2f2c62a2227e7b570be24.1460100857.git.lv.zheng@intel.com>
	<1AE640813FDE7649BE1B193DEA596E883BB7E62D@SHSMSX101.ccr.corp.intel.com>
 <CAJZ5v0jV_b7BxPBGRPVPNx47FR+sqYv=ZFCNuZO+MBUK-u2yqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41420 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbcDKX1H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Apr 2016 19:27:07 -0400
In-Reply-To: <CAJZ5v0jV_b7BxPBGRPVPNx47FR+sqYv=ZFCNuZO+MBUK-u2yqA@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

SGksDQoNCj4gRnJvbTogcmp3eXNvY2tpQGdtYWlsLmNvbSBbbWFpbHRvOnJqd3lzb2NraUBnbWFp
bC5jb21dIE9uIEJlaGFsZiBPZg0KPiBSYWZhZWwgSi4gV3lzb2NraQ0KPiBTZW50OiBNb25kYXks
IEFwcmlsIDExLCAyMDE2IDk6MzEgUE0NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIEFDUEkg
LyB0YWJsZXM6IE1vdmUgdGFibGUgb3ZlcnJpZGUgbWVjaGFuaXNtcyB0bw0KPiB0YWJsZXMuYw0K
PiANCj4gT24gTW9uLCBBcHIgMTEsIDIwMTYgYXQgNDoxNiBBTSwgWmhlbmcsIEx2IDxsdi56aGVu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+IEhpLCBSYWZhZWwNCj4gDQo+IEhpLA0KPiANCj4gPj4g
RnJvbTogWmhlbmcsIEx2DQo+ID4+IFN1YmplY3Q6IFtQQVRDSCAxLzNdIEFDUEkgLyB0YWJsZXM6
IE1vdmUgdGFibGUgb3ZlcnJpZGUgbWVjaGFuaXNtcyB0bw0KPiA+PiB0YWJsZXMuYw0KPiA+Pg0K
PiA+PiBUaGlzIHBhdGNoIG1vdmVzIGFjcGlfb3NfdGFibGVfb3ZlcnJpZGUoKSBhbmQNCj4gPj4g
YWNwaV9vc19waHlzaWNhbF90YWJsZV9vdmVycmlkZSgpIHRvIHRhYmxlcy5jLg0KPiA+Pg0KPiAN
Cj4gW2N1dF0NCj4gDQo+ID4+ICAjaWZkZWYgQ09ORklHX0FDUElfSU5JVFJEX1RBQkxFX09WRVJS
SURFDQo+ID4+IC12b2lkIGFjcGlfaW5pdHJkX292ZXJyaWRlKHZvaWQgKmRhdGEsIHNpemVfdCBz
aXplKTsNCj4gPj4gK3ZvaWQgZWFybHlfYWNwaV90YWJsZV9pbml0KHZvaWQgKmRhdGEsIHNpemVf
dCBzaXplKTsNCj4gPj4gICNlbHNlDQo+ID4+IC1zdGF0aWMgaW5saW5lIHZvaWQgYWNwaV9pbml0
cmRfb3ZlcnJpZGUodm9pZCAqZGF0YSwgc2l6ZV90IHNpemUpDQo+ID4+ICtzdGF0aWMgaW5saW5l
IHZvaWQgZWFybHlfYWNwaV90YWJsZV9pbml0KHZvaWQgKmRhdGEsIHNpemVfdCBzaXplKQ0KPiA+
PiAgew0KPiA+PiAgfQ0KPiA+PiAgI2VuZGlmDQo+ID4gW0x2IFpoZW5nXQ0KPiA+IFRoaXMgYmxv
Y2sgd2FzIHdyb25nLg0KPiA+IGVhcmx5X2FjcGlfdGFibGVfaW5pdCgpIGlzIG5vIGxvbmdlciBk
ZXBlbmRlbnQgb24NCj4gQ09ORklHX0FDUElfSU5JVFJEX1RBQkxFX09WRVJSSURFIGJ1dCBkZXBl
bmRlbnQgb24gQ09ORklHX0FDUEkuDQo+IA0KPiBJIHNlZS4NCj4gDQo+ID4gVXBkYXRlZCB2MiBw
YXRjaGVzIGFyZSBzZW50IHRvIHRoZSBtYWlsaW5nIGxpc3QuDQo+IA0KPiBJcyB0aGlzIHRoZSBv
bmx5IGRpZmZlcmVuY2UgYmV0d2VlbiB2MSBhbmQgdjI/DQoNCltMdiBaaGVuZ10gDQpPbmUgb2Yg
dGhlIGZvbGxvdy11cCBwYXRjaGVzIChQQVRDSCAzKSBpbiB0aGlzIHNlcmllcyBpcyB1cGRhdGVk
IGFjY29yZGluZ2x5Lg0KDQpUaGFua3MgYW5kIGJlc3QgcmVnYXJkcw0KLUx2DQo=
