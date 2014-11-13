From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 5/6] ACPI/EC: Cleanup QR_SC command processing by adding
 a kernel thread to poll EC events.
Date: Thu, 13 Nov 2014 02:52:03 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026A0737@SHSMSX101.ccr.corp.intel.com>
References: <cover.1414988981.git.lv.zheng@intel.com>
 <2277351.09XTT17U9b@vostro.rjw.lan>
 <1AE640813FDE7649BE1B193DEA596E88026A0706@SHSMSX101.ccr.corp.intel.com>
 <1961414.bGx3EdA0yT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61931 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753603AbaKMCxX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2014 21:53:23 -0500
In-Reply-To: <1961414.bGx3EdA0yT@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Andi Kleen (ak@linux.intel.com)" <ak@linux.intel.com>

SGksIFJhZmFlbA0KDQo+IEZyb206IFJhZmFlbCBKLiBXeXNvY2tpIFttYWlsdG86cmp3QHJqd3lz
b2NraS5uZXRdDQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxMywgMjAxNCAxMDo1OSBBTQ0K
PiANCj4gT24gVGh1cnNkYXksIE5vdmVtYmVyIDEzLCAyMDE0IDAyOjMxOjA4IEFNIFpoZW5nLCBM
diB3cm90ZToNCj4gPiBIaSwgUmFmYWVsDQo+ID4NCj4gPiA+IEZyb206IFJhZmFlbCBKLiBXeXNv
Y2tpIFttYWlsdG86cmp3QHJqd3lzb2NraS5uZXRdDQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIE5v
dmVtYmVyIDEyLCAyMDE0IDk6MTcgQU0NCj4gDQo+IFtjdXRdDQo+IA0KPiA+ID4gPiArDQo+ID4g
PiA+ICtzdGF0aWMgaW50IGVjX2NyZWF0ZV9ldmVudF9wb2xsZXIoc3RydWN0IGFjcGlfZWMgKmVj
KQ0KPiA+ID4gPiArew0KPiA+ID4gPiArCXN0cnVjdCB0YXNrX3N0cnVjdCAqdDsNCj4gPiA+ID4g
Kw0KPiA+ID4gPiArCXQgPSBrdGhyZWFkX3J1bihhY3BpX2VjX2V2ZW50X3BvbGxlciwgZWMsICJl
Yy9ncGUtJWx1IiwgZWMtPmdwZSk7DQo+ID4gPg0KPiA+ID4gRG9lcyBpdCBoYXZlIHRvIGJlIGEg
a2VybmVsIHRocmVhZD8NCj4gPiA+DQo+ID4gPiBXaGF0IGFib3V0IHVzaW5nIGEgd29ya3F1ZXVl
IGluc3RlYWQ/DQo+ID4NCj4gPiBBY3R1YWxseSBJIGp1c3Qgd2FudCB0byB1c2UgdGhyZWFkZWQg
SVJRIGhlcmUgaW4gcmVzcG9uc2UgdG8gQW5kaSBLbGVlbidzIGNvbW1lbnQuDQo+ID4gSWYgYWNw
aV9pcnEgaXMgcmVnaXN0ZXJlZCBhcyB0aHJlYWRlZCBJUlEsIHRoZW4gYWNwaV9lY19ldmVudF9w
b2xsZXIoKSB3aWxsIGJlIHRoZQ0KPiA+IGNhbGxiYWNrIGZyb20gaXQuDQo+IA0KPiBIb3cgc28/
DQo+IA0KPiA+IFNpbmNlIEFDUElDQSBpcyBub3QgcmVhZHkgZm9yIHRocmVhZGVkIElSUSBjdXJy
ZW50bHksIHdlIGNhbm5vdCBwcm9jZWVkIGF0IHRoaXMgcG9pbnQuDQo+ID4gU28gSSBjb3BpZWQg
dGhlIHRocmVhZGVkIElSUSBjb2RlIGZyb20ga2VybmVsL2lycS9tYW5hZ2UuYyBoZXJlIHRvIHBy
ZXBhcmUgdGhyZWFkZWQgSVJRIGxvZ2ljcy4NCj4gDQo+IE9oIGRlYXIsIG5vLg0KPiANCj4gVGhp
cyBpc24ndCB0aGUgd2F5IGZvcndhcmQgaGVyZS4NCj4gDQo+ID4gVXNpbmcgYSBzZXBhcmF0ZSB3
b3JrIHF1ZXVlLCB3ZSBkaWRuJ3QgZGVjcmVhc2UgdGhlIGtlcm5lbCB0aHJlYWQgY291bnQuDQo+
IA0KPiBXaHkgZG9lcyB0aGF0IG1hdHRlciBhdCBhbGw/DQo+IA0KPiA+IEFuZCB0aGUgY29kZSB3
cml0dGVuIGZvciB0aGUgd29yayBpdGVtIGNhbm5vdCBiZSBkZXJpdmVkIHdoZW4gdGhpbmdzIGFy
ZQ0KPiA+IHN3aXRjaGVkIHRvIHRoZSB0aHJlYWRlZCBJUlEuDQo+ID4gU28gSSB1c2VkIGt0aHJl
YWQgaGVyZS4NCj4gDQo+IFBsZWFzZSB1c2UgYSB3b3JrcXVldWUgaW5zdGVhZC4gIElmL3doZW4g
d2UgbmVlZCB0byBzd2l0Y2ggb3ZlciB0byB0aHJlYWRlZA0KPiBJUlFzLCB3ZSdsbCBkbyB0aGUg
d29yayB0aGVuLiAgRm9yIG5vdywgbGV0J3Mgbm90IGNvbXBsaWNhdGUgdGhpbmdzIG1vcmUNCj4g
dGhhbiBuZWNlc3NhcnkuDQoNCkl0IHNlZW1zIHdlIG5lZWQgdGhlIHRocmVhZCBiZWNhdXNlIHdl
IHdpbGwgbW92ZSBwb2xsaW5nIGNvZGUgZnJvbSBlY19wb2xsKCkgdG8gYWNwaV9lY19ldmVudF9w
b2xsZXIoKS4NClRoaXMgd2lsbCBoYXBwZW4gcmlnaHQgYWZ0ZXIgdGhlc2UgY2xlYW51cHMuDQpU
aGF0J3MgdGhlIHRocmVhZGVkIElSUSBsb2dpYyAtIElSUSBpcyBwb2xsZWQgaW4gdGhlIHRocmVh
ZC4NCldlIGNhbm5vdCBhY2hpZXZlIHRoaXMgdXNpbmcgd29yayBxdWV1ZS4NCg0KQmVzdCByZWdh
cmRzDQotTHYNCg==
