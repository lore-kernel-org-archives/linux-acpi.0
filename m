From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 13/16] ACPICA: Move _PRT repair into the standard
 complex repair module
Date: Thu, 20 Jun 2013 00:41:49 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802418933@SHSMSX101.ccr.corp.intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88551@ORSMSX103.amr.corp.intel.com>
 <32658874.38eDoNxZF3@vostro.rjw.lan> <6076307.SjBblEYW5y@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27399 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935269Ab3FTAmG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Jun 2013 20:42:06 -0400
In-Reply-To: <6076307.SjBblEYW5y@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

PiA+ID4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UuIFRoaXMgY2hhbmdlIHNpbXBseSBtb3ZlcyB0aGUg
cmVwYWlyIGNvZGUgZnJvbQ0KPiA+ID4gd2hlcmUgaXQgd2FzIG9yaWdpbmFsbHkgaW1wbGVtZW50
ZWQgdG8gdGhlIChtb3JlIHJlY2VudCkgcmVwYWlyIG1vZHVsZQ0KPiB3aGVyZSBpdCBub3cgYmVs
b25ncy4NCj4gPg0KPiA+IE9LLCBJJ2xsIGFwcGx5IHRoaXMgb25lIHdpdGggYSBmaXhlZC11cCBj
aGFuZ2Vsb2cuDQo+IA0KPiBBcHBsaWVkIG5vdy4NCg0KSGksIEJvYiBhbmQgUmFmYWVsLA0KDQpJ
J20gb3V0IG9mIHRoZSBkaWFsb2d1ZS4gSSB3YXMgd29ya2luZyBvbiBvdGhlciB0aGluZ3MuDQoN
ClRoYW5rcyBmb3IgZG9pbmcgc28gb24gUEFUQ0ggMTMtMTUgZm9yIG1lLg0KSSBmb3VuZCB0aGVt
IGluIHRoZSBibGVlZGluZy1lZGdlIGJyYW5jaCBvZiBsaW51eC1wbSByZXBvLg0KDQpNYW55IG9m
IHRoZSBjb21taXQgbG9nIGlzc3VlcyBhcmUgaXNzdWVzIGhhcHBlbmVkIGFsb25nIHdpdGggdGhl
IHJlbGVhc2UgYXV0b21hdGlvbi4NCkkganVzdCBwbGF5ZWQgYSBtb25rZXkgcm9sZSBpbiB0aGUg
cmVsZWFzZSBwcm9jZXNzIHdpdGggc29tZSBjb21taXR0ZWQgdGVzdHMgcGVyZm9ybWVkLg0KSSBh
Z3JlZSBpdCdzIGEga2luZCBvZiBwb2xpY3kgaXNzdWVzLiBJIHdpbGwgaW1wcm92ZSB0aGUgcmVs
ZWFzZSBwcm9jZXNzIGNvbnRpbnVvdXNseS4NCg0KQmVzdCByZWdhcmRzDQotTHYNCg==
