From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: RE: [PATCH v2 2/2] acpi/nfit: Issue Start ARS to retrieve existing
 records
Date: Sat, 17 Jun 2017 00:01:44 +0000
Message-ID: <DF4PR84MB01051FBBC0ADDFF41A9534F282C60@DF4PR84MB0105.NAMPRD84.PROD.OUTLOOK.COM>
References: <20170608183658.24731-1-toshi.kani@hpe.com>
 <20170608183658.24731-3-toshi.kani@hpe.com>
 <CAPcyv4j8vjw9arcNyHrszDNbX5xWzBOtTB5cS81rY9H_tJzhug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:33903 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbdFQADe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jun 2017 20:03:34 -0400
In-Reply-To: <CAPcyv4j8vjw9arcNyHrszDNbX5xWzBOtTB5cS81rY9H_tJzhug@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vishal L Verma <vishal.l.verma@intel.com>, "Knippers, Linda" <linda.knippers@hpe.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

PiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYWNw
aS9uZml0L2NvcmUuYw0KPiA+IEBAIC0xMDMxLDcgKzEwMzEsNyBAQCBzdGF0aWMgc3NpemVfdCBz
Y3J1Yl9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gICAgICAgICBpZiAobmRfZGVzYykg
ew0KPiA+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgYWNwaV9uZml0X2Rlc2MgKmFjcGlfZGVzYyA9
IHRvX2FjcGlfZGVzYyhuZF9kZXNjKTsNCj4gPg0KPiA+IC0gICAgICAgICAgICAgICByYyA9IGFj
cGlfbmZpdF9hcnNfcmVzY2FuKGFjcGlfZGVzYyk7DQo+ID4gKyAgICAgICAgICAgICAgIHJjID0g
YWNwaV9uZml0X2Fyc19yZXNjYW4oYWNwaV9kZXNjLCAwKTsNCj4gPiAgICAgICAgIH0NCj4gPiAg
ICAgICAgIGRldmljZV91bmxvY2soZGV2KTsNCj4gPiAgICAgICAgIGlmIChyYykNCj4gPiBAQCAt
MjA1Nyw2ICsyMDU3LDEwIEBAIHN0YXRpYyBpbnQgYXJzX3N0YXJ0KHN0cnVjdCBhY3BpX25maXRf
ZGVzYw0KPiAqYWNwaV9kZXNjLCBzdHJ1Y3QgbmZpdF9zcGEgKm5maXRfc3BhDQo+ID4gICAgICAg
ICAgICAgICAgIGFyc19zdGFydC50eXBlID0gTkRfQVJTX1ZPTEFUSUxFOw0KPiA+ICAgICAgICAg
ZWxzZQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT1RUWTsNCj4gPiArICAgICAgIGlm
IChuZml0X3NwYS0+YXJzX3ByZXZfZGF0YSkgew0KPiA+ICsgICAgICAgICAgICAgICBhcnNfc3Rh
cnQuZmxhZ3MgfD0gTkRfQVJTX1JFVFVSTl9QUkVWX0RBVEE7DQo+ID4gKyAgICAgICAgICAgICAg
IG5maXRfc3BhLT5hcnNfcHJldl9kYXRhID0gMDsNCj4gPiArICAgICAgIH0NCj4gDQo+IEknZCBy
YXRoZXIgeW91IHBsdW1iIGEgbmV3ICdmbGFncycgcGFyYW1ldGVyIGFsbCB0aGUgd2F5IHRocm91
Z2ggZnJvbQ0KPiBhY3BpX25maXRfYXJzX3Jlc2NhbigpIHRvIGFyc19zdGFydCgpIHJhdGhlciB0
aGFuIGNhcnJ5aW5nIHRoaXMgYXMgYQ0KPiBwcm9wZXJ0eSBvZiBuZml0X3NwYS4NCg0KWWVzLCBJ
IHdhbnRlZCB0byBjYXJyeSAnZmxhZ3MnIGFsbCB0aGUgd2F5LCBidXQgc2luY2UgYWNwaV9uZml0
X2Fyc19yZXNjYW4oKQ0KY2FsbHMgYWNwaV9uZml0X3NjcnViKCkgdmlhIGFjcGlfZGVzYy0+d29y
aywgYWxsIGluZm8gbmVlZHMgdG8gYmUgbWFyc2hhbGxlZA0KaW50byBzdHJ1Y3QgYWNwaV9uZml0
X2Rlc2MuICBVc2luZyBuZml0X3NwYSBhbGxvd3MgYSByZXF1ZXN0IHRvIGJlIGNhcnJpZWQgYXMN
CnBlci1zcGEgYmFzaXMuLi4NCg0KVGhhbmtzLA0KLVRvc2hpDQoNCg0K
