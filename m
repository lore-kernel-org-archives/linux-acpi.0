From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Tue, 28 Apr 2015 00:44:12 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880270F55F@SHSMSX101.ccr.corp.intel.com>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <1AE640813FDE7649BE1B193DEA596E880270F2B2@SHSMSX101.ccr.corp.intel.com>
 <20150427084631.GA6774@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29586 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597AbbD1AoS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Apr 2015 20:44:18 -0400
In-Reply-To: <20150427084631.GA6774@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac <linux-edac@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

SGksDQoNCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IFttYWlsdG86YnBAYWxpZW44LmRlXQ0KPiBT
ZW50OiBNb25kYXksIEFwcmlsIDI3LCAyMDE1IDQ6NDcgUE0NCj4gDQo+IE9uIE1vbiwgQXByIDI3
LCAyMDE1IGF0IDAzOjE2OjAwQU0gKzAwMDAsIFpoZW5nLCBMdiB3cm90ZToNCj4gPiA+IEBAIC04
NDAsNyArODQwLDkgQEAgc3RhdGljIGludCBnaGVzX25vdGlmeV9ubWkodW5zaWduZWQgaW50IGNt
ZCwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+ID4gPiAgCXN0cnVjdCBnaGVzICpnaGVzOw0KPiA+
ID4gIAlpbnQgc2V2LCByZXQgPSBOTUlfRE9ORTsNCj4gPiA+DQo+ID4gPiAtCXJhd19zcGluX2xv
Y2soJmdoZXNfbm1pX2xvY2spOw0KPiA+ID4gKwlpZiAoIWF0b21pY19hZGRfdW5sZXNzKCZnaGVz
X2luX25taSwgMSwgMSkpDQo+ID4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ID4gKw0KPiA+DQo+ID4g
SnVzdCBhIHNpbXBsZSBxdWVzdGlvbi4NCj4gPiBXaHkgbm90IGp1c3QgdXNpbmcgY21weGNoZyBo
ZXJlIGluc3RlYWQgb2YgYXRvbWljX2FkZF91bmxlc3Mgc28gdGhhdCBubyBhdG9taWNfZGVjIHdp
bGwgYmUgbmVlZGVkLg0KPiANCj4gV2hhdCBkbyB5b3UgdGhpbmsgYXRvbWljX2FkZF91bmxlc3Mg
ZW5kcyB1cCBkb2luZzoNCj4gDQo+ICNBUFANCj4gIyAxNzcgIi4vYXJjaC94ODYvaW5jbHVkZS9h
c20vYXRvbWljLmgiIDENCj4gCS5wdXNoc2VjdGlvbiAuc21wX2xvY2tzLCJhIg0KPiAuYmFsaWdu
IDQNCj4gLmxvbmcgNjcxZiAtIC4NCj4gLnBvcHNlY3Rpb24NCj4gNjcxOg0KPiAJbG9jazsgY21w
eGNoZ2wgJWVkeCxnaGVzX2luX25taSglcmlwKQkjIEQuMzcwNTYsIE1FTVsodm9sYXRpbGUgdTMy
ICopJmdoZXNfaW5fbm1pXQ0KPiAjIDAgIiIgMg0KPiAjTk9fQVBQDQo+IA0KPiBBbmQgeW91IG5l
ZWQgdG8gYXRvbWljX2RlYygpIHNvIHRoYXQgYW5vdGhlciByZWFkZXIgY2FuIGVudGVyLCBpLmUu
IGhvdw0KPiB0aGUgZXhjbHVzaW9uIHByaW1pdGl2ZSB3b3Jrcy4NCj4gDQo+IE9yIGRpZCB5b3Ug
aGF2ZSBzb21ldGhpbmcgZWxzZSBpbiBtaW5kPw0KDQpNeSBtaXN0YWtlLg0KSSBtZWFuIGNtcHhj
aGcoKSBhbmQgeGNoZygpIChvciBhdG9taWNfY21weGNoZygpIGFuZCBhdG9taWNfeGNoZygpKSBw
YWlyIGhlcmUsIHNvIG5vdGhpbmcgY2FuIGJlIHJlZHVjZWQuDQoNCkJ1dCBJTU8sIGF0b21pY19h
ZGRfdW5sZXNzKCkgaXMgaW1wbGVtZW50ZWQgdmlhIGNtcHhjaGcgb24gbWFueSBhcmNoaXRlY3R1
cmVzLg0KQW5kIGl0IG1pZ2h0IGJlIGJldHRlciB0byB1c2UgaXQgZGlyZWN0bHkgaGVyZSB3aGlj
aCBpcyBhIGJpdCBmYXN0ZXIgYXMgeW91IGFjdHVhbGx5IG9ubHkgbmVlZCBvbmUgdmFsdWUgc3dp
dGNoIGhlcmUuDQoNClRoYW5rcyBhbmQgYmVzdCByZWdhcmRzDQotTHYNCg0KDQo+IA0KPiAtLQ0K
PiBSZWdhcmRzL0dydXNzLA0KPiAgICAgQm9yaXMuDQo+IA0KPiBFQ08gdGlwICMxMDE6IFRyaW0g
eW91ciBtYWlscyB3aGVuIHlvdSByZXBseS4NCj4gLS0NCg==
