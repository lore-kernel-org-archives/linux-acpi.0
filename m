From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPI: remove "config ACPI_DEBUG_FUNC_TRACE"
Date: Sun, 7 Apr 2013 07:00:34 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88015CDB97@SHSMSX101.ccr.corp.intel.com>
References: <1363689661.1390.9.camel@x61.thuisdomein>
 <3588021.V98D5VToQr@vostro.rjw.lan>
 <1AE640813FDE7649BE1B193DEA596E88015CD54B@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48416 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755520Ab3DGHAj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Apr 2013 03:00:39 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88015CD54B@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Bolle <pebolle@tiscali.nl>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

PiA+ID4gS2NvbmZpZyBzeW1ib2wgQUNQSV9ERUJVR19GVU5DX1RSQUNFIHdhcyBvbmx5IHVzZWQg
KHRocm91Z2ggaXRzDQo+ID4gPiBjb3JyZXNwb25kaW5nIG1hY3JvKSBpbiBkcml2ZXJzL2FjcGkv
YWNwaWNhL2FjbWFjcm9zLmguIFRoYXQgbWFjcm8NCj4gPiA+IHdhcyByZW1vdmVkIGZyb20gdGhh
dCBoZWFkZXIgaW4gdjMuOCwgd2l0aCBjb21taXQNCj4gPiA+IDg2ZmYwZTUwOGY4OGVkYTZlNDc5
YTg5NzQ3NjAyNjA1NTgzMWQyZDggKCJBQ1BJQ0E6IEZpeCB1bm1lcmdlZA0KPiA+ID4gYWNtYWNy
b3MuaCBkaXZlcmdlbmNlcy4iKS4gVGhhdCBjb21taXQgZGlkIG5vdCBleHBsYWluIHdoeSB0aGF0
DQo+ID4gPiBtYWNybyB3YXMgcmVtb3ZlZC4gQnV0IGl0IHNlZW1zIHRoYXQgQUNQSV9ERUJVR19G
VU5DX1RSQUNFIGNhbg0KPiBub3cNCj4gPiA+IGJlIHJlbW92ZWQgdG9vLCBhcyBpdCBpcyB1bnVz
ZWQuDQo+ID4NCj4gPiBMdiwgY2FuIHlvdSBwbGVhc2UgY29tbWVudCBoZXJlPw0KPiANCj4gU29y
cnkgZm9yIHRoZSBkZWxheWVkIHJlcGx5Lg0KPiANCj4gVGhlIGNvbW1pdCBzaG91bGQgaGF2ZSBk
b25lIHNvbWV0aGluZyB0aGF0IGFscmVhZHkgaGF2ZSBiZWVuIGRvbmUgaW4gdGhlDQo+IEFDUElD
QS4NCj4gSSdsbCB0YWtlIGEgbG9vayBhdCB0aGlzLg0KDQpUaGUgb3JpZ2luYWwgY29tbWl0IGRl
bGV0ZWQgQ09ORklHX0FDUElfREVCVUdfRlVOQ19UUkFDRSBmcm9tIGFjbWFjcm9zLmggYXMgaXQg
aXMgaW4gdGhlIF9fd3JvbmdfXyBwbGFjZS4NCkNPTkZJR194eHggaXMgbGludXggc3BlY2lmaWMg
Y29kZXMgdGh1cyBzaG91bGQgYXBwZWFyIGluIE9TTCBsYXllciAtIGFjbGludXguaC4NCkFDUElD
QSBzcGVjaWZpYyBjb2RlcyBzaG91bGQgb25seSB1c2Ugc2VsZWN0aXZlIGRlZmluaXRpb25zIGlu
ICNpZmRlZiBBQ1BJX3h4eCBzdHlsZSBhbmQgc3VjaCBjb2RlcyBzaG91bGQgYmUgbWVyZ2VkIGlu
dG8gQUNQSUNBIHJhdGhlciB0aGFuIGJlaW5nIG1lcmdlZCBpbnRvIExpbnV4IEFDUEkuDQoNCk5v
dyB3ZSBoYXZlIHR3byBjaG9pY2VzOg0KUmUtaW1wbGVtZW50IGl0IGluIHRoZSBhY2xpbnV4Lmgg
dXNpbmcgIkFDUElfREVCVUdfT1VUUFVUIiBkZWZpbmVkL3VuZGVmaW5lZCBvciBkZWxldGUgdGhp
cyBrZXJuZWwgY29uZmlndXJhdGlvbiBpdGVtIHRlbXBvcmFyaWx5Lg0KDQpUaGFua3MgYW5kIGJl
c3QgcmVnYXJkcw0KLUx2DQo=
