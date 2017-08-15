From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Tue, 15 Aug 2017 16:19:50 +0000
Message-ID: <1502813405.2042.153.camel@hpe.com>
References: <20170814170552.j3lhzvnwlpz75y4g@pd.tnic>
         <1502732561.2042.141.camel@hpe.com>
         <20170814180526.wtfjzgc6uye2qtx6@pd.tnic>
         <1502734083.2042.143.camel@hpe.com>
         <20170814183551.sgk2i7lxpmpyodhv@pd.tnic>
         <1502736750.2042.145.camel@hpe.com>
         <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
         <1502741290.2042.147.camel@hpe.com>
         <20170814203942.6t3mrq3hc324blab@pd.tnic>
         <1502810766.2042.149.camel@hpe.com>
         <20170815155000.d57hwki5jbixjuj6@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3427.houston.hpe.com ([15.241.140.73]:40090 "EHLO
        g4t3427.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbdHOQTz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Aug 2017 12:19:55 -0400
In-Reply-To: <20170815155000.d57hwki5jbixjuj6@pd.tnic>
Content-Language: en-US
Content-ID: <33DFDD5BF152414397A3860B5E1D21D8@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

T24gVHVlLCAyMDE3LTA4LTE1IGF0IDE3OjUwICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFR1ZSwgQXVnIDE1LCAyMDE3IGF0IDAzOjM1OjUxUE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gZ2hlc19lZGFjIGluc3RhbnRpYXRlcyBhbiBtY2kgYXMgYSBwc2V1
ZG8gZGV2aWNlIHJlcHJlc2VudGluZyBhDQo+ID4gR0hFUyBlcnJvciBzb3VyY2UuwqDCoEVhY2gg
ZXJyb3Igc291cmNlIGFzc29jaWF0ZXMgd2l0aCBhbGwgRElNTXMsDQo+ID4gYW5kIG1heSByZXBv
cnQgZXJyb3JzIGluZGVwZW5kZW50bHkuwqDCoEFzIGdoZXNfZWRhYyBpcyBhbiBHSEVTDQo+ID4g
ZXJyb3ItcmVwb3J0aW5nIHdyYXBwZXIgdG8gZWRhYywgdGhpcyBhYnN0cmFjdGlvbiBtYWtlcyBz
ZW5zZS4NCj4gDQo+IEJ1bGxzaGl0Lg0KPiANCj4gQW4gTUNJIGlzIGEgbWVtb3J5IGNvbnRyb2xs
ZXIgZGVzY3JpcHRvci4gVGhhdCBkb2Vzbid0IGZpdCB0aGUgR0hFUw0KPiBwbGF0Zm9ybSBkZXZp
Y2VzIHRoYXQgZ2V0IHByb2JlZC4gR0hFUyBwbGF0Zm9ybSBkZXZpY2UgIT0gTUNJLiBIb3cNCj4g
bWFueSB0aW1lcyBkbyBJIG5lZWQgdG8gc2F5IHRoaXMgZm9yIGl0IHRvIGdldCB0aHJvdWdoIHRv
IHlvdT8NCg0KUmlnaHQsIGJ1dCBpdCBoYXMgdG8gYmUgYSAicHNldWRvIiBkZXZpY2UgZm9yIGdo
ZXNfZWRhYy4gIFRoZXJlIGlzIG5vDQptZW1vcnkgY29udHJvbGxlciBpbmZvIGF2YWlsYWJsZS4g
IEEgc2luZ2xlIG1jaSBkb2VzIG5vdCBtYWtlIGl0IGEgcmVhbA0KbWVtb3J5IGNvbnRyb2xsZXIs
IGVpdGhlci4NCg0KPiA+IEkgZG8gbm90IHNlZSBhIHByb2JsZW0gaW4gaGF2aW5nIGNvdW50ZXJz
IGZvciBlYWNoIEdIRVMgZXJyb3INCj4gPiBzb3VyY2UuDQo+IA0KPiBBbmQgdGhlIGVycm9yIGNv
dW50ZXJzIG9mIHRoYXQgInNpbXVsYXRlZCIgbWNpIGdldCBpbmNyZW1lbnRlZA0KPiBkZXBlbmRp
bmcgb24gd2hpY2ggcG9pbnRlciBnZXRzIHBhc3NlZCBpbiBmcm9tIEdIRVM/IE1vcmUgYnVsbHNo
aXQuDQo+DQo+ID4gVGhpcyBpcyBqdXN0IHN0YXRpc3RpY3MgaW5mbywgYW5kIGdoZXNfZWRhYyBk
b2VzIG5vdCBleHBlY3QgYW55IE9TDQo+ID4gYWN0aW9uIGZyb20gdGhlIGNvdW50ZXJzLg0KPiAN
Cj4gU28gbGV0IG1lIGtub3cgaWYgeW91IGRvbid0IHdhbnQgdG8gZG8gaXQgYW5kIHJhdGhlciB3
b3VsZCBwcmVmZXIgdG8NCj4gcG9pbnRsZXNzbHkgZGViYXRlLiBJIGNlcnRhaW5seSBkb24ndCB3
YW50IHRvIHdhc3RlIG15IHRpbWUgZGViYXRpbmcuDQoNClllcywgZ2hlc19lZGFjIHJlZmFjdG9y
aW5nIGxpa2UgdGhpcyBzaG91bGQgYmUgY29uc2lkZXJlZCBhIHNlcGFyYXRlDQppdGVtLiAgTXkg
cGF0Y2hzZXQgaXMgYWltZWQgdG8gaW50cm9kdWNlIGEgcGxhdGZvcm0tY2hlY2sgdG8gYXR0YWNo
DQpnaGVzX2VkYWMgb24gc3VwcG9ydGVkIHBsYXRmb3Jtcy4NCg0KVGhhbmtzLA0KLVRvc2hpDQoN
Cg==
