From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Mon, 14 Aug 2017 19:02:15 +0000
Message-ID: <1502736750.2042.145.camel@hpe.com>
References: <20170805051615.GC23214@nazgul.tnic>
         <1502128177.2042.131.camel@hpe.com> <20170811090414.GB9432@nazgul.tnic>
         <1502725671.2042.137.camel@hpe.com>
         <20170814162436.lta5xm742hh6g7yk@pd.tnic>
         <1502728754.2042.139.camel@hpe.com>
         <20170814170552.j3lhzvnwlpz75y4g@pd.tnic>
         <1502732561.2042.141.camel@hpe.com>
         <20170814180526.wtfjzgc6uye2qtx6@pd.tnic>
         <1502734083.2042.143.camel@hpe.com>
         <20170814183551.sgk2i7lxpmpyodhv@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814183551.sgk2i7lxpmpyodhv@pd.tnic>
Content-Language: en-US
Content-ID: <2E812CD45140D241A4BA6F6E2512E731@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gTW9uLCAyMDE3LTA4LTE0IGF0IDIwOjM1ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDE0LCAyMDE3IGF0IDA2OjE3OjQ3UE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gUmlnaHQsIGdoZXNfZWRhY19yZXBvcnRfbWVtX2Vycm9yKCkgZ2V0
cyBzZXJpYWxpemVkIHBlciBhIEdIRVMNCj4gPiBlbnRyeSwgYnV0IG5vdCBnbG9iYWxseS4NCj4g
DQo+IEdsb2JhbGx5IHdoYXQ/DQoNCkdIRVMgdjIncyBBQ0vCoGlzIG5vdCBhIGdsb2JhbCBsb2Nr
LiAgU28sIGl0IGRvZXMgbm90IGd1YXJhbnRlZSB0aGF0DQpnaGVzX2VkYWNfcmVwb3J0X21lbV9l
cnJvcigpIG5ldmVyIGdldHMgY2FsbGVkIGNvbmN1cnJlbnRseS4NCg0KPiBXaGF0IGlzIHRoZSBh
Y3R1YWwgcG90ZW50aWFsIHNjZW5hcmlvIGZvciBjb25jdXJyZW5jeSBpc3N1ZXMgeW91IHNlZT8N
Cj4gRXhhbXBsZSBwbHMuDQoNCmdoZXNfcHJvYmUoKSBzdXBwb3J0cyBtdWx0aXBsZSBzb3VyY2Vz
IGRlZmluZWQgaW4NCmFjcGlfaGVzdF9ub3RpZnlfdHlwZXMuICBTYXksIHRoZXJlIGFyZSB0d28g
ZW50cmllcyBmb3IgbWVtb3J5IGVycm9ycywNCm9uZSB3aXRoIEFDUElfSEVTVF9OT1RJRllfRVhU
RVJOQUwgYW5kIHRoZSBvdGhlciB3aXRoDQpBQ1BJX0hFU1RfTk9USUZZX1NDSS4gIFRoZXkgbWF5
IHJlcG9ydCBlcnJvcnMgaW5kZXBlbmRlbnRseS4gIFdoaWxlDQpnaGVzX2VkYWNfcmVwb3J0X21l
bV9lcnJvcigpIGlzIGJlaW5nIGNhbGxlZCBmcm9tIHRoZSBTQ0ksIGl0IGNhbiBiZQ0KY2FsbGVk
IGZyb20gdGhlIGV4dCBpbnRlcnJ1cHQgYXQgYSBzYW1lIHRpbWUuDQoNCkkgZG8gbm90IGtub3cg
aG93IGxpa2VseSB3ZSBzZWUgc3VjaCBjYXNlLCBidXQgdGhlIGNvZGUgc2hvdWxkIGJlDQp3cml0
dGVuIGFjY29yZGluZyB0byB0aGUgc3BlYy4NCg0KVGhhbmtzLA0KLVRvc2hpDQo=
