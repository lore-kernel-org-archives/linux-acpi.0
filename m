From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Wed, 16 Aug 2017 17:28:50 +0000
Message-ID: <1502903940.2042.157.camel@hpe.com>
References: <1502734083.2042.143.camel@hpe.com>
         <20170814183551.sgk2i7lxpmpyodhv@pd.tnic>
         <1502736750.2042.145.camel@hpe.com>
         <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
         <1502741290.2042.147.camel@hpe.com>
         <20170814203942.6t3mrq3hc324blab@pd.tnic>
         <1502810766.2042.149.camel@hpe.com>
         <20170815154815.wy3dqwb4yi3feahg@intel.com>
         <20170816082931.p6rpvtlxwt5nccxr@pd.tnic>
         <1502896578.2042.155.camel@hpe.com>
         <20170816164234.mgwapenb7fpym6nk@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816164234.mgwapenb7fpym6nk@pd.tnic>
Content-Language: en-US
Content-ID: <FEB5A85158C4CA409DD5B1CA2588B1DD@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gV2VkLCAyMDE3LTA4LTE2IGF0IDE4OjQyICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFdlZCwgQXVnIDE2LCAyMDE3IGF0IDAzOjI2OjA0UE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gSSBiZWxpZXZlIHlvdSBub3cgbmVlZCB0byBwcm90ZWN0IGZyb20g
YSByYWNlIGNvbmRpdGlvbiB0aGF0IGENCj4gPiBzaW5nbGUgbWNpIGFuZCBwdnQgY2FuIGJlIGlu
aXRpYWxpemVkIC8gY29uc3VtZWQgZnJvbSBtdWx0aXBsZQ0KPiA+IHRocmVhZHMuwqDCoFRoaXMg
cHJvdGVjdGlvbiBpcyBtaXNzaW5nIGluIHlvdXIgcGF0Y2guDQo+IA0KPiBFYXN5LiBEb25lLg0K
DQpBc3N1bWluZyB0aGlzIGJpZyBzcGlubG9jayB3b3JrcywgeWVzLCB0aGlzIGFkZHJlc3NlcyBt
eSBjb25jZXJuIHRoYXQNCml0IGRvZXMgbm90IGFsbG93IGNvbmN1cnJlbnQgYWNjZXNzZXMgdG8g
bWNpLiA6LSkNCg0KSSB3aWxsIHRlc3QgdGhlIHBhdGNoIHdpdGggYW4gU0NJIHdoZW4gSSBnb3Qg
YSBjaGFuY2UuICBJIHdvbid0IGJlIGFibGUNCnRvIHRlc3Qgb3RoZXIgbm90aWZpY2F0aW9uIHR5
cGVzIG9yIHJhY2UgY29uZGl0aW9ucywgdGhvdWdoLg0KDQpUaGFua3MsDQotVG9zaGkNCg==
