From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Tue, 18 Jul 2017 21:20:44 +0000
Message-ID: <1500412288.2042.25.camel@hpe.com>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
         <20170717215912.26070-4-toshi.kani@hpe.com>
         <20170718060007.GB8736@nazgul.tnic> <20170718080836.GB8372@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718080836.GB8372@nazgul.tnic>
Content-Language: en-US
Content-ID: <CB5035F745810242941D2BE9915CB6E3@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "tony.luck@intel.com" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gVHVlLCAyMDE3LTA3LTE4IGF0IDEwOjA4ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFR1ZSwgSnVsIDE4LCAyMDE3IGF0IDA4OjAwOjA3QU0gKzAyMDAsIEJvcmlzbGF2IFBl
dGtvdiB3cm90ZToNCj4gPiBBbmQgSSB0aGluayB3ZSBzaG91bGQgdHJ5IHRoaXMgZmlyc3Q6IGhh
dmUgdGhlIGZpcm13YXJlIGRpc2FibGUNCj4gPiBkZXRlY3Rpb24gbWV0aG9kcyBzbyB0aGF0IHRo
ZSBwbGF0Zm9ybSBkcml2ZXJzIGRvbid0IGxvYWQuDQo+IA0KPiBCdHcsIGluIGxvb2tpbmcgYXQg
dGhpcyBtb3JlLCB3aGF0IGFib3V0IHRoZSBmaXJtd2FyZS1maXJzdCB0aGluZz8NCj4gDQo+IEku
ZS4sIHRoZSBmaXJtd2FyZS1maXJzdCBkZXRlY3Rpb24gd2l0aCBhcGVpX29zY19zZXR1cCgpIGF0
IHRoZSBlbmQNCj4gb2YgZ2hlc19pbml0KCkuDQo+IA0KPiBDYW4gd2UgbWFrZSBnaGVzX2VkYWMg
bG9hZGluZyBkZXBlbmRlbnQgb24gdGhhdD8gSSBtZWFuLCB0aGF0IHdhcw0KPiAqdGhlKiBwcmVk
aWNhdGUgZm9yIGV4YWN0bHkgdGhhdCAtIHRvIGhhdmUgdGhlIGZpcm13YXJlIGxvb2sgYXQgdGhl
DQo+IGVycm9ycyBmaXJzdC4gTm8gbmVlZCBmb3IgcGxhdGZvcm0gd2hpdGVsaXN0aW5nIGFuZCBz
byBvbi4NCg0KSSBhZ3JlZSB0aGF0ICdvc2Nfc2JfYXBlaV9zdXBwb3J0X2Fja2VkJyBzaG91bGQg
YmUgY2hlY2tlZCB3aGVuDQplbmFibGluZyBnaGVzX2VkYWMuICBJIGRvIG5vdCBrbm93IHRoZSBk
ZXRhaWxzIG9mIGV4aXN0aW5nIGlzc3VlcywgYnV0DQppdCBzb3VuZHMgdW5saWtlbHkgdGhhdCB0
aGlzIHdpbGwgYWRkcmVzcyBhbGwgb2YgdGhlbSBzaW5jZSBidWdzIGNhbiBiZQ0KZXZlcnl3aGVy
ZS4gIEZvciBpbnN0YW5jZSwgZ2hlc19lZGFjIHJlbGllcyBvbiBETUkvU01CSU9TIGluZm8sIHVu
bGlrZQ0Kb3RoZXIgRURBQyBkcml2ZXJzLCB3aGljaCBjYW4gYmUgYnVnZ3kgcmVnYXJkbGVzcyBv
ZiB0aGlzIF9PU0MgaW5mby4NCg0KPiBJJ2Qgc3RpbGwgZGVjb3VwbGUgZ2hlc19lZGFjIGxvYWRp
bmcgZnJvbSBnaGVzX3Byb2JlKCkgZXZlbiB0aG91Z2gNCj4gbG9hZGluZyB0aGUgcGxhdGZvcm0g
ZHJpdmVyIHNob3VsZCd2ZSBiZWVuIGRvbmUgKmFmdGVyKiB0aGUNCj4gZmlybXdhcmUtZmlyc3Qg
ZGV0ZWN0aW9uIHJlZ2FyZGxlc3MuDQo+IA0KPiBTbyB3aGF0IHdlIGNvdWxkIGRvIGlzIG1ha2Ug
Z2hlc19lZGFjIGEgbm9ybWFsIG1vZHVsZSBhbmQgaGF2ZSB0aGUNCj4gcmVsZXZhbnQgeDg2IEVE
QUMgbW9kdWxlcyBxdWVyeSBGRiBtb2RlIGFuZCBpZiBlbmFibGVkLCBmYWlsIGxvYWRpbmcuDQoN
CkkgYWdyZWUgdGhhdCBtYWtpbmcgZ2hlc19lZGFjIGFzIGEgbm9ybWFsIG1vZHVsZSBpcyBhIGdv
b2QgdGhpbmcsIGJ1dCBJDQpkbyBub3QgdGhpbmsgaXQncyBnb2luZyB0byBzb2x2ZSB0aGlzIGlz
c3VlLg0KDQpUaGFua3MsDQotVG9zaGkNCg==
