From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: IS_ERR_VALUE misuses
Date: Mon, 30 May 2016 01:01:27 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BBB48BB@SHSMSX101.ccr.corp.intel.com>
References: <CA+55aFyi8_m0EJGcChe_SW_zzJUTJjPJjhEFbJzEL3gyhFNDLQ@mail.gmail.com>
	<7925824.43sdZ8TD9E@vostro.rjw.lan>
 <CA+55aFwh79PohObOo4Y0=ZpK=Enhv+vQvQMOm+bvWnqv7-Zv=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9778 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752025AbcE3BBb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 May 2016 21:01:31 -0400
In-Reply-To: <CA+55aFwh79PohObOo4Y0=ZpK=Enhv+vQvQMOm+bvWnqv7-Zv=Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>, Len Brown <lenb@kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>

SGksIFJhZmFlbCwgTGludXMsIEFybmQNCg0KVGhlIGluc3RhbmNlcyBpbiBkcml2ZXJzL2FjcGkv
YWNwaV9kYmcuYyB3ZXJlIG1hZGUgYnkgbWUuDQpTb3JyeSBmb3IgdGhlIGlzc3VlIGFuZCB0aGFu
a3MgZm9yIGZpeGluZyBpdCBmb3IgbWUuDQoNCkJlc3QgcmVnYXJkcw0KLUx2DQoNCj4gRnJvbTog
bGludXM5NzFAZ21haWwuY29tIFttYWlsdG86bGludXM5NzFAZ21haWwuY29tXSBPbiBCZWhhbGYg
T2YNCj4gTGludXMgVG9ydmFsZHMNCj4gU3ViamVjdDogUmU6IElTX0VSUl9WQUxVRSBtaXN1c2Vz
DQo+IA0KPiBPbiBTYXQsIE1heSAyOCwgMjAxNiBhdCA1OjEzIEFNLCBSYWZhZWwgSi4gV3lzb2Nr
aSA8cmp3QHJqd3lzb2NraS5uZXQ+DQo+IHdyb3RlOg0KPiA+DQo+ID4gVW5kZXIgZHJpdmVycy9h
Y3BpLyBJIGNvdWxkIG9ubHkgZmluZCBJU19FUlJfVkFMVUUoKSBpbiBhY3BpX2RiZy5jLCBidXQN
Cj4gPiB0aG9zZSBpbnN0YW5jZXMgc2hvdWxkIGJlIHJlbW92ZWQgYnkgdGhlIEFybmQncyBwYXRj
aCBpZiBJJ20gbm90DQo+IG1pc3Rha2VuLg0KPiANCj4gWWVzLCBJIG9ubHkgc2F3IHRoYXQgQXJu
ZCBoYWQgYSBwYXRjaCBmb3IgdGhpcyBhbmQgYXNrZWQgaGltIHRvIGp1c3QNCj4gc2VuZCBpdCB0
byBtZSBhZnRlciBJIGhhZCBhbHJlYWR5IGxvb2tlZCBhdCB0aGlzIGFuZCBzZW50IHRoZSBlbWFp
bA0KPiBvdXQuLg0KPiANCj4gVGhlIGFjcGkvbnZkaW1tIG1pc3VzZXMgYXJlIGdvbmUgbm93LCBh
bHRob3VnaCBvdGhlciBzdXNwZWN0IHVzZXMgb2YNCj4gdGhhdCBtYWNybyBkbyByZW1haW4uLg0K
PiANCj4gICAgICAgICAgICBMaW51cw0K
