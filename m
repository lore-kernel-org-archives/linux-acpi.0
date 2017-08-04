From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 1/7] ACPI / blacklist: add acpi_match_oemlist()
 interface
Date: Fri, 4 Aug 2017 20:39:35 +0000
Message-ID: <1501878602.2042.113.camel@hpe.com>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
         <20170803215753.30553-2-toshi.kani@hpe.com>
         <20170804034206.GB12082@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:51582 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbdHDUji (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Aug 2017 16:39:38 -0400
In-Reply-To: <20170804034206.GB12082@nazgul.tnic>
Content-Language: en-US
Content-ID: <9A24415264B8444EA803778488582F0A@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

T24gRnJpLCAyMDE3LTA4LTA0IGF0IDA1OjQyICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgQXVnIDAzLCAyMDE3IGF0IDAzOjU3OjQ3UE0gLTA2MDAsIFRvc2hpIEthbmkg
d3JvdGU6DQo+ID4gQUNQSSBPRU0gSUQgLyBPRU0gVGFibGUgSUQgLyBSZXZpc2lvbiBjYW4gYmUg
dXNlZCB0byBpZGVudGlmeQ0KPiA+IGEgcGxhdGZvcm0gYmFzZWQgb24gQUNQSSBmaXJtd2FyZSBp
bmZvLsKgwqBhY3BpX2JsYWNrbGlzdGVkKCksDQo+ID4gaW50ZWxfcHN0YXRlX3BsYXRmb3JtX3B3
cl9tZ210X2V4aXN0cygpLCBhbmQgc29tZSBvdGhlciBmdW5jcywNCj4gPiBoYXZlIGJlZW4gdXNp
bmcgc2ltaWxhciBjaGVjayB0byBkZXRlY3QgYSBsaXN0IG9mIHBsYXRmb3Jtcw0KPiA+IHRoYXQg
cmVxdWlyZSBzcGVjaWFsIGhhbmRsaW5ncy4NCj4gPiANCj4gPiBNb3ZlIHRoZSBwbGF0Zm9ybSBj
aGVjayBpbiBhY3BpX2JsYWNrbGlzdGVkKCkgdG8gYSBuZXcgY29tbW9uDQo+ID4gdXRpbGl0eSBm
dW5jdGlvbiwgYWNwaV9tYXRjaF9vZW1saXN0KCksIHNvIHRoYXQgb3RoZXIgZHJpdmVycw0KPiA+
IGRvIG5vdCBoYXZlIHRvIGltcGxlbWVudCB0aGVpciBvd24gdmVyc2lvbi4NCj4gPiANCj4gPiBU
aGVyZSBpcyBubyBjaGFuZ2UgaW4gZnVuY3Rpb25hbGl0eS4NCiA6DQo+ID4gwqAvKg0KPiA+IMKg
ICogUE9MSUNZOiBJZiAqYW55dGhpbmcqIGRvZXNuJ3Qgd29yaywgcHV0IGl0IG9uIHRoZSBibGFj
a2xpc3QuDQo+ID4gwqAgKgnCoMKgwqBJZiB0aGV5IGFyZSBjcml0aWNhbCBlcnJvcnMsIG1hcmsg
aXQgY3JpdGljYWwsIGFuZA0KPiA+IGFib3J0IGRyaXZlciBsb2FkLg0KPiA+IMKgICovDQo+ID4g
LXN0YXRpYyBzdHJ1Y3QgYWNwaV9ibGFja2xpc3RfaXRlbSBhY3BpX2JsYWNrbGlzdFtdIF9faW5p
dGRhdGEgPSB7DQo+ID4gK3N0YXRpYyBzdHJ1Y3QgYWNwaV9vZW1saXN0IGFjcGlfYmxhY2tsaXN0
W10gX19pbml0ZGF0YSA9IHsNCj4gDQo+IEFsbCB0aGF0IHdhc3RlZCBlbmVyZ3kgdG8gdHJ5IHRv
IGV4cGxhaW4gdG8geW91IHRoYXQgIm9lbWxpc3QiIGlzDQo+IHdyb25nIGFuZCB0aGF0IHdob2xl
IHJlbmFtZSBpcyBwb2ludGxlc3MsIHdlbnQgZm9yIG5vdGhpbmcuDQo+DQo+IFNvIE5BSy4NCg0K
V2VsbCwgd2UgZGlkIHRhbGsgYSBsb3QgYWJvdXQgeW91ciBzdWdnZXN0ZWQgbmFtZSwgImFjcGlf
YmxhY2tsaXN0IiwNCmFuZCBJIGV4cGxhaW5lZCB0aGF0IGl0IGRpZCBub3Qgd29yayBzaW5jZSBp
dCdkIGJlIHVzZWQgZm9yIGJvdGggYmxhY2sNCmFuZCB3aGl0ZS1saXN0LiAgV2UndmUgYWdyZWVk
IG9uIHRoYXQuDQoNCllvdSB0aGVuIHN1Z2dlc3RlZCBpdCdzICJwbGF0Zm9ybSIsIG5vdCAiT0VN
Ii4gIFNpbmNlIHRoaXMgaXMgYW4gQUNQSQ0Kc3RydWN0dXJlIGRlZmluZWQgaW4gImFjcGkuaCIs
IGl0cyB0ZXJtaW5vbG9neSBnZW5lcmFsbHkgZm9sbG93cyBBQ1BJDQpzcGVjLCB3aGljaCBJIGRp
ZC4NCg0KSSB1bmRlcnN0YW5kIHRoYXQgeW91IGZlZWwgc3Ryb25nbHkgYWdhaW5zdCAiT0VNIiAo
c29ycnkgYWJvdXQgdGhhdCkuIA0KSG93IGFib3V0ICJhY3BpX3BsYXRmb3JtX2xpc3QiPyAgRG9l
cyBpdCB3b3JrIGZvciB5b3U/DQoNClRoYW5rcywNCi1Ub3NoaQ0KDQo=
