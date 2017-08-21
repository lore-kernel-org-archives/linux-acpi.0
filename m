From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v3 1/5] ACPI / blacklist: add acpi_match_platform_list()
Date: Mon, 21 Aug 2017 17:23:37 +0000
Message-ID: <1503335626.2042.165.camel@hpe.com>
References: <20170818194644.14538-1-toshi.kani@hpe.com>
         <20170818194644.14538-2-toshi.kani@hpe.com>
         <20170821112657.hrtjoeagxhc67rrr@pd.tnic>
         <1503333107.2042.163.camel@hpe.com>
         <20170821170415.kttnqiwj2fkntsc7@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:43112 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753927AbdHURY1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Aug 2017 13:24:27 -0400
In-Reply-To: <20170821170415.kttnqiwj2fkntsc7@pd.tnic>
Content-Language: en-US
Content-ID: <1AFD20AE55016A40A56A15FA9B076B89@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

T24gTW9uLCAyMDE3LTA4LTIxIGF0IDE5OjA0ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDIxLCAyMDE3IGF0IDA0OjQxOjM4UE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gUHV0dGluZyB0byBhIHNpbmdsZSBsaW5lIGxlYWRzIHRvICJsaW5l
IG92ZXIgODAgY2hhcmFjdGVycyIgd2FybmluZw0KPiA+IGZyb20gY2hlY2twYXRjaC5wbC7CoMKg
V291bGQgeW91IHN0aWxsIGFkdmljZSB0byBkbyB0aGF0Pw0KPiANCj4gWWVzLCB0aGUgODAgY29s
cyBydWxlIGlzIG5vdCBhIGhhcmQgb25lLiBSYXRoZXIsIGl0IHNob3VsZCBiZQ0KPiBvdmVycmlk
ZGVuIGJ5IGh1bWFuIGdvb2QganVkZ2VtZW50LCBsaWtlIG1ha2luZyB0aGUgY29kZSBtb3JlDQo+
IHJlYWRhYmxlLg0KDQpJIHNlZS4gIEkgd2lsbCBtYWtlIHRoZXNlIGNoYW5nZXMuICAoSXQncyBy
ZWFsbHkgcGVyc29uYWwgcHJlZmVyZW5jZSwNCmJ1dCBsb25nIGxpbmVzIG9mIGlmLWNvbmRpdGlv
bnMgYXJlIG5vdCBzbyBlYXN5IHRvIHJlYWQgdG8gbXkgZXllcywNCnRob3VnaC4pDQoNCj4gPiBz
dHJuY21wKCkgaXMgZmluZSB3aXRob3V0IHRoZXNlLCBidXQgaXQnZCBiZSBwcnVkZW50IGluIGNh
c2UNCj4gPiBzb21lb25lIGRlY2lkZXMgdG8gcHJpbnQgdGhlc2Ugc3RyaW5ncyB3aXRoIHByaW50
aygpLsKgwqBXaWxsIGRvLg0KPiANCj4gU29tZW9uZSBkb2VzIGFscmVhZHkgdXNlIHRoZW0gaW4g
cHJpbnRrKCk6DQo+IA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJfZXJyKFBS
RUZJWCAiVmVuZG9yIFwiJTYuNnNcIiBTeXN0ZW0gXCIlOC44c1wiDQo+IFJldmlzaW9uIDB4JXgg
aGFzIGEga25vd24gQUNQSSBCSU9TIHByb2JsZW0uXG4iLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhY3BpX2JsYWNrbGlzdFtpXS5vZW1faWQsDQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFjcGlfYmxhY2tsaXN0
W2ldLm9lbV90YWJsZV9pZCwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgYWNwaV9ibGFja2xpc3RbaV0ub2VtX3JldmlzaW9uKTsNCg0KT2gsIHlvdSBhcmUg
cmlnaHQgYWJvdXQgdGhhdCENCg0KPiA+ICdkYXRhJyBoZXJlIGlzIHByaXZhdGUgdG8gdGhlIGNh
bGxlci7CoMKgU28sIEkgZG8gbm90IHRoaW5rIHdlIG5lZWQNCj4gPiB0byBkZWZpbmUgdGhlIGJp
dHMuwqDCoFNoYWxsIEkgY2hhbmdlIHRoZSBuYW1lIHRvICdkcml2ZXJfZGF0YScgdG8NCj4gPiBt
YWtlIGl0IG1vcmUgZXhwbGljaXQ/DQo+IA0KPiBZb3UgY2hhbmdlZCBpdCB0byAnZGF0YScuIEl0
IHdhcyBhIHUzMi11c2VkLWFzLWJvb2xlYW4NCj4gaXNfY3JpdGljYWxfZXJyb3IgYmVmb3JlLg0K
PiANCj4gU28geW91IGNhbiBqdXN0IGFzIHdlbGwgbWFrZSBpdCBpbnRvIGZsYWdzIGFuZCBwZW9w
bGUgY2FuIGV4dGVuZA0KPiB0aG9zZSBmbGFncyBpZiBuZWVkZWQuIEEgZmxhZyBiaXQgc2hvdWxk
IGJlIGVub3VnaCBpbiBtb3N0IGNhc2VzDQo+IGFueXdheS4gSWYgdGhleSByZWFsbHkgbmVlZCBk
cml2ZXJfZGF0YSwgdGhlbiB0aGV5IGNhbiBhZGQgYSB2b2lkICoNCj4gbWVtYmVyLg0KDQpIbW0u
LiBJbiBwYXRjaCAyLCBpbnRlbF9wc3RhdGVfcGxhdGZvcm1fcHdyX21nbXRfZXhpc3RzKCkgdXNl
cyB0aGlzDQpmaWVsZCBmb3IgUFNTIGFuZCBQQ0MsIHdoaWNoIGFyZSBlbnVtIHZhbHVlcy4gIEkg
dGhpbmsgd2Ugc2hvdWxkIGFsbG93DQpkcml2ZXJzIHRvIHNldCBhbnkgdmFsdWVzIGhlcmUuICBJ
IGFncmVlIHRoYXQgaXQgbWF5IG5lZWQgdG8gYmUgdm9pZCAqDQppZiB3ZSBhbHNvIGFsbG93IGRy
aXZlcnMgdG8gc2V0IGEgcG9pbnRlciBoZXJlLg0KDQpUaGFua3MsDQotVG9zaGkNCg==
