From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Wed, 29 Apr 2015 00:24:40 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880270FAD9@SHSMSX101.ccr.corp.intel.com>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <1AE640813FDE7649BE1B193DEA596E880270F835@SHSMSX101.ccr.corp.intel.com>
 <20150428135913.GD19025@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8639 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031191AbbD2AYr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Apr 2015 20:24:47 -0400
In-Reply-To: <20150428135913.GD19025@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac <linux-edac@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

SGksDQoNCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IFttYWlsdG86YnBAYWxpZW44LmRlXQ0KPiBT
ZW50OiBUdWVzZGF5LCBBcHJpbCAyOCwgMjAxNSA5OjU5IFBNDQo+IFN1YmplY3Q6IFJlOiBbUkZD
IFBBVENIIDUvNV0gR0hFUzogTWFrZSBOTUkgaGFuZGxlciBoYXZlIGEgc2luZ2xlIHJlYWRlcg0K
PiANCj4gT24gVHVlLCBBcHIgMjgsIDIwMTUgYXQgMDE6Mzg6NDFQTSArMDAwMCwgWmhlbmcsIEx2
IHdyb3RlOg0KPiA+ID4gLQlyYXdfc3Bpbl9sb2NrKCZnaGVzX25taV9sb2NrKTsNCj4gPiA+ICsJ
aWYgKCFhdG9taWNfYWRkX3VubGVzcygmZ2hlc19pbl9ubWksIDEsIDEpKQ0KPiA+ID4gKwkJcmV0
dXJuIHJldDsNCj4gPiA+ICsNCj4gPg0KPiA+IGlmIChhdG9taWNfY21weGNoZygmZ2hlc19pbl9u
bWksIDAsIDEpKQ0KPiA+IAlyZXR1cm4gcmV0Ow0KPiANCj4gT2ssIG5vdyBJIHVuZGVyc3RhbmQg
d2hhdCB5b3UgbWVhbi4NCj4gDQo+IFdlIGFic29sdXRlbHkgd2FudCB0byB1c2UgYXRvbWljX2Fk
ZF91bmxlc3MoKSBiZWNhdXNlIHdlIGdldCB0byBzYXZlIHVzDQo+IHRoZSBleHBlbnNpdmUNCj4g
DQo+IAlMT0NLOyBDTVBYQ0hHDQo+IA0KPiBpZiB0aGUgdmFsdWUgd2FzIGFscmVhZHkgMS4gV2hp
Y2ggaXMgZXhhY3RseSB3aGF0IHRoaXMgcGF0Y2ggaXMgdHJ5aW5nDQo+IHRvIGF2b2lkIC0gYSB0
aHVuZGVyaW5nIGhlcmQgb2YgY29yZXMgQ01QWENIR2luZyBhIGdsb2JhbCB2YXJpYWJsZS4NCg0K
SU1PLCBvbiBtb3N0IGFyY2hpdGVjdHVyZXMsIHRoZSAiY21wIiBwYXJ0IHNob3VsZCB3b3JrIGp1
c3QgbGlrZSB3aGF0IHlvdSd2ZSBkb25lIHdpdGggImlmIi4NCkFuZCBvbiBzb21lIGFyY2hpdGVj
dHVyZXMsIGlmIHRoZSAieGNoZyIgZG9lc24ndCBoYXBwZW4sIHRoZSAiY21wIiBwYXJ0IGV2ZW4g
d29uJ3QgY2F1c2UgYSBwaXBlIGxpbmUgaGF6YXJkLg0KDQpUaGFua3MgYW5kIGJlc3QgcmVnYXJk
cw0KLUx2DQoNCg0KPiANCj4gSS5lLiwNCj4gDQo+IAltb3ZsCWdoZXNfaW5fbm1pKCVyaXApLCAl
ZWN4CSMgTUVNWyhjb25zdCBpbnQgKikmZ2hlc19pbl9ubWldLCBjDQo+IAljbXBsCSQxLCAlZWN4
CSMsIGMNCj4gCWplCS5MMzExCSMsCQkJCTwtLS0gZXhpdCBoZXJlIGlmIGdoZXNfaW5fbm1pID09
IDEuDQo+IAlsZWFsCTEoJXJjeCksICVlZHgJIywgRC4zNzE2Mw0KPiAJbW92bAklZWN4LCAlZWF4
CSMgYywgYw0KPiAjQVBQDQo+ICMgMTc3ICIuL2FyY2gveDg2L2luY2x1ZGUvYXNtL2F0b21pYy5o
IiAxDQo+IAkucHVzaHNlY3Rpb24gLnNtcF9sb2NrcywiYSINCj4gLmJhbGlnbiA0DQo+IC5sb25n
IDY3MWYgLSAuDQo+IC5wb3BzZWN0aW9uDQo+IDY3MToNCj4gCWxvY2s7IGNtcHhjaGdsICVlZHgs
Z2hlc19pbl9ubWkoJXJpcCkJIyBELjM3MTYzLCBNRU1bKHZvbGF0aWxlIHUzMiAqKSZnaGVzX2lu
X25taV0NCj4gIyAwICIiIDINCj4gI05PX0FQUA0KPiANCj4gLS0NCj4gUmVnYXJkcy9HcnVzcywN
Cj4gICAgIEJvcmlzLg0KPiANCj4gRUNPIHRpcCAjMTAxOiBUcmltIHlvdXIgbWFpbHMgd2hlbiB5
b3UgcmVwbHkuDQo+IC0tDQo=
