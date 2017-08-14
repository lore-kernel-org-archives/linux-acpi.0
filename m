From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Mon, 14 Aug 2017 16:48:57 +0000
Message-ID: <1502728754.2042.139.camel@hpe.com>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
         <20170803215753.30553-5-toshi.kani@hpe.com>
         <20170804040525.GE12082@nazgul.tnic> <1501879964.2042.117.camel@hpe.com>
         <20170805051615.GC23214@nazgul.tnic> <1502128177.2042.131.camel@hpe.com>
         <20170811090414.GB9432@nazgul.tnic> <1502725671.2042.137.camel@hpe.com>
         <20170814162436.lta5xm742hh6g7yk@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814162436.lta5xm742hh6g7yk@pd.tnic>
Content-Language: en-US
Content-ID: <FFF1FB8FDEB51140BF37B814002B366D@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gTW9uLCAyMDE3LTA4LTE0IGF0IDE4OjI0ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDE0LCAyMDE3IGF0IDAzOjU3OjM1UE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gSG1tLi4uIFNvcnJ5LCBJIGZhaWxlZCB0byBzZWUgaG93IHlvdXIg
cGF0Y2hzZXQgc29sdmVkIGl0LsKgwqBXb3VsZA0KPiA+IHlvdSBtaW5kIHRvwqBleHBsYWluIGhv
dyBpdCBpcyBkb25lPw0KPiANCj4gK3N0YXRpYyBpbnQgX19pbml0IGdoZXNfZWRhY19yZWdpc3Rl
cih2b2lkKQ0KPiDCoHsNCj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGdoZXNfZWRhY19wdnQgKnB2
dCA9IGdoZXNfcHZ0Ow0KPiANCj4gT25seSBvbmUgbG9jYWwgZ2hlc19wdnQgc3RydWN0dXJlLg0K
PiANCj4gQW5kIHlvdSBoYW5kbGUgbXVsdGlwbGUgY2FsbHMgaW50byBnaGVzX2VkYWNfcmVnaXN0
ZXIoKSBieSBleGl0aW5nDQo+IGFsbCB0aG9zZSB3aGljaCBhcmUgbm90IHRoZSBmaXJzdCBvbmUg
YXMgdGhlIGZpcnN0IG9uZSBhbHJlYWR5IGRpZA0KPiBhbGwgdGhlIGluaXQuDQoNClJpZ2h0LCBi
dXQgdGhlIGlzc3VlIGlzIGhvdyBbZ2hlc19lZGFjX11yZXBvcnRfbWVtX2Vycm9yKCkgcHJvdGVj
dHMNCmZyb20gcG9zc2libGUgY29uY3VycmVudCBjYWxscyBmcm9tIG11bHRpcGxlIEdIRVMgc291
cmNlcyB3aGVuIHRoZXJlIGlzDQpvbmx5IGEgc2luZ2xlIG1jaS4NCg0KVGhhbmtzLA0KLVRvc2hp
DQog
