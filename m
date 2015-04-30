From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Thu, 30 Apr 2015 08:05:12 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802712130@SHSMSX101.ccr.corp.intel.com>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <1AE640813FDE7649BE1B193DEA596E880270F835@SHSMSX101.ccr.corp.intel.com>
 <20150428135913.GD19025@pd.tnic>
 <1AE640813FDE7649BE1B193DEA596E880270FB3B@SHSMSX101.ccr.corp.intel.com>
 <20150429081355.GA5498@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27674 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbbD3IFU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Apr 2015 04:05:20 -0400
In-Reply-To: <20150429081355.GA5498@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac <linux-edac@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

SGksDQoNCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IFttYWlsdG86YnBAYWxpZW44LmRlXQ0KPiBT
ZW50OiBXZWRuZXNkYXksIEFwcmlsIDI5LCAyMDE1IDQ6MTQgUE0NCj4gU3ViamVjdDogUmU6IFtS
RkMgUEFUQ0ggNS81XSBHSEVTOiBNYWtlIE5NSSBoYW5kbGVyIGhhdmUgYSBzaW5nbGUgcmVhZGVy
DQo+IA0KPiBPbiBXZWQsIEFwciAyOSwgMjAxNSBhdCAxMjo0OTo1OUFNICswMDAwLCBaaGVuZywg
THYgd3JvdGU6DQo+ID4gPiA+IFdlIGFic29sdXRlbHkgd2FudCB0byB1c2UgYXRvbWljX2FkZF91
bmxlc3MoKSBiZWNhdXNlIHdlIGdldCB0byBzYXZlIHVzDQo+ID4gPiA+IHRoZSBleHBlbnNpdmUN
Cj4gPiA+ID4NCj4gPiA+ID4gCUxPQ0s7IENNUFhDSEcNCj4gPiA+ID4NCj4gPiA+ID4gaWYgdGhl
IHZhbHVlIHdhcyBhbHJlYWR5IDEuIFdoaWNoIGlzIGV4YWN0bHkgd2hhdCB0aGlzIHBhdGNoIGlz
IHRyeWluZw0KPiA+ID4gPiB0byBhdm9pZCAtIGEgdGh1bmRlcmluZyBoZXJkIG9mIGNvcmVzIENN
UFhDSEdpbmcgYSBnbG9iYWwgdmFyaWFibGUuDQo+ID4gPg0KPiA+ID4gSU1PLCBvbiBtb3N0IGFy
Y2hpdGVjdHVyZXMsIHRoZSAiY21wIiBwYXJ0IHNob3VsZCB3b3JrIGp1c3QgbGlrZSB3aGF0IHlv
dSd2ZSBkb25lIHdpdGggImlmIi4NCj4gPiA+IEFuZCBvbiBzb21lIGFyY2hpdGVjdHVyZXMsIGlm
IHRoZSAieGNoZyIgZG9lc24ndCBoYXBwZW4sIHRoZSAiY21wIiBwYXJ0IGV2ZW4gd29uJ3QgY2F1
c2UgYSBwaXBlIGxpbmUgaGF6YXJkLg0KPiANCj4gRXZlbiBpZiBDTVBYQ0hHIGlzIGJlaW5nIHNw
bGl0IGludG8gc2V2ZXJhbCBtaWNyb29wcywgdGhleSBhbGwgc3RpbGwNCj4gbmVlZCB0byBmbG93
IGRvd24gdGhlIHBpcGUgYW5kIHJlcXVpcmUgcmVzb3VyY2VzIGFuZCB0cmFja2luZy4gQW5kIHlv
dQ0KPiBvbmx5IGtub3cgYXQgcmV0aXJlIHRpbWUgd2hhdCB0aGUgQ01QIHJlc3VsdCBpcyBhbmQg
Y2FuICJkaXNjYXJkIiB0aGUNCj4gWENIRyBwYXJ0LiBQcm92aWRlZCB0aGUgdWFyY2ggaXMgc21h
cnQgZW5vdWdoIHRvIGRvIHRoYXQuDQo+IA0KPiBUaGlzIGlzIHByb2JhYmx5IHdoeSBDTVBYQ0hH
IG5lZWRzIDUsNiw3LDEwLDIyLC4uLiBjeWNsZXMgZGVwZW5kaW5nIG9uDQo+IHVhcmNoIGFuZCB2
ZW5kb3IsIGlmIEkgY2FuIHRydXN0IEFnbmVyIEZvZydzIHRhYmxlcy4gQW5kIEkgYmV0IHRob3Nl
DQo+IG51bWJlcnMgYXJlIGJlc3QtY2FzZSBvbmx5IGFuZCBpbiByZWFsLWxpZmUgdGhleSBwcm9i
YWJseSB0ZW5kIHRvIGZhbGwNCj4gb3V0IGV2ZW4gd29yc2UuDQo+IA0KPiBDTVAgbmVlZHMgb25s
eSAxLiBPbiBhbG1vc3QgZXZlcnkgdWFyY2ggYW5kIHZlbmRvci4gQW5kIGV2ZW4gdGhhdCBjeWNs
ZQ0KPiBwcm9iYWJseSBnZXRzIGhpZGRlbiB3aXRoIGEgZ29vZCBicmFuY2ggcHJlZGljdG9yLg0K
DQpBcmUgdGhlcmUgYW55IHN1Y2ggZGF0YSBhcm91bmQgdGhlIFNDIGFuZCBMTCAoTUlQUyk/DQoN
Cj4gDQo+ID4gSWYgeW91IG1hbiB0aGUgTE9DSyBwcmVmaXgsIEkgdW5kZXJzdGFuZCBub3cuDQo+
IA0KPiBBbmQgdGhhdCBtYWtlcyBzZXZlcmFsIHRpbWVzIHdvcnNlOiAyMiwgNDAsIDgwLCAuLi4g
Y3ljbGVzLg0KDQpJJ20gT0sgaWYgdGhlIGNvZGUgc3RpbGwga2VlcHMgdGhlIHJlYWRhYmlsaXR5
IHRoZW4uDQoNClRoYW5rcyBhbmQgYmVzdCByZWdhcmRzDQotTHYNCg0KPiANCj4gLS0NCj4gUmVn
YXJkcy9HcnVzcywNCj4gICAgIEJvcmlzLg0KPiANCj4gRUNPIHRpcCAjMTAxOiBUcmltIHlvdXIg
bWFpbHMgd2hlbiB5b3UgcmVwbHkuDQo+IC0tDQo=
