From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v2 2/2] mce: acpi/apei: Add a boot option to disable ff
 mode for corrected errors
Date: Wed, 19 Jun 2013 19:05:16 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F2DA881C2@ORSMSX106.amr.corp.intel.com>
References: <20130619175438.2852.93449.stgit@localhost.localdomain>
 <20130619175728.2852.73156.stgit@localhost.localdomain>
 <20130619180441.GK28300@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F2DA88106@ORSMSX106.amr.corp.intel.com>
 <20130619183640.GL28300@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:64423 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757458Ab3FSTFT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Jun 2013 15:05:19 -0400
In-Reply-To: <20130619183640.GL28300@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, "ananth@in.ibm.com" <ananth@in.ibm.com>, "masbock@linux.vnet.ibm.com" <masbock@linux.vnet.ibm.com>, "lcm@linux.vnet.ibm.com" <lcm@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>

PiBXaHksIGZpbGwgb3V0IHN0cnVjdCBtY2UgYW5kIGRvIG1jZV9sb2cobWNlKSBkb2VzIG5vdCBz
dWZmaWNlPw0KDQpUaGVyZSBpcyAob3Igc2hvdWxkIGJlKSBhIGxvdCBtb3JlIGludGVyZXN0aW5n
IHN0dWZmIGluIHRoZSBDUEVSIHRoYW4ganVzdCB0aGUgYWRkcmVzcy4gU3R1ZmYNCnRoYXQgd2Ug
ZG9uJ3QgaGF2ZSBmaWVsZHMgZm9yIGluIHRoZSBleGlzdGluZyBtY2Vsb2cgc3RydWN0dXJlLiAg
V2UgYWxzbyBuZWVkIHRvIHRyZWF0IGZpbHRlcmVkDQpyZWNvcmRzIGZyb20gbW9kZXJuIEFQRUkg
aW1wbGVtZW50YXRpb25zIGEgYml0IGRpZmZlcmVudGx5IGZyb20gdGhlIG9sZCBzdHVmZi4gIFRo
ZSBvcmlnaW5hbA0KdXNlciBvZiB0aGlzIGNvZGUgd2FzIFdlc3RtZXJlLUVYLCB3aGljaCB1c2Vk
IGl0IGFzIGEgd29ya2Fyb3VuZCBmb3IgYSBtaXNzaW5nIGFkZHJlc3MgaW4NCk1DaV9BRERSIGZv
ciBjb3JyZWN0ZWQgZXJyb3JzLiAgU28gaW4gdGhhdCBzY2VuYXJpbyB3ZSBoYWQgZXZlcnkgZXJy
b3IgYmVpbmcgcmVwb3J0ZWQgYW5kDQptY2Vsb2coOCkgZGVhbW9uIGRvaW5nIHRoZSB0aHJlc2hv
bGQgYW5hbHlzaXMgdG8gZGVjaWRlIHdoZW4gdG8gdGFrZSBhY3Rpb24uDQoNCkluIHRoaXMgbmV3
IG1vZGVybiB3b3JsZCAtIE5hdmVlbiB3YW50cyB0byBoYXZlIHRoZSBCSU9TIGRlY2lkZSB0aGUg
dGhyZXNob2xkLCBzbyB3ZSdkDQpsaWtlIExpbnV4IHRvIHRha2Ugc29tZSBhY3Rpb24gYXMgc29v
biBhcyBpdCBzZWVzIGp1c3Qgb25lIENQRVIuDQoNCi1Ub255DQo=
