From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Mon, 7 Aug 2017 17:59:15 +0000
Message-ID: <1502128177.2042.131.camel@hpe.com>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
         <20170803215753.30553-5-toshi.kani@hpe.com>
         <20170804040525.GE12082@nazgul.tnic> <1501879964.2042.117.camel@hpe.com>
         <20170805051615.GC23214@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:38464 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdHGR7S (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2017 13:59:18 -0400
In-Reply-To: <20170805051615.GC23214@nazgul.tnic>
Content-Language: en-US
Content-ID: <260B6D54D552984C9453CA3D41346493@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>

T24gU2F0LCAyMDE3LTA4LTA1IGF0IDA3OjE2ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgQXVnIDA0LCAyMDE3IGF0IDA5OjAyOjE3UE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gR0hFUyBwbGF0Zm9ybSBkZXZpY2VzIGNvcnJlc3BvbmQgdG8gR0hF
UyBlbnRyaWVzLCB3aGljaCBkZWZpbmUNCj4gPiBmaXJtd2FyZSBpbnRlcmZhY2VzIHRvIHJlcG9y
dCBnZW5lcmljIG1lbW9yeSBlcnJvcnMgdG8gdGhlIE9TLCBzdWNoDQo+ID4gYXMgTk1JIGFuZCBT
Q0kuwqDCoFRoZXNlIGRldmljZXMgYXJlIGFzc29jaWF0ZWQgd2l0aCBhbGwgRElNTXMsIG5vdCBh
DQo+ID4gcGFydGljdWxhciBESU1NLg0KPiANCj4gQW5kPyBTdGF0aW5nIHRoZSBvYnZpb3VzIGJy
aW5ncyB5b3Ugd2hhdCBleGFjdGx5Pw0KPiANCj4gSU9XLCB5b3Ugc3RpbGwgaGF2ZW4ndCBhbnN3
ZXJlZCBteSBxdWVzdGlvbi4NCg0KU29ycnkgYWJvdXQgdGhhdC4gIExldCBtZSBjb3B5IHlvdXIg
b3JpZ2luYWwgY29tbWVudHMgdG8gbWFrZSBzdXJlIEkNCmFuc3dlciB5b3VyIHF1ZXN0aW9ucyB0
aGlzIHRpbWUuDQoNCj4gU28gdGhlIHByb2JsZW0gaXMgdGhhdCBnaGVzX2VkYWNfcmVnaXN0ZXIo
KSBnZXRzIGNhbGxlZCBtdWx0aXBsZQ0KPiB0aW1lcyBkZXBlbmRpbmcgb24gaG93IG1hbnkgR0hF
UyBwbGF0Zm9ybSBkZXZpY2VzIGFyZSBvbiB0aGUgc3lzdGVtLg0KPiBCdXQgeWV0IHRoZXkgYWxs
IHNjYW4gKmFsbCogRElNTXMuwqANCg0KUmlnaHQsIGFuZCB0aGlzIHBhdGNoIGNoYW5nZXMgZ2hl
c19lZGFjX3JlZ2lzdGVyKCkgdG8gc2NhbiBhbGwgRElNTXMgYXQNCnRoZSBmaXJzdCB0aW1lIGFu
ZCBkbyBub3Qgc2NhbiB0aGVtIG5leHQgdGltZXMuDQoNCj4gU28gaW5zdGVhZCB5b3Ugc2hvdWxk
IHJldHVybiBpZg0KPiB0aGUgRElNTXMgaGF2ZSBiZWVuIGNvdW50ZWQgYWxyZWFkeSBhbmQgbm90
IHJlZ2lzdGVyIGEgc2Vjb25kIHRpbWUuDQo+IFdoaWNoIG1ha2VzIHRoYXQgd2hvbGUgbWMgY291
bnRpbmcga2luZGEgdXNlbGVzcy4gU28geW91IGNvdWxkIHJpcA0KPg0KdGhhdCBvdXQgdG9vLg0K
DQpPaCwgSSBzZWUuICBTbywgZ2hlc19lZGFjX3JlZ2lzdGVyKCkgc2hvdWxkIHJldHVybiBuby1v
cCBhIHNlY29uZCB0aW1lLA0KYW5kIGRvZXMgbm90IGNhbGwgZWRhY19tY19hZGRfbWMoKSB0byBy
ZWdpc3RlciB3aXRoIGEgc2VwYXJhdGUgbWNpLg0KDQpJIHRoaW5rIHdlIHNob3VsZCBrZWVwIHRo
ZSBjdXJyZW50IHNjaGVtZSwgd2hpY2ggcmVnaXN0ZXJzIGFuIG1jaSBmb3INCmVhY2ggR0hFUyBl
bnRyeS4gIGdoZXNfZWRhY19yZXBvcnRfbWVtX2Vycm9yKCkgZXhwZWN0cyB0aGF0IGVycm9yLQ0K
cmVwb3J0aW5nIGlzIHNlcmlhbGl6ZWQgcGVyIGEgR0hFUyBlbnRyeS4gIFNoYXJpbmcgYSBzaW5n
bGUgbWNpIGFtb25nDQphbGwgR0hFUyBlbnRyaWVzIC8gZXJyb3IgaW50ZXJmYWNlcyBtaWdodCBs
ZWFkIHRvIGEgcmFjZSBjb25kaXRpb24uDQoNClRoYW5rcywNCi1Ub3NoaQ0KDQo=
