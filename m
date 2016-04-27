From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 2/4] ACPI / osi: Cleanup _OSI("Linux") related code
 before introducing new support
Date: Wed, 27 Apr 2016 02:00:05 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB828CC@SHSMSX101.ccr.corp.intel.com>
References: <cover.1461656216.git.lv.zheng@intel.com>
	<413d8029309310091c6506773d602ed5a2adfdab.1461656216.git.lv.zheng@intel.com>
 <CAJZ5v0j7KMqk9VuBhstW6N62OA7U3rhQs6PxyAY=447+K2MZjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20699 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbcD0CAK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Apr 2016 22:00:10 -0400
In-Reply-To: <CAJZ5v0j7KMqk9VuBhstW6N62OA7U3rhQs6PxyAY=447+K2MZjg@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

SGksIFJhZmFlbA0KDQo+IEZyb206IHJqd3lzb2NraUBnbWFpbC5jb20gW21haWx0bzpyand5c29j
a2lAZ21haWwuY29tXSBPbiBCZWhhbGYgT2YNCj4gUmFmYWVsIEouIFd5c29ja2kNCj4gU2VudDog
V2VkbmVzZGF5LCBBcHJpbCAyNywgMjAxNiA0OjExIEFNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
Mi80XSBBQ1BJIC8gb3NpOiBDbGVhbnVwIF9PU0koIkxpbnV4IikgcmVsYXRlZCBjb2RlIGJlZm9y
ZQ0KPiBpbnRyb2R1Y2luZyBuZXcgc3VwcG9ydA0KPiANCj4gT24gVHVlLCBBcHIgMjYsIDIwMTYg
YXQgOTo0MCBBTSwgTHYgWmhlbmcgPGx2LnpoZW5nQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gVGhp
cyBwYXRjaCBjbGVhbnMgdXAgT1NJIGNvZGUgaW4gb3NsLmMgaW4gb3JkZXIgdG8gbWFrZSBvc2lf
bGludXggbm90DQo+ID4gX09TSSgiTGludXgiKSBzcGVjaWZpYyB0byBhbGxvdyBuZXcgZmVhdHVy
ZXMgdG8gcmV1c2UgdGhpcyBzdHJ1Y3R1cmUuDQo+IA0KPiBJIGd1ZXNzIHdoYXQgeW91IG1lYW4g
aGVyZSBpcyBzb21ldGhpbmcgbGlrZToNCj4gDQo+IENsZWFuIHVwIE9TSSBjb2RlIGluIG9zbC5j
IHRvIG1ha2Ugb3NpX2xpbnV4IHdvcmsgZm9yIE9TSSBzdHJpbmdzDQo+IG90aGVyIHRoYW4gIkxp
bnV4Iiwgc28gaXQgY2FuIGJlIHJlLXVzZWQgZm9yIG90aGVyIHB1cnBvc2VzLg0KPiANCj4gSXMg
dGhhdCBjb3JyZWN0Pw0KW0x2IFpoZW5nXSANCkV4YWN0bHkhDQoNClRoYW5rcw0KLUx2DQo=
