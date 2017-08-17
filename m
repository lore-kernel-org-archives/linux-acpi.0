From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Thu, 17 Aug 2017 21:08:40 +0000
Message-ID: <1503003532.2042.161.camel@hpe.com>
References: <1502736750.2042.145.camel@hpe.com>
         <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
         <1502741290.2042.147.camel@hpe.com>
         <20170814203942.6t3mrq3hc324blab@pd.tnic>
         <1502810766.2042.149.camel@hpe.com>
         <20170815154815.wy3dqwb4yi3feahg@intel.com>
         <20170816082931.p6rpvtlxwt5nccxr@pd.tnic>
         <1502896578.2042.155.camel@hpe.com>
         <20170816164234.mgwapenb7fpym6nk@pd.tnic>
         <1502903940.2042.157.camel@hpe.com>
         <20170816174028.dqfvubjigvwtcbcy@pd.tnic>
         <1502905904.2042.159.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502905904.2042.159.camel@hpe.com>
Content-Language: en-US
Content-ID: <BE40CB23DB6B0F4EBB46C432DED7C740@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gV2VkLCAyMDE3LTA4LTE2IGF0IDExOjUxIC0wNjAwLCBUb3NoaSBLYW5pIHdyb3RlOg0KPiBP
biBXZWQsIDIwMTctMDgtMTYgYXQgMTk6NDAgKzAyMDAsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToN
Cj4gPiBPbiBXZWQsIEF1ZyAxNiwgMjAxNyBhdCAwNToyODo1MFBNICswMDAwLCBLYW5pLCBUb3No
aW1pdHN1IHdyb3RlOg0KIDoNCj4gPiA+IEkgd2lsbCB0ZXN0IHRoZSBwYXRjaCB3aXRoIGFuIFND
SSB3aGVuIEkgZ290IGEgY2hhbmNlLsKgwqBJIHdvbid0DQo+ID4gPiBiZSBhYmxlIHRvIHRlc3Qg
b3RoZXIgbm90aWZpY2F0aW9uIHR5cGVzIG9yIHJhY2UgY29uZGl0aW9ucywNCj4gPiA+IHRob3Vn
aC4NCj4gPiANCj4gPiBUaGFua3MsIGhlcmUncyB0aGUgbGF0ZXN0IHZlcnNpb24gd2l0aCB0aGUg
YXRvbWljIHJlZ2lzdHJhdGlvbiB0b28uDQo+IA0KPiBTdXJlLCBJIHdpbGwgdGVzdCB3aXRoIHRo
aXMgdmVyc2lvbi4NCg0KSSBicmllZmx5IHRlc3RlZCB0aGUgcGF0Y2ggd2l0aCBhbiBTQ0kuIFRo
ZSBlcnJvciByZXBvcnRpbmcgcGFydCBzZWVtcw0KdG8gd29yayBmaW5lLg0KDQpUaGVyZSBhcmUg
dHdvIGlzc3VlcyBJIG5vdGljZWQ6DQoNCjEuIEl0IGNyZWF0ZXMgbWMwIGFuZCBtYzEuIMKgDQpJ
IHRoaW5rIHRoaXMgaXMgYmVjYXVzZSB5b3UgY2FsbGVkIGVkYWNfbWNfYWxsb2MoKSB3aXRoIG1j
X251bSAxLg0KDQoyLiAncmFzLW1jLWN0bCAtLWxheW91dCcgZG9lcyBub3Qgc2hvdyBhbGwgRElN
TXMuDQoNCiPCoHJhcy1tYy1jdGwgLS1sYXlvdXQNCiAgICAgICAgICstLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0rDQrCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoMKgwqBtYzDCoMKgwqDCoMKgfMKgwqDC
oMKgbWMxwqDCoMKgwqDCoHwNCi0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQpt
ZW1vcnk0OiB8wqDCoMKgwqDCoDAgTULCoMKgfMKgwqAxNjM4NCBNQsKgwqB8DQptZW1vcnkzOiB8
wqDCoMKgwqDCoDAgTULCoMKgfMKgwqDCoMKgwqAwIE1CwqDCoHwNCm1lbW9yeTI6IHzCoMKgwqDC
oMKgMCBNQsKgwqB8wqDCoMKgwqDCoDAgTULCoMKgfA0KbWVtb3J5MTogfMKgwqDCoMKgwqAwIE1C
wqDCoHzCoMKgwqDCoMKgMCBNQsKgwqB8DQptZW1vcnkwOiB8wqDCoMKgwqDCoDAgTULCoMKgfMKg
wqA4MTkyIE1CwqDCoHwNCi0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCg0KIyBs
cyAvc3lzL2J1cy9tYzEvZGV2aWNlcw0KY3Nyb3cwwqDCoMKgY3Nyb3cxMsKgwqBjc3JvdzIzwqDC
oGRpbW0wwqDCoMKgZGltbTEywqDCoGRpbW0yM8KgwqBtYzENCmNzcm93MTHCoMKgY3Nyb3cxOcKg
wqBjc3JvdzTCoMKgwqBkaW1tMTHCoMKgZGltbTE5wqDCoGRpbW00DQoNClRoYW5rcywNCi1Ub3No
aQ0KDQoNCg==
