From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Wed, 29 Apr 2015 00:49:59 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880270FB3B@SHSMSX101.ccr.corp.intel.com>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <1AE640813FDE7649BE1B193DEA596E880270F835@SHSMSX101.ccr.corp.intel.com>
 <20150428135913.GD19025@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:40987 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031281AbbD2Aua (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Apr 2015 20:50:30 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac <linux-edac@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

SGksDQoNCj4gRnJvbTogWmhlbmcsIEx2DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMjksIDIw
MTUgODoyNSBBTQ0KPiBTdWJqZWN0OiBSRTogW1JGQyBQQVRDSCA1LzVdIEdIRVM6IE1ha2UgTk1J
IGhhbmRsZXIgaGF2ZSBhIHNpbmdsZSByZWFkZXINCj4gDQo+IEhpLA0KPiANCj4gPiBGcm9tOiBC
b3Jpc2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGllbjguZGVdDQo+ID4gU2VudDogVHVlc2RheSwg
QXByaWwgMjgsIDIwMTUgOTo1OSBQTQ0KPiA+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDUvNV0g
R0hFUzogTWFrZSBOTUkgaGFuZGxlciBoYXZlIGEgc2luZ2xlIHJlYWRlcg0KPiA+DQo+ID4gT24g
VHVlLCBBcHIgMjgsIDIwMTUgYXQgMDE6Mzg6NDFQTSArMDAwMCwgWmhlbmcsIEx2IHdyb3RlOg0K
PiA+ID4gPiAtCXJhd19zcGluX2xvY2soJmdoZXNfbm1pX2xvY2spOw0KPiA+ID4gPiArCWlmICgh
YXRvbWljX2FkZF91bmxlc3MoJmdoZXNfaW5fbm1pLCAxLCAxKSkNCj4gPiA+ID4gKwkJcmV0dXJu
IHJldDsNCj4gPiA+ID4gKw0KPiA+ID4NCj4gPiA+IGlmIChhdG9taWNfY21weGNoZygmZ2hlc19p
bl9ubWksIDAsIDEpKQ0KPiA+ID4gCXJldHVybiByZXQ7DQo+ID4NCj4gPiBPaywgbm93IEkgdW5k
ZXJzdGFuZCB3aGF0IHlvdSBtZWFuLg0KPiA+DQo+ID4gV2UgYWJzb2x1dGVseSB3YW50IHRvIHVz
ZSBhdG9taWNfYWRkX3VubGVzcygpIGJlY2F1c2Ugd2UgZ2V0IHRvIHNhdmUgdXMNCj4gPiB0aGUg
ZXhwZW5zaXZlDQo+ID4NCj4gPiAJTE9DSzsgQ01QWENIRw0KPiA+DQo+ID4gaWYgdGhlIHZhbHVl
IHdhcyBhbHJlYWR5IDEuIFdoaWNoIGlzIGV4YWN0bHkgd2hhdCB0aGlzIHBhdGNoIGlzIHRyeWlu
Zw0KPiA+IHRvIGF2b2lkIC0gYSB0aHVuZGVyaW5nIGhlcmQgb2YgY29yZXMgQ01QWENIR2luZyBh
IGdsb2JhbCB2YXJpYWJsZS4NCj4gDQo+IElNTywgb24gbW9zdCBhcmNoaXRlY3R1cmVzLCB0aGUg
ImNtcCIgcGFydCBzaG91bGQgd29yayBqdXN0IGxpa2Ugd2hhdCB5b3UndmUgZG9uZSB3aXRoICJp
ZiIuDQo+IEFuZCBvbiBzb21lIGFyY2hpdGVjdHVyZXMsIGlmIHRoZSAieGNoZyIgZG9lc24ndCBo
YXBwZW4sIHRoZSAiY21wIiBwYXJ0IGV2ZW4gd29uJ3QgY2F1c2UgYSBwaXBlIGxpbmUgaGF6YXJk
Lg0KDQpJZiB5b3UgbWFuIHRoZSBMT0NLIHByZWZpeCwgSSB1bmRlcnN0YW5kIG5vdy4NCg0KVGhh
bmtzIGFuZCBiZXN0IHJlZ2FyZHMNCi1Mdg0KDQo+IA0KPiBUaGFua3MgYW5kIGJlc3QgcmVnYXJk
cw0KPiAtTHYNCj4gDQo+IA0KPiA+DQo+ID4gSS5lLiwNCj4gPg0KPiA+IAltb3ZsCWdoZXNfaW5f
bm1pKCVyaXApLCAlZWN4CSMgTUVNWyhjb25zdCBpbnQgKikmZ2hlc19pbl9ubWldLCBjDQo+ID4g
CWNtcGwJJDEsICVlY3gJIywgYw0KPiA+IAlqZQkuTDMxMQkjLAkJCQk8LS0tIGV4aXQgaGVyZSBp
ZiBnaGVzX2luX25taSA9PSAxLg0KPiA+IAlsZWFsCTEoJXJjeCksICVlZHgJIywgRC4zNzE2Mw0K
PiA+IAltb3ZsCSVlY3gsICVlYXgJIyBjLCBjDQo+ID4gI0FQUA0KPiA+ICMgMTc3ICIuL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL2F0b21pYy5oIiAxDQo+ID4gCS5wdXNoc2VjdGlvbiAuc21wX2xvY2tz
LCJhIg0KPiA+IC5iYWxpZ24gNA0KPiA+IC5sb25nIDY3MWYgLSAuDQo+ID4gLnBvcHNlY3Rpb24N
Cj4gPiA2NzE6DQo+ID4gCWxvY2s7IGNtcHhjaGdsICVlZHgsZ2hlc19pbl9ubWkoJXJpcCkJIyBE
LjM3MTYzLCBNRU1bKHZvbGF0aWxlIHUzMiAqKSZnaGVzX2luX25taV0NCj4gPiAjIDAgIiIgMg0K
PiA+ICNOT19BUFANCj4gPg0KPiA+IC0tDQo+ID4gUmVnYXJkcy9HcnVzcywNCj4gPiAgICAgQm9y
aXMuDQo+ID4NCj4gPiBFQ08gdGlwICMxMDE6IFRyaW0geW91ciBtYWlscyB3aGVuIHlvdSByZXBs
eS4NCj4gPiAtLQ0K
