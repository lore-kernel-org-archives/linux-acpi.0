From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] tools/power/acpi/tools/acpidbg: Add multi-commands
 support in batch mode
Date: Fri, 22 Jul 2016 00:26:09 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC05ABD@SHSMSX101.ccr.corp.intel.com>
References: <cover.1468464391.git.lv.zheng@intel.com>
 <804f8558b9e65d6022cdb982e1772194ba52d292.1469002094.git.lv.zheng@intel.com>
 <1843492.Yub8jGoblF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63643 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbcGVA0W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jul 2016 20:26:22 -0400
In-Reply-To: <1843492.Yub8jGoblF@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

SGksIFJhZmFlbA0KDQo+IEZyb206IFJhZmFlbCBKLiBXeXNvY2tpIFttYWlsdG86cmp3QHJqd3lz
b2NraS5uZXRdDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRvb2xzL3Bvd2VyL2FjcGkvdG9vbHMv
YWNwaWRiZzogQWRkIG11bHRpLQ0KPiBjb21tYW5kcyBzdXBwb3J0IGluIGJhdGNoIG1vZGUNCj4g
DQo+IE9uIFdlZG5lc2RheSwgSnVseSAyMCwgMjAxNiAwNDoxMjowOCBQTSBMdiBaaGVuZyB3cm90
ZToNCj4gPiBUaGlzIHBhdGNoIGFkZHMgbXVsdGktY29tbWFuZHMgc3VwcG9ydCBmb3IgdGhlIGJh
dGNoIG1vZGUuIFRoZSBzYW1lDQo+IG1vZGUNCj4gPiBjYW4gYmUgc2VlbiBpbiBhY3BpZXhlYy4N
Cj4gPg0KPiA+IEhvd2V2ZXIgcGVvcGxlIG1heSB0aGluayB0aGlzIGlzIG5vdCB1c2VmdWwgZm9y
IGFuIGluLWtlcm5lbCBkZWJ1Z2dlciwNCj4gPiBiZWNhdXNlIHRoZSBpbi1rZXJuZWwgZGVidWdn
ZXIgaXMgYWx3YXlzIHJ1bm5pbmcsIG5ldmVyIGV4aXRzLiBTbyB3ZSBjYW4NCj4gPiBydW4gYW5v
dGhlciBjb21tYW5kIGJ5IHJ1bm5pbmcgYW5vdGhlciBhY3BpZGJnIGJhdGNoIG1vZGUgaW5zdGFu
Y2UuDQo+ID4NCj4gPiBCdXQgdGhpcyBtb2RlIHNob3VsZCBzdGlsbCBiZSB1c2VmdWwgZm9yIGFj
cGlkYmcuIFRoZSByZWFzb24gaXM6IHdoZW4gdGhlDQo+ID4gaW4ta2VybmVsIGRlYnVnZ2VyIGhh
cyBlbnRlcmVkIHRoZSBzaW5nbGUtc3RlcHBpbmcgbW9kZSwgZW5kaW5nIGFjcGlkYmcNCj4gPiAo
d2hpY2ggY2xvc2VzIHRoZSBkZWJ1Z2dlciBJTyBpbnRlcmZhY2UpIHdpbGwgbGVhZCB0byB0aGUg
ZW5kIG9mIHRoZQ0KPiA+IHNpbmdsZS1zdGVwcGluZyBtb2RlLg0KPiA+DQo+ID4gU28gd2UgbmVl
ZCB0aGUgYWNwaWRiZyBtdWx0aS1jb21tYW5kcyBiYXRjaCBtb2RlIGluIG9yZGVyIHRvIGV4ZWN1
dGUNCj4gPiBtdWx0aXBsZSBzaW5nbGUtc3RlcHBpbmcgbW9kZSBjb21tYW5kcyBpbiB0aGUgYmF0
Y2ggbW9kZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEx2IFpoZW5nIDxsdi56aGVuZ0BpbnRl
bC5jb20+DQo+IA0KPiBEb2VzIHRoaXMgZGVwZW5kIG9uIHRoZSBrZXJuZWwgZmx1c2hpbmcgc3Vw
cG9ydCBzZXJpZXM/DQpbTHYgWmhlbmddIA0KVGhpcyBkZXBlbmRzIG9uIHRoZSAiZmx1c2giIHN0
dWZmLg0KVGhhdCdzIHdoeSBJIHNlbnQgaXQgdG8gdGhlIHNhbWUgbWFpbGluZyB0aHJlYWQuDQoN
ClRoYW5rcw0KLUx2DQo=
