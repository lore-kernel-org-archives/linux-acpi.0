From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Mon, 14 Aug 2017 15:57:35 +0000
Message-ID: <1502725671.2042.137.camel@hpe.com>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
         <20170803215753.30553-5-toshi.kani@hpe.com>
         <20170804040525.GE12082@nazgul.tnic> <1501879964.2042.117.camel@hpe.com>
         <20170805051615.GC23214@nazgul.tnic> <1502128177.2042.131.camel@hpe.com>
         <20170811090414.GB9432@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170811090414.GB9432@nazgul.tnic>
Content-Language: en-US
Content-ID: <ABE9FB6CBEAA1F41B020433920A9D183@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gRnJpLCAyMDE3LTA4LTExIGF0IDExOjA0ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDA3LCAyMDE3IGF0IDA1OjU5OjE1UE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gSSB0aGluayB3ZSBzaG91bGQga2VlcCB0aGUgY3VycmVudCBzY2hl
bWUsIHdoaWNoIHJlZ2lzdGVycyBhbiBtY2kNCj4gPiBmb3INCj4gDQo+IE5vIHdlIHNob3VsZG4n
dC4NCj4gDQo+ID4gZWFjaCBHSEVTIGVudHJ5LsKgwqBnaGVzX2VkYWNfcmVwb3J0X21lbV9lcnJv
cigpIGV4cGVjdHMgdGhhdCBlcnJvci0NCj4gPiByZXBvcnRpbmcgaXMgc2VyaWFsaXplZCBwZXIg
YSBHSEVTIGVudHJ5LsKgwqBTaGFyaW5nIGEgc2luZ2xlIG1jaQ0KPiA+IGFtb25nIGFsbCBHSEVT
IGVudHJpZXMgLyBlcnJvciBpbnRlcmZhY2VzIG1pZ2h0IGxlYWQgdG8gYSByYWNlDQo+ID4gY29u
ZGl0aW9uLg0KPiANCj4gU2VlIGhvdyBJIHNvbHZlZCBpdCBpbiBteSBwYXRjaHNldCBhbmQgZmVl
bCBmcmVlIHRvIHJldXNlIGl0Lg0KDQpIbW0uLi4gU29ycnksIEkgZmFpbGVkIHRvIHNlZSBob3cg
eW91ciBwYXRjaHNldCBzb2x2ZWQgaXQuICBXb3VsZCB5b3UNCm1pbmQgdG/CoGV4cGxhaW4gaG93
IGl0IGlzIGRvbmU/DQoNClRoYW5rcyENCi1Ub3NoaQ0K
