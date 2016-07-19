From: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH 1/3] pmem: clarify a debug print in pmem_clear_poison
Date: Tue, 19 Jul 2016 17:15:25 +0000
Message-ID: <1468948496.30121.60.camel@intel.com>
References: <1468889100-30698-1-git-send-email-vishal.l.verma@intel.com>
	 <1468889100-30698-2-git-send-email-vishal.l.verma@intel.com>
	 <CAPcyv4gpRGJLVfoC3o-rVypQtppkAKg1hObr=1EhcT3Y3g8KUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4182 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034AbcGSRPe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jul 2016 13:15:34 -0400
In-Reply-To: <CAPcyv4gpRGJLVfoC3o-rVypQtppkAKg1hObr=1EhcT3Y3g8KUw@mail.gmail.com>
Content-Language: en-US
Content-ID: <5C8E6D11FD483341ADC3BB7B3F7C54B3@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

T24gVHVlLCAyMDE2LTA3LTE5IGF0IDA4OjUzIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIE1vbiwgSnVsIDE4LCAyMDE2IGF0IDU6NDQgUE0sIFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwu
dmVybWFAaW50ZWwuY28NCj4gbT4gd3JvdGU6DQo+ID4gUHJlZml4IHRoZSBzZWN0b3IgbnVtYmVy
IGJlaW5nIGNsZWFyZWQgd2l0aCBhICcweCcgdG8gbWFrZSBpdCBjbGVhcg0KPiA+IHRoYXQNCj4g
PiB0aGlzIGlzIGEgaGV4IHZhbHVlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBW
ZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9u
dmRpbW0vcG1lbS5jIHwgMiArLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL3Bt
ZW0uYyBiL2RyaXZlcnMvbnZkaW1tL3BtZW0uYw0KPiA+IGluZGV4IDYwOGZjNDQuLjI5YWIyNWIg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9udmRpbW0vcG1lbS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9udmRpbW0vcG1lbS5jDQo+ID4gQEAgLTU3LDcgKzU3LDcgQEAgc3RhdGljIHZvaWQgcG1lbV9j
bGVhcl9wb2lzb24oc3RydWN0IHBtZW1fZGV2aWNlDQo+ID4gKnBtZW0sIHBoeXNfYWRkcl90IG9m
ZnNldCwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgY2xlYXJlZCA9IG52ZGltbV9jbGVhcl9wb2lzb24o
ZGV2LCBwbWVtLT5waHlzX2FkZHIgKyBvZmZzZXQsDQo+ID4gbGVuKTsNCj4gPiANCj4gPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKGNsZWFyZWQgPiAwICYmIGNsZWFyZWQgLyA1MTIpIHsNCj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2RiZyhkZXYsICIlczogJWxseCBjbGVhciAl
bGQgc2VjdG9yJXNcbiIsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9k
YmcoZGV2LCAiJXM6IDB4JWxseCBjbGVhciAlbGQgc2VjdG9yJXNcbiIsDQo+IA0KPiAlI2xseCBp
cyBhIGJpdCBzbWFsbGVyIC8gbW9yZSByZWFkYWJsZS7CoMKgU2hhbGwgSSBqdXN0IGZpeCB0aGlz
IHVwIG9uDQo+IGFwcGx5aW5nPw0KDQpUSUwgOikgWWVzIHlvdSBjYW4gZG8gdGhlIGZpeHVwLCB0
aGFua3Mh
