From: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH] acpi, nfit: fix the memory error check in
 nfit_handle_mce
Date: Thu, 20 Apr 2017 22:21:31 +0000
Message-ID: <1492726809.2738.23.camel@intel.com>
References: <20170420221818.23522-1-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:40706 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947139AbdDTWVd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Apr 2017 18:21:33 -0400
In-Reply-To: <20170420221818.23522-1-vishal.l.verma@intel.com>
Content-Language: en-US
Content-ID: <153E0E51B48FC444BCD991C344BA9425@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

T24gVGh1LCAyMDE3LTA0LTIwIGF0IDE2OjE4IC0wNjAwLCBWaXNoYWwgVmVybWEgd3JvdGU6DQo+
IFRoZSBjaGVjayBmb3IgYW4gTUNFIGJlaW5nIGEgbWVtb3J5IGVycm9yIGluIHRoZSBORklUIG1j
ZSBoYW5kbGVyIHdhcw0KPiBib2d1cy4gRml4IGl0IHRvIGNoZWNrIGZvciB0aGUgY29ycmVjdCBN
Q0Egc3RhdHVzIGNvbXBvdW5kIGVycm9yIGNvZGUuDQo+IA0KPiBSZXBvcnRlZC1ieTogVG9ueSBM
dWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+
DQoNCkZvcmdvdCB0byBpbmNsdWRlLA0KRml4ZXM6IDY4MzlhNmQ5NmY0ZSBuZml0OiBkbyBhbiBB
UlMgc2NydWIgb24gaGl0dGluZyBhIGxhdGVudCBtZWRpYSBlcnJvcg0KDQo+IFNpZ25lZC1vZmYt
Ynk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KPiAtLS0NCj4gwqBk
cml2ZXJzL2FjcGkvbmZpdC9tY2UuYyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkv
bmZpdC9tY2UuYyBiL2RyaXZlcnMvYWNwaS9uZml0L21jZS5jDQo+IGluZGV4IDNiYTFjMzQuLjIz
ZTEyYTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYWNwaS9uZml0L21jZS5jDQo+ICsrKyBiL2Ry
aXZlcnMvYWNwaS9uZml0L21jZS5jDQo+IEBAIC0yNiw3ICsyNiw3IEBAIHN0YXRpYyBpbnQgbmZp
dF9oYW5kbGVfbWNlKHN0cnVjdCBub3RpZmllcl9ibG9jaw0KPiAqbmIsIHVuc2lnbmVkIGxvbmcg
dmFsLA0KPiDCoAlzdHJ1Y3QgbmZpdF9zcGEgKm5maXRfc3BhOw0KPiDCoA0KPiDCoAkvKiBXZSBv
bmx5IGNhcmUgYWJvdXQgbWVtb3J5IGVycm9ycyAqLw0KPiAtCWlmICghKG1jZS0+c3RhdHVzICYg
TUNBQ09EKSkNCj4gKwlpZiAoIShtY2UtPnN0YXR1cyAmIDB4ZWY4MCkgPT0gQklUKDcpKQ0KPiDC
oAkJcmV0dXJuIE5PVElGWV9ET05FOw0KPiDCoA0KPiDCoAkvKg==
