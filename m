From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 03/32] ACPICA: Hardware: Enable 64-bit firmware waking
 vector for selected FACS.
Date: Wed, 24 Jun 2015 00:13:43 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88027335D6@SHSMSX101.ccr.corp.intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com>
	<261af597362906597365810a650c8e5c189e86da.1434684719.git.lv.zheng@intel.com>
 <CAJZ5v0gfdfJF_-wK26wjxY=ai+QoUtS3ZpLT4ORX-P_wPQiA-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25942 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbbFXAOS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jun 2015 20:14:18 -0400
In-Reply-To: <CAJZ5v0gfdfJF_-wK26wjxY=ai+QoUtS3ZpLT4ORX-P_wPQiA-g@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

SGksIFJhZmFlbA0KDQo+IEZyb206IHJqd3lzb2NraUBnbWFpbC5jb20gW21haWx0bzpyand5c29j
a2lAZ21haWwuY29tXSBPbiBCZWhhbGYgT2YgUmFmYWVsIEouIFd5c29ja2kNCj4gU2VudDogVHVl
c2RheSwgSnVuZSAyMywgMjAxNSAxMToyMSBQTQ0KPiANCj4gSGkgTHYsDQo+IA0KPiBPbiBGcmks
IEp1biAxOSwgMjAxNSBhdCA1OjM4IEFNLCBMdiBaaGVuZyA8bHYuemhlbmdAaW50ZWwuY29tPiB3
cm90ZToNCj4gPiBBQ1BJQ0EgY29tbWl0IDdhYTU5OGQ3MTE2NDRhYjBkZTVmNzBhZDg4ZjFlMmRl
MjUzMTE1ZTQNCj4gPg0KPiA+IFRoZSByb290IGNhdXNlIG9mIHRoZSByZXBvcnRlZCBidWcgbWln
aHQgYmUgb25lIG9mIHRoZSBmb2xsb3dpbmdzOg0KPiA+IDEuIEJJT1MgbWF5IGZhdm9yIHRoZSA2
NC1iaXQgZmlybXdhcmUgd2FraW5nIHZlY3RvciBhZGRyZXNzIHdoZW4gdGhlDQo+ID4gICAgdmVy
c2lvbiBvZiB0aGUgRkFDUyBpcyBncmVhdGVyIHRoYW4gMCBhbmQgTGludXggY3VycmVudGx5IG9u
bHkgc3VwcG9ydHMNCj4gPiAgICByZXN1bWluZyBmcm9tIHRoZSByZWFsIG1vZGUsIHNvIHRoZSA2
NC1iaXQgZmlybXdhcmUgd2FraW5nIHZlY3RvciBoYXMNCj4gPiAgICBuZXZlciBiZWVuIHNldCBh
bmQgbWlnaHQgYmUgaW52YWxpZCB0byBCSU9TIHdoaWxlIHRoZSBjb21taXQgZW5hYmxlcw0KPiA+
ICAgIGhpZ2hlciB2ZXJzaW9uIEZBQ1MuDQo+ID4gMi4gQklPUyBtYXkgZmF2b3IgdGhlIEZBQ1Mg
cmVwb3J0ZWQgdmlhIHRoZSAiRklSTVdBUkVfQ1RSTCIgZmllbGQgaW4gdGhlDQo+ID4gICAgRkFE
VCB3aGlsZSB0aGUgY29tbWl0IGRvZXNuJ3Qgc2V0IHRoZSBmaXJtd2FyZSB3YWtpbmcgdmVjdG9y
IGFkZHJlc3Mgb2YNCj4gDQo+IENhbiB5b3UgcGxlYXNlIHRlbGwgbWUgd2hpY2ggY29tbWl0IHRo
aXMgaXMgYWJvdXQ/DQoNCkl0J3MgdGhlIGJpc2VjdGVkIGNvbW1pdCBvbiB0aGUgQnVnemlsbGEg
ZW50cnk6DQpodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTc0MDIx
I2MyMw0KU2luY2UgdGhlIHBhcnQgb2YgdGhpcyBzZXJpZXMgb3JpZ2luYWxseSBiZWxvbmdzIHRv
IGEgcmVncmVzc2lvbiBmaXggc2VyaWVzLCB0aGUgY29tbWl0IGlzIG5vdCBtZW50aW9uZWQgYWdh
aW4gaGVyZS4NCkxldCBtZSB1cGRhdGUgdGhlIGRlc2NyaXB0aW9uLg0KDQpUaGFua3MgYW5kIGJl
c3QgcmVnYXJkcw0KLUx2DQoNCj4gDQo+ID4gICAgdGhlIEZBQ1MgcmVwb3J0ZWQgYnkgIkZJUk1X
QVJFX0NUUkwiLCBpdCBvbmx5IHNldHMgdGhlIGZpcndhcmUgd2FraW5nDQo+ID4gICAgdmVjdG9y
IGFkZHJlc3Mgb2YgdGhlIEZBQ1MgcmVwb3J0ZWQgYnkgIlhfRklSTVdBUkVfQ1RSTCIuDQo+IA0K
PiBUaGFua3MsDQo+IFJhZmFlbA0K
