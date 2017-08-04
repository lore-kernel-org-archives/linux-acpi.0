From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 5/7] ghes_edac: add platform check to enable ghes_edac
Date: Fri, 4 Aug 2017 21:06:27 +0000
Message-ID: <1501880213.2042.119.camel@hpe.com>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
         <20170803215753.30553-6-toshi.kani@hpe.com>
         <20170804083137.GB15617@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:47444 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdHDVGx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Aug 2017 17:06:53 -0400
In-Reply-To: <20170804083137.GB15617@nazgul.tnic>
Content-Language: en-US
Content-ID: <3CD443D9A59481468BD0924D6C4B17D0@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

T24gRnJpLCAyMDE3LTA4LTA0IGF0IDEwOjMxICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgQXVnIDAzLCAyMDE3IGF0IDAzOjU3OjUxUE0gLTA2MDAsIFRvc2hpIEthbmkg
d3JvdGU6DQo+ID4gVGhlIGdoZXNfZWRhYyBkcml2ZXIgd2FzIGludHJvZHVjZWQgaW4gMjAxMyBb
MV0sIGJ1dCBpdCBoYXMgbm90DQo+ID4gYmVlbiBlbmFibGVkIGJ5IGFueSBkaXN0cm8geWV0LsKg
wqBUaGlzIGRyaXZlciBvYnRhaW5zIGVycm9yIGluZm8NCj4gPiBmcm9tIGZpcm13YXJlIGludGVy
ZmFjZXMsIHdoaWNoIGFyZSBub3QgcHJvcGVybHkgaW1wbGVtZW50ZWQgb24NCj4gPiBtYW55IHBs
YXRmb3JtcywgYXMgdGhlIGRyaXZlciBhbHdheXMgZW1pdHMgdGhlIG1lc3NhZ2VzIGJlbG93Og0K
PiA+IA0KPiA+IMKgVGhpcyBFREFDIGRyaXZlciByZWxpZXMgb24gQklPUyB0byBlbnVtZXJhdGUg
bWVtb3J5IGFuZCBnZXQgZXJyb3INCj4gPiByZXBvcnRzLiDCoFVuZm9ydHVuYXRlbHksIG5vdCBh
bGwgQklPU2VzIHJlZmxlY3QgdGhlIG1lbW9yeSBsYXlvdXQNCj4gPiBjb3JyZWN0bHkgwqBTbywg
dGhlIGVuZCByZXN1bHQgb2YgdXNpbmcgdGhpcyBkcml2ZXIgdmFyaWVzIGZyb20NCj4gPiB2ZW5k
b3IgdG8gdmVuZG9yIMKgSWYgeW91IGZpbmQgaW5jb3JyZWN0IHJlcG9ydHMsIHBsZWFzZSBjb250
YWN0DQo+ID4geW91ciBoYXJkd2FyZSB2ZW5kb3IgdG8gY29ycmVjdCBpdHMgQklPUy4NCj4gPiAN
Cj4gPiBUbyBnZXQgb3V0IGZyb20gdGhpcyBzaXR1YXRpb24sIGFkZCBhIHBsYXRmb3JtIGNoZWNr
IHRvIHNlbGVjdGl2ZWx5DQo+ID4gZW5hYmxlIHRoZSBkcml2ZXIgb24gdGhlIHBsYXRmb3JtcyB0
aGF0IGFyZSBrbm93biB0byBoYXZlIHByb3Blcg0KPiA+IGZpcm13YXJlIGltcGxlbWVudGF0aW9u
LsKgwqBQbGF0Zm9ybSB2ZW5kb3JzIGNhbiBhZGQgdGhlaXIgcGxhdGZvcm1zDQo+ID4gdG8gdGhl
IGxpc3Qgd2hlbiB0aGV5IHN1cHBvcnQgZ2hlc19lZGFjLg0KPiA+IA0KPiA+ICJnaGVzX2VkYWMu
YW55X29lbT0xIiBza2lwcyB0aGlzIHBsYXRmb3JtIGNoZWNrLg0KPiANCj4gVGhlcmUncyB0aGF0
IG5vbi1nZW5lcmljIE9FTSB0aGluZyBhZ2Fpbi4gTkFLIQ0KDQpIb3cgYWJvdXQgImdoZXNfZWRh
Yy5hbnlfcGxhdGZvcm0iPw0KDQpUaGFua3MsDQotVG9zaGkNCg==
