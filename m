From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Sat, 2 May 2015 00:34:19 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802712455@SHSMSX101.ccr.corp.intel.com>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <1AE640813FDE7649BE1B193DEA596E880270F835@SHSMSX101.ccr.corp.intel.com>
 <20150428135913.GD19025@pd.tnic>
 <1AE640813FDE7649BE1B193DEA596E880270FB3B@SHSMSX101.ccr.corp.intel.com>
 <20150429081355.GA5498@pd.tnic>
 <1AE640813FDE7649BE1B193DEA596E8802712130@SHSMSX101.ccr.corp.intel.com>
 <20150430084838.GC3488@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6209 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbbEBAem (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 May 2015 20:34:42 -0400
In-Reply-To: <20150430084838.GC3488@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac <linux-edac@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

SGksDQoNCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IFttYWlsdG86YnBAYWxpZW44LmRlXQ0KPiBT
ZW50OiBUaHVyc2RheSwgQXByaWwgMzAsIDIwMTUgNDo0OSBQTQ0KPiANCj4gT24gVGh1LCBBcHIg
MzAsIDIwMTUgYXQgMDg6MDU6MTJBTSArMDAwMCwgWmhlbmcsIEx2IHdyb3RlOg0KPiA+IEFyZSB0
aGVyZSBhbnkgc3VjaCBkYXRhIGFyb3VuZCB0aGUgU0MgYW5kIExMIChNSVBTKT8NCj4gDQo+IFdo
YXQsIHlvdSBjYW4ndCBzZWFyY2ggdGhlIGludGVybmV0IHlvdXJzZWxmPw0KDQpJIG1lYW4gaWYg
TEwgY2FuIGRvIHdoYXQgeW91IGV4YWN0bHkgZGlkIHdpdGggImlmIiBhbmQgbm8gQUJBIHByb2Js
ZW0gY2FuIGJyZWFrIHRoZSBhdG9taWNfYWRkX3VubGVzcygpIHVzZXJzLg0KVGhlbiBubyBhdG9t
aWNfY21weGNoZygpIHVzZXJzIG1pZ2h0IGJlIGJyb2tlbiBmb3IgdGhlIHNhbWUgcmVhc29uLg0K
V2h5IGRvbid0IHlvdSBwdXQgYW4gImlmIiBpbiB0aGUgYXRvbWljX2NtcHhjaGcoKSB0byBhbGxv
dyBvdGhlciB1c2VycyB0byBoYXZlIHRoZSBzYW1lIGJlbmVmaXQgYmVjYXVzZSBvZiB0aGUgZGF0
YT8NCg0KQnV0IHRoaXMgaXMgb3V0IG9mIHRoZSBjb250ZXh0IGZvciB0aGlzIHBhdGNoLg0KSSBh
Y3R1YWxseSBkb24ndCBoYXZlIGFueSBBUEkgdXNhZ2UgcHJlZmVyZW5jZSBub3cuDQoNClRoYW5r
cw0KLUx2DQoNCj4gDQo+IC0tDQo+IFJlZ2FyZHMvR3J1c3MsDQo+ICAgICBCb3Jpcy4NCj4gDQo+
IEVDTyB0aXAgIzEwMTogVHJpbSB5b3VyIG1haWxzIHdoZW4geW91IHJlcGx5Lg0KPiAtLQ0K
