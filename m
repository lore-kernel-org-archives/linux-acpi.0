From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v4 3/5] ghes_edac: add platform check to enable ghes_edac
Date: Thu, 31 Aug 2017 16:17:07 +0000
Message-ID: <1504195625.2042.179.camel@hpe.com>
References: <20170823225447.15608-1-toshi.kani@hpe.com>
         <20170823225447.15608-4-toshi.kani@hpe.com>
         <20170831105647.a7ypixekv6jybqyu@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3427.houston.hpe.com ([15.241.140.73]:33198 "EHLO
        g4t3427.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbdHaQRX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Aug 2017 12:17:23 -0400
In-Reply-To: <20170831105647.a7ypixekv6jybqyu@pd.tnic>
Content-Language: en-US
Content-ID: <9001CA75183E074EB558E88C597B0741@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

T24gVGh1LCAyMDE3LTA4LTMxIGF0IDEyOjU2ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFdlZCwgQXVnIDIzLCAyMDE3IGF0IDA0OjU0OjQ1UE0gLTA2MDAsIFRvc2hpIEthbmkg
d3JvdGU6DQogOg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jIHzCoMKg
wqAyOSArKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQs
IDI0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYyBiL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KPiA+
IGluZGV4IDhkOTA0ZGYuLjAwMzBhMDkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9lZGFjL2do
ZXNfZWRhYy5jDQo+ID4gKysrIGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQo+ID4gQEAgLTM4
LDYgKzM4LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgZ2hlc19lZGFjX3B2dCAqZ2hlc19wdnQ7DQo+ID4g
wqAgKi8NCj4gPiDCoHN0YXRpYyBERUZJTkVfU1BJTkxPQ0soZ2hlc19sb2NrKTsNCj4gPiDCoA0K
PiA+ICsvKiBTZXQgMSB0byBza2lwIHRoZSBwbGF0Zm9ybSBjaGVjayAqLw0KPiA+ICtzdGF0aWMg
Ym9vbCBfX3JlYWRfbW9zdGx5IGdoZXNfZWRhY19mb3JjZV9sb2FkOw0KPiANCj4gSXQgaXMgc3Rh
dGljIC0gImZvcmNlX2xvYWQiIGFzIGEgYm9vbCBuYW1lIGlzIGVub3VnaC4NCg0KV2lsbCBkby4N
Cg0KPiA+ICttb2R1bGVfcGFyYW1fbmFtZWQoZm9yY2VfbG9hZCwgZ2hlc19lZGFjX2ZvcmNlX2xv
YWQsIGJvb2wsIDApOw0KPiANCj4gRVJST1I6IFVzZSA0IGRpZ2l0IG9jdGFsICgwNzc3KSBub3Qg
ZGVjaW1hbCBwZXJtaXNzaW9ucw0KPiAjNTM6IEZJTEU6IGRyaXZlcnMvZWRhYy9naGVzX2VkYWMu
Yzo0MzoNCj4gK21vZHVsZV9wYXJhbV9uYW1lZChmb3JjZV9sb2FkLCBnaGVzX2VkYWNfZm9yY2Vf
bG9hZCwgYm9vbCwgMCk7DQo+IA0KPiBUaGlzIGxhc3QgcGFyYW0gaXMgQHBlcm06IHZpc2liaWxp
dHkgaW4gc3lzZnMuIFdoeSBub3QgdmlzaWJsZSBpbg0KPiBzeXNmcz8NCg0KSSBmb2xsb3dlZCBp
biB0aGUgZm9vdHN0ZXBzIG9mICdnaGVzX2Rpc2FibGUnLCB3aGljaCBpcyBhbHNvIGEga2VybmVs
DQpib290IG9wdGlvbiBhbmQgdXNlcyAwLg0KDQo+ID4gKw0KPiA+IMKgLyogTWVtb3J5IERldmlj
ZSAtIFR5cGUgMTcgb2YgU01CSU9TIHNwZWMgKi8NCj4gPiDCoHN0cnVjdCBtZW1kZXZfZG1pX2Vu
dHJ5IHsNCj4gPiDCoAl1OCB0eXBlOw0KPiA+IEBAIC00MTUsNiArNDE5LDE1IEBAIHZvaWQgZ2hl
c19lZGFjX3JlcG9ydF9tZW1fZXJyb3Ioc3RydWN0IGdoZXMNCj4gPiAqZ2hlcywgaW50IHNldiwN
Cj4gPiDCoAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZnaGVzX2xvY2ssIGZsYWdzKTsNCj4gPiDC
oH0NCj4gPiDCoA0KPiA+ICsvKg0KPiA+ICsgKiBLbm93biBzeXN0ZW1zIHRoYXQgYXJlIHNhZmUg
dG8gZW5hYmxlIHRoaXMgbW9kdWxlLg0KPiA+ICsgKiAiZ2hlc19lZGFjLmZvcmNlX2xvYWQ9MSIg
c2tpcHMgdGhpcyBjaGVjayBpZiBuZWNlc3NhcnkuDQo+IA0KPiBQdXQgdGhpcyBzZWNvbmQgc2Vu
dGVuY2Ugb3ZlciB0aGUgcGFyYW1ldGVyIGRlZmluaXRpb24uDQoNCldpbGwgZG8uDQoNClRoYW5r
cywNCi1Ub3NoaQ0K
