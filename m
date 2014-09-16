From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v7 1/2] Mailbox: Add support for Platform Communication
 Channel
Date: Tue, 16 Sep 2014 04:38:25 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802671AF0@SHSMSX101.ccr.corp.intel.com>
References: <1410369619-2570-1-git-send-email-ashwin.chaugule@linaro.org>
	<1410369619-2570-2-git-send-email-ashwin.chaugule@linaro.org>
	<CAJ5Y-eYNqV_J2q_HJkXvaw_9QfezZ1AZBB+rQkaLLwMnUH_WBA@mail.gmail.com>
	<20140913155734.GC7960@sirena.org.uk>
 <CAJ5Y-eYg5VUTKdgVHBQvdCUtQSqdxAszetxLc-KTf5MfLN=6eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12656 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbaIPEi1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Sep 2014 00:38:27 -0400
In-Reply-To: <CAJ5Y-eYg5VUTKdgVHBQvdCUtQSqdxAszetxLc-KTf5MfLN=6eQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>

SGksIEFzaHdpbg0KDQo+IEZyb206IEFzaHdpbiBDaGF1Z3VsZSBbbWFpbHRvOmFzaHdpbi5jaGF1
Z3VsZUBsaW5hcm8ub3JnXQ0KPiBTZW50OiBTdW5kYXksIFNlcHRlbWJlciAxNCwgMjAxNCA2OjA1
IEFNDQo+IA0KPiBIaSBNYXJrLA0KPiANCj4gT24gMTMgU2VwdGVtYmVyIDIwMTQgMTE6NTcsIE1h
cmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gT24gRnJpLCBTZXAgMTIs
IDIwMTQgYXQgMDk6MDg6MDhBTSAtMDQwMCwgQXNod2luIENoYXVndWxlIHdyb3RlOg0KPiA+PiBP
biAxMCBTZXB0ZW1iZXIgMjAxNCAxMzoyMCwgQXNod2luIENoYXVndWxlIDxhc2h3aW4uY2hhdWd1
bGVAbGluYXJvLm9yZz4gd3JvdGU6DQo+ID4NCj4gPj4gSG93IGRvZXMgdGhpcyB2ZXJzaW9uIGxv
b2s/IElmIHRoZXJlIGFyZSBubyBtb3JlIGNoYW5nZXMsIHBsZWFzZSBsZXQNCj4gPj4gbWUga25v
dyB3aGljaCB0cmVlIHRoaXMgY2FuIGJlIHBpY2tlZCBieSBhbmQgSSBjYW4gc2VuZCBhIHB1bGwg
cmVxdWVzdA0KPiA+PiBpZiB0aGF0IGlzIHByZWZlcnJlZCBmb3IgdGhpcyBzaW5nbGUgcGF0Y2gu
DQo+ID4NCj4gPiBQbGVhc2UgYWxsb3cgYSByZWFzb25hYmxlIHRpbWUgZm9yIHJldmlldyAtIHlv
dSdyZSBuYWdnaW5nIGFmdGVyIHR3bw0KPiA+IGRheXMsIHRoaXMgaXMgdW5yZWFzb25hYmxlIGZv
ciBzb21ldGhpbmcgdGhhdCBpc24ndCBzdXBlciB1cmdlbnQuICBUd28NCj4gPiB3ZWVrcyB3b3Vs
ZCBiZSBtb3JlIHJlYXNvbmFibGUuICBBcyB0aGluZ3Mgc3RhbmQgeW91J3JlIGFkZGluZyB0byB0
aGUNCj4gPiBtYWlsIHZvbHVtZSBhbmQgc29tZSBwZW9wbGUgd2lsbCBhY3RpdmVseSBkZWxheSBs
b29raW5nIGF0IHRoaW5ncyBpbg0KPiA+IG9yZGVyIHRvIGF2b2lkIGVuY291cmFnaW5nIHN1Y2gg
YmVoYXZpb3VyLg0KPiANCj4gSSBhcG9sb2dpemUgaWYgaXQgc2VlbXMgdGhhdCB3YXkuIEkgdmVy
eSBtdWNoIGFwcHJlY2lhdGUgdGhlIGhlbHAgSSd2ZQ0KPiByZWNlaXZlZCBzbyBmYXIuIEknZCBz
ZW50IFY2IDkgZGF5cyBhZ28gYW5kIG9ubHkgTHYgaGFkIGZlZWRiYWNrDQo+IGFyb3VuZCBjb3Nt
ZXRpYyBjaGFuZ2VzLiBHaXZlbiB0aGUgc2ltcGxpY2l0eSBvZiB0aGlzIHBhdGNoIGFuZCBhbGwN
Cj4gdGhlIHByZXZpb3VzIHN1Z2dlc3Rpb25zLCBpdCBzZWVtZWQgbGlrZSB3ZSdyZSBuZWFybHkg
ZG9uZSB3aXRoIHRoZQ0KPiByZXZpZXdzLiBJIHVuZGVyc3RhbmQgeW91ciBwb2ludCB0aG91Z2gg
YW5kIGxvb2sgZm9yd2FyZCB0byBzZWVpbmcNCj4gdGhpcyBwYXRjaCBwcm9ncmVzcy4NCg0KSXQg
bG9va3MgdGhpcyBsaW5lIGlzIHN0aWxsIHdyb25nOg0KKwlyZXR1cm4gQUNQSV9TVUNDRVNTKHN0
YXR1cykgPyAtRUlOVkFMIDogMDsNCllvdSBtYXkgbmVlZCB0byBydW4gYSB0ZXN0IHRvIHZhbGlk
YXRlIHRoZSByZXZpc2VkIHBhdGNoLg0KDQpUaGFua3MgYW5kIGJlc3QgcmVnYXJkcw0KLUx2DQo=
