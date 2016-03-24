From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 01/30] ACPICA: Linuxize: reduce divergences for 20160212
 release
Date: Thu, 24 Mar 2016 06:35:44 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C94846A17FF0@fmsmsx115.amr.corp.intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
	 <cc3b66b74c73a66f82cb715092b6f35105a0cbf8.1458714003.git.lv.zheng@intel.com>
 <1458783966.1762.6.camel@perches.com>
 <1AE640813FDE7649BE1B193DEA596E883BB63FB7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1252 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbcCXGfp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Mar 2016 02:35:45 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB63FB7@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, Joe Perches <joe@perches.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

PiA+ID4NCj4gPiA+IC1hY3BpX3N0YXR1cyBhY3BpX2h3X3JlYWQodTMyICp2YWx1ZSwgc3RydWN0
IGFjcGlfZ2VuZXJpY19hZGRyZXNzDQo+ICpyZWcpDQo+ID4gPiArYWNwaV9zdGF0dXMgYWNwaV9o
d19yZWFkKHUzMiAqdmFsdWUsIHN0cnVjdCBhY3BpX2dlbmVyaWNfYWRkcmVzcyAqDQo+IHJlZykN
Cj4gPg0KPiA+IFRoZSBzZWNvbmQgYXJndW1lbnQgKiBzdHlsZSBhcHBlYXJzIHRoZSBvcHBvc2l0
ZSBvZiBub3JtYWwgc3R5bGUNCj4gPiBhbmQgYSBkaWZmZXJlbnQgc3R5bGUgdGhhbiB0aGUgZmly
c3QgYXJndW1lbnQgKiBzdHlsZS4NCj4gW0x2IFpoZW5nXQ0KPiBUaGUgZmlsZSBpcyBkcml2ZXJz
L2FjcGkvYWNwaWNhL2h3cmVncy5jLCB3aGljaCBpcyBjb21pbmcgZnJvbSBBQ1BJQ0ENCj4gdXBz
dHJlYW0uDQo+IFNvIHRoaXMgaXMgYSByZXN1bHQgb2YgIkFDUElDQSByZWxlYXNlIi4NCj4gSW4g
b3RoZXIgd29yZHMsIHRoaXMgaXMgYSByZXN1bHQgb2YgYSAicHJvY2VzcyIuDQo+IEluIG9yZGVy
IHRvIGZpeCB0aGlzLCB0aGluZ3MgbmVlZCB0byBiZSBkb25lIGluICJBQ1BJQ0EgcmVsZWFzZSBz
Y3JpcHRzIi4NCj4gV2hpY2ggc2hvdWxkIGJlIGRvbmUgaW4NCj4gaHR0cHM6Ly9naXRodWIuY29t
L2FjcGljYS9hY3BpY2EvYmxvYi9tYXN0ZXIvZ2VuZXJhdGUvbGludXgvbGliYWNwaWNhLnNoLg0K
PiBPdGhlcndpc2UsICJBQ1BJQ0EgcmVsZWFzZSIgcHJvY2VzcyB3aWxsIHJlcXVpcmUgaHVtYW4g
aW50ZXJ2ZW50aW9uLg0KPiANCj4gU28gcGxlYXNlIGxlYXZlIHRoaXMgcGF0Y2ggZnJhZ21lbnQg
YXMgaXMuDQo+IEl0IHdpbGwgYmUgYXV0b21hdGljYWxseSBmaXhlZCBpZiB0aGUgIkFDUElDQSBy
ZWxlYXNlIiBwcm9jZXNzIGlzIGZpeGVkLg0KPiBBbmQgaWYgeW91IGRvbid0IGxlYXZlIHRoaXMg
ZnJhZ21lbnQgYXMgaXMsIHRoZSAiQUNQSUNBIHJlbGVhc2UiIHByb2Nlc3MNCj4gd2lsbCBnZXQg
aHVydC4NCg0KSSBkaXNhZ3JlZS4NCg0KVGhlIHBhdGNoIHNob3VsZCBiZSBjb3JyZWN0IHdoZW4g
aXQgaGl0cyB0aGUgTGludXgga2VybmVsIHRyZWUuDQoNCklmIHRoZSBwcm9jZXNzIGlzIGJyb2tl
biwgdGhlbiBmaXggdGhlIHByb2Nlc3MgYW5kIHJlLXNlbmQNCmEgZml4ZWQgcGF0Y2guICBMaW51
eCBkb2Vzbid0IGNhcmUgaWYgdGhlIHByb2Nlc3MgaXMgYSBwcm9ncmFtDQp0aGF0IHJ1bnMgd2l0
aCB0aGUgY2xpY2sgb2YgYSBidXR0b24sIG9yIHRoZSByZXN1bHQgb2YgMTAwMA0KZW5naW5lZXJp
bmcgbGFib3JpbmcgZGF5IGFuZCBuaWdodC4gT25seSB0aGUgcmVzdWx0IG1hdHRlcnMsDQp0aGUg
cmVzdWx0IHNob3VsZCBiZSBjb3JyZWN0LCBhbmQgdGhpcyBwYXRjaCBpcyBub3QgY29ycmVjdC4N
Cg0KLUxlbg0KDQo=
