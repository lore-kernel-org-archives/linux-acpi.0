From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Tue, 15 Aug 2017 15:35:51 +0000
Message-ID: <1502810766.2042.149.camel@hpe.com>
References: <20170814162436.lta5xm742hh6g7yk@pd.tnic>
         <1502728754.2042.139.camel@hpe.com>
         <20170814170552.j3lhzvnwlpz75y4g@pd.tnic>
         <1502732561.2042.141.camel@hpe.com>
         <20170814180526.wtfjzgc6uye2qtx6@pd.tnic>
         <1502734083.2042.143.camel@hpe.com>
         <20170814183551.sgk2i7lxpmpyodhv@pd.tnic>
         <1502736750.2042.145.camel@hpe.com>
         <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
         <1502741290.2042.147.camel@hpe.com>
         <20170814203942.6t3mrq3hc324blab@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814203942.6t3mrq3hc324blab@pd.tnic>
Content-Language: en-US
Content-ID: <5CECFBCC3EA51C47B23091B714FA3A4F@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gTW9uLCAyMDE3LTA4LTE0IGF0IDIyOjM5ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDE0LCAyMDE3IGF0IDA4OjE3OjU0UE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gSSB0aGluayB0aGUgY3VycmVudCBjb2RlIGRlc2lnbiBvZiBhbGxv
Y2F0aW5nIG1jaSAmIGdoZXNfZWRhY19wdnQNCj4gPiBmb3IgZWFjaCBHSEVTIHNvdXJjZSBlbnRy
eSBtYWtlcyBzZW5zZS4NCj4gDQo+IEFuZCBJIGRvbid0Lg0KPiANCj4gPiBlZGFjX3Jhd19tY19o
YW5kbGVfZXJyb3IoKSBhbHNvIGhhcyB0aGUgc2FtZSBleHBlY3RhdGlvbiB0aGF0IHRoZQ0KPiA+
IGNhbGwgaXMgc2VyaWFsaXplZCBwZXIgbWNpLg0KPiANCj4gVGhlcmUncyBubyBzdWNoIHRoaW5n
IGFzICJwZXIgbWNpIiBpZiB0aGUgZHJpdmVyIHNjYW5zICphbGwgRElNTXMqDQo+IHBlciByZWdp
c3RlciBjYWxsLiBJZiBpdCBkb2VzIGl0IHRoaXMgd2F5LCB0aGVuIGl0IGlzIG9ubHkgb25lIG1j
aS4NCg0KZ2hlc19lZGFjIGluc3RhbnRpYXRlcyBhbiBtY2kgYXMgYSBwc2V1ZG8gZGV2aWNlIHJl
cHJlc2VudGluZyBhIEdIRVMNCmVycm9yIHNvdXJjZS4gIEVhY2ggZXJyb3Igc291cmNlIGFzc29j
aWF0ZXMgd2l0aCBhbGwgRElNTXMsIGFuZCBtYXkNCnJlcG9ydCBlcnJvcnMgaW5kZXBlbmRlbnRs
eS4gIEFzIGdoZXNfZWRhYyBpcyBhbiBHSEVTIGVycm9yLXJlcG9ydGluZw0Kd3JhcHBlciB0byBl
ZGFjLCB0aGlzIGFic3RyYWN0aW9uIG1ha2VzIHNlbnNlLg0KDQo+IEl0IGlzIGFjdHVhbGx5IHdy
b25nIHJpZ2h0IG5vdyBiZWNhdXNlIGlmIHlvdSByZWdpc3RlciBtb3JlIHRoYW4gb25lDQo+IG1j
aSBhbmQgeW91IGRvIGVkYWNfaW5jX2NlX2Vycm9yKCkvZWRhY19pbmNfdWVfZXJyb3IoKSwgcG90
ZW50aWFsbHkNCj4gZGlmZmVyZW50IGNvdW50ZXJzIGdldCBpbmNyZW1lbnRlZCBmb3IgdGhlIHNh
bWUgZXJyb3JzLiBFeGFjdGx5DQo+IGJlY2F1c2UgZWFjaCBpbnN0YW5jZSByZWdpc3RlcmVkIGlz
ICp3cm9uZ2x5KiByZXNwb25zaWJsZSBmb3IgYWxsDQo+IERJTU1zIG9uIHRoZSBzeXN0ZW0uDQoN
CkkgZG8gbm90IHNlZSBhIHByb2JsZW0gaW4gaGF2aW5nIGNvdW50ZXJzIGZvciBlYWNoIEdIRVMg
ZXJyb3Igc291cmNlLiANClRoaXMgaXMganVzdCBzdGF0aXN0aWNzIGluZm8sIGFuZCBnaGVzX2Vk
YWMgZG9lcyBub3QgZXhwZWN0IGFueSBPUw0KYWN0aW9uIGZyb20gdGhlIGNvdW50ZXJzLg0KDQo+
IFNvIHlvdSBlaXRoZXIgbmVlZCB0byBwYXJ0aXRpb24gdGhlIERJTU1zIHBlciBtY2kgKHdoaWNo
IEkgY2FuJ3QNCj4gaW1hZ2luZSBob3cgaXQgd291bGQgd29yaykgb3IgaW50cm9kdWNlIGxvY2tp
bmcgd2hlbiBpbmNyZW1lbnRpbmcgdGhlDQo+IG1jaS0+Y291bnRlcnMuDQoNCkkgZG8gbm90IHRo
aW5rIGNoYW5naW5nIHRoZSBjYWxsaW5nIGNvbnZlbnRpb24gdG8gZWRhYyBsaWJyYXJ5DQppbnRl
cmZhY2VzIGlzIGEgZ29vZCBpZGVhIGZvciBhIHNwZWNpYWwgY2FzZSBsaWtlIGdoZXNfZWRhYy4g
IFN1Y2gNCmNoYW5nZXMgY2FuIGJlIGEgYnVyZGVuIGZvciB1cyBnb2luZyBmb3J3YXJkLiAgSSB0
aGluayBnaGVzX2VkYWMganVzdA0KbmVlZHMgdG8gd29yayB3aXRoIHRoZSBjdXJyZW50IHByZXJl
cXVpc2l0ZS4NCg0KVXNlciBhcHBzIGxpa2UgcmFzLW1jLWN0bCB3b3JrcyBhcyBleHBlY3RlZCBm
b3IgYSBnaXZlbiAobm90LXNvLWdyZWF0KQ0KRElNTSBpbmZvIGZyb20gU01CSU9TIGFzIHdlbGwu
ICBJIGRvIG5vdCBzZWUgYSBwcm9iZWxtIGZyb20gdXNlcg0KcGVyc3BlY3RpdmUsIGVpdGhlci4N
Cg0KVGhhbmtzLA0KLVRvc2hpDQoNCg==
