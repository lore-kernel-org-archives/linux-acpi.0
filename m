From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Wed, 16 Aug 2017 15:26:04 +0000
Message-ID: <1502896578.2042.155.camel@hpe.com>
References: <1502732561.2042.141.camel@hpe.com>
         <20170814180526.wtfjzgc6uye2qtx6@pd.tnic>
         <1502734083.2042.143.camel@hpe.com>
         <20170814183551.sgk2i7lxpmpyodhv@pd.tnic>
         <1502736750.2042.145.camel@hpe.com>
         <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
         <1502741290.2042.147.camel@hpe.com>
         <20170814203942.6t3mrq3hc324blab@pd.tnic>
         <1502810766.2042.149.camel@hpe.com>
         <20170815154815.wy3dqwb4yi3feahg@intel.com>
         <20170816082931.p6rpvtlxwt5nccxr@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816082931.p6rpvtlxwt5nccxr@pd.tnic>
Content-Language: en-US
Content-ID: <F06F8D2D8FF5724EA71631F69EF3B0FA@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "tony.luck@intel.com" <tony.luck@intel.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "bp@alien8.de" <bp@alien8.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gV2VkLCAyMDE3LTA4LTE2IGF0IDEwOjI5ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFR1ZSwgQXVnIDE1LCAyMDE3IGF0IDA4OjQ4OjE2QU0gLTA3MDAsIEx1Y2ssIFRvbnkg
d3JvdGU6DQo+ID4gV29uJ3QgdGhlIHVzZXIgc2VlIGFsbCB0aGVpciBESU1NcyByZXBvcnRlZCBm
b3IgZWFjaCBtZW1vcnkNCj4gPiBjb250cm9sbGVyDQo+ID4gdW5kZXIgL3N5cy9kZXZpY2VzL3N5
c3RlbS9lZGFjL21jL21jKi9kaW1tKiA/DQo+ID4gDQo+ID4gVGhhdCBzb3VuZHMgY29uZnVzaW5n
Lg0KPiANCj4gUmlnaHQsIGFuZCBhZGRpbmcgdGhlIGxvY2tpbmcgd2FzIHJlYWxseSBlYXN5LiBJ
ZiBvbmx5IHBlb3BsZSB3b3VsZA0KPiBkZWJhdGUgbGVzcyBhbmQgYWN0dWFsbHkgdHJ5IHRvIGRv
IHdoYXQgdGhleSdyZSBiZWluZyBhZHZpc2VkIHRvLg0KPiBCdXQgbm90IHJlYWxseTogaWYgeW91
IHdhbm5hIGhhdmUgc29tZXRoaW5nIGRvbmUsIHlvdSBoYXZlIHRvIGRvIGl0DQo+IHlvdXJzZWxm
Lg0KDQpTb3JyeSwgYnV0IEkgZGlkIG5vdCBhZ3JlZSBvbiBhbGxvd2luZyBjb25jdXJyZW50IGFj
Y2Vzc2VzIHRvIG1jaS4uLg0KDQrCoC8qIE1lbW9yeSBEZXZpY2UgLSBUeXBlIDE3IG9mIFNNQklP
UyBzcGVjICovDQo+IMKgc3RydWN0IG1lbWRldl9kbWlfZW50cnkgew0KPiBAQCAtMTY5LDE0ICsx
NzMsMTEgQEAgdm9pZCBnaGVzX2VkYWNfcmVwb3J0X21lbV9lcnJvcihzdHJ1Y3QgZ2hlcw0KPiAq
Z2hlcywgaW50IHNldiwNCj4gwqAJZW51bSBod19ldmVudF9tY19lcnJfdHlwZSB0eXBlOw0KPiDC
oAlzdHJ1Y3QgZWRhY19yYXdfZXJyb3JfZGVzYyAqZTsNCj4gwqAJc3RydWN0IG1lbV9jdGxfaW5m
byAqbWNpOw0KPiAtCXN0cnVjdCBnaGVzX2VkYWNfcHZ0ICpwdnQgPSBOVUxMOw0KPiArCXN0cnVj
dCBnaGVzX2VkYWNfcHZ0ICpwdnQgPSBnaGVzX3B2dDsNCj4gKwl1bnNpZ25lZCBsb25nIGZsYWdz
Ow0KPiDCoAljaGFyICpwOw0KPiDCoAl1OCBncmFpbl9iaXRzOw0KDQpJIGJlbGlldmUgeW91IG5v
dyBuZWVkIHRvIHByb3RlY3QgZnJvbSBhIHJhY2UgY29uZGl0aW9uIHRoYXQgYSBzaW5nbGUNCm1j
aSBhbmQgcHZ0IGNhbiBiZSBpbml0aWFsaXplZCAvIGNvbnN1bWVkIGZyb20gbXVsdGlwbGUgdGhy
ZWFkcy4gIFRoaXMNCnByb3RlY3Rpb24gaXMgbWlzc2luZyBpbiB5b3VyIHBhdGNoLg0KDQpUaGFu
a3MsDQotVG9zaGkNCg==
