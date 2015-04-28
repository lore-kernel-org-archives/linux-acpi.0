From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Tue, 28 Apr 2015 02:24:16 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880270F5C8@SHSMSX101.ccr.corp.intel.com>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <1AE640813FDE7649BE1B193DEA596E880270F2B2@SHSMSX101.ccr.corp.intel.com>
 <20150427084631.GA6774@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:65446 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849AbbD1CYw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Apr 2015 22:24:52 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac <linux-edac@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

SGksDQoNCj4gRnJvbTogWmhlbmcsIEx2DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDI4LCAyMDE1
IDg6NDQgQU0NCj4gDQo+IEhpLA0KPiANCj4gPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgW21haWx0
bzpicEBhbGllbjguZGVdDQo+ID4gU2VudDogTW9uZGF5LCBBcHJpbCAyNywgMjAxNSA0OjQ3IFBN
DQo+ID4NCj4gPiBPbiBNb24sIEFwciAyNywgMjAxNSBhdCAwMzoxNjowMEFNICswMDAwLCBaaGVu
ZywgTHYgd3JvdGU6DQo+ID4gPiA+IEBAIC04NDAsNyArODQwLDkgQEAgc3RhdGljIGludCBnaGVz
X25vdGlmeV9ubWkodW5zaWduZWQgaW50IGNtZCwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+ID4g
PiA+ICAJc3RydWN0IGdoZXMgKmdoZXM7DQo+ID4gPiA+ICAJaW50IHNldiwgcmV0ID0gTk1JX0RP
TkU7DQo+ID4gPiA+DQo+ID4gPiA+IC0JcmF3X3NwaW5fbG9jaygmZ2hlc19ubWlfbG9jayk7DQo+
ID4gPiA+ICsJaWYgKCFhdG9taWNfYWRkX3VubGVzcygmZ2hlc19pbl9ubWksIDEsIDEpKQ0KPiA+
ID4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiArDQo+ID4gPg0KPiA+ID4gSnVzdCBhIHNpbXBs
ZSBxdWVzdGlvbi4NCj4gPiA+IFdoeSBub3QganVzdCB1c2luZyBjbXB4Y2hnIGhlcmUgaW5zdGVh
ZCBvZiBhdG9taWNfYWRkX3VubGVzcyBzbyB0aGF0IG5vIGF0b21pY19kZWMgd2lsbCBiZSBuZWVk
ZWQuDQo+ID4NCj4gPiBXaGF0IGRvIHlvdSB0aGluayBhdG9taWNfYWRkX3VubGVzcyBlbmRzIHVw
IGRvaW5nOg0KPiA+DQo+ID4gI0FQUA0KPiA+ICMgMTc3ICIuL2FyY2gveDg2L2luY2x1ZGUvYXNt
L2F0b21pYy5oIiAxDQo+ID4gCS5wdXNoc2VjdGlvbiAuc21wX2xvY2tzLCJhIg0KPiA+IC5iYWxp
Z24gNA0KPiA+IC5sb25nIDY3MWYgLSAuDQo+ID4gLnBvcHNlY3Rpb24NCj4gPiA2NzE6DQo+ID4g
CWxvY2s7IGNtcHhjaGdsICVlZHgsZ2hlc19pbl9ubWkoJXJpcCkJIyBELjM3MDU2LCBNRU1bKHZv
bGF0aWxlIHUzMiAqKSZnaGVzX2luX25taV0NCj4gPiAjIDAgIiIgMg0KPiA+ICNOT19BUFANCj4g
Pg0KPiA+IEFuZCB5b3UgbmVlZCB0byBhdG9taWNfZGVjKCkgc28gdGhhdCBhbm90aGVyIHJlYWRl
ciBjYW4gZW50ZXIsIGkuZS4gaG93DQo+ID4gdGhlIGV4Y2x1c2lvbiBwcmltaXRpdmUgd29ya3Mu
DQo+ID4NCj4gPiBPciBkaWQgeW91IGhhdmUgc29tZXRoaW5nIGVsc2UgaW4gbWluZD8NCj4gDQo+
IE15IG1pc3Rha2UuDQo+IEkgbWVhbiBjbXB4Y2hnKCkgYW5kIHhjaGcoKSAob3IgYXRvbWljX2Nt
cHhjaGcoKSBhbmQgYXRvbWljX3hjaGcoKSkgcGFpciBoZXJlLCBzbyBub3RoaW5nIGNhbiBiZSBy
ZWR1Y2VkLg0KDQpMZXQgbWUgY29ycmVjdCwgaXQgc2hvdWxkIGJlIGF0b21pY19jbXB4Y2hnKCkg
YW5kIGF0b21pY19zZXQoKSBoZXJlIGFzIHlvdSBvbmx5IG5lZWQgdG8gc3dpdGNoIGJldHdlZW4g
MCBhbmQgMS4NClNvcnJ5IGZvciB0aGUgbm9pc2UuDQoNClRoYW5rcyBhbmQgYmVzdCByZWdhcmRz
DQotTHYNCg0KPiANCj4gQnV0IElNTywgYXRvbWljX2FkZF91bmxlc3MoKSBpcyBpbXBsZW1lbnRl
ZCB2aWEgY21weGNoZyBvbiBtYW55IGFyY2hpdGVjdHVyZXMuDQo+IEFuZCBpdCBtaWdodCBiZSBi
ZXR0ZXIgdG8gdXNlIGl0IGRpcmVjdGx5IGhlcmUgd2hpY2ggaXMgYSBiaXQgZmFzdGVyIGFzIHlv
dSBhY3R1YWxseSBvbmx5IG5lZWQgb25lIHZhbHVlIHN3aXRjaCBoZXJlLg0KPiANCj4gVGhhbmtz
IGFuZCBiZXN0IHJlZ2FyZHMNCj4gLUx2DQo+IA0KPiANCj4gPg0KPiA+IC0tDQo+ID4gUmVnYXJk
cy9HcnVzcywNCj4gPiAgICAgQm9yaXMuDQo+ID4NCj4gPiBFQ08gdGlwICMxMDE6IFRyaW0geW91
ciBtYWlscyB3aGVuIHlvdSByZXBseS4NCj4gPiAtLQ0K
