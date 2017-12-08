From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH] acpi, nfit: fix health event notification
Date: Fri, 8 Dec 2017 23:51:18 +0000
Message-ID: <1512776323.11639.25.camel@hpe.com>
References: <151209330313.2584.7295902868393348172.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:12648 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753367AbdLHXv0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Dec 2017 18:51:26 -0500
In-Reply-To: <151209330313.2584.7295902868393348172.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
Content-ID: <65ED5F90749CFA48A714A781D66130ED@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Cc: "daniel.k.osawa@intel.com" <daniel.k.osawa@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>

T24gVGh1LCAyMDE3LTExLTMwIGF0IDE3OjU1IC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEludGVncmF0aW9uIHRlc3Rpbmcgd2l0aCBhIEJJT1MgdGhhdCBnZW5lcmF0ZXMgaW5qZWN0ZWQg
aGVhbHRoIGV2ZW50DQo+IG5vdGlmaWNhdGlvbnMgZmFpbHMgdG8gY29tbXVuaWNhdGUgdGhvc2Ug
ZXZlbnRzIHRvIHVzZXJzcGFjZS4gVGhlIG5maXQNCj4gZHJpdmVyIG5lZ2xlY3RzIHRvIGxpbmsg
dGhlIEFDUEkgRElNTSBkZXZpY2Ugd2l0aCB0aGUgbmVjZXNzYXJ5IGRyaXZlcg0KPiBkYXRhIHNv
IGFjcGlfbnZkaW1tX25vdGlmeSgpIGZhaWxzIHRoaXMgbG9va3VwOg0KPiANCj4gICAgICAgICBu
Zml0X21lbSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAgICAgICAgIGlmIChuZml0X21lbSAm
JiBuZml0X21lbS0+ZmxhZ3NfYXR0cikNCj4gICAgICAgICAgICAgICAgIHN5c2ZzX25vdGlmeV9k
aXJlbnQobmZpdF9tZW0tPmZsYWdzX2F0dHIpOw0KPiANCj4gQWRkIHRoZSBuZWNlc3NhcnkgbGlu
a2FnZSB3aGVuIGluc3RhbGxpbmcgdGhlIG5vdGlmaWNhdGlvbiBoYW5kbGVyIGFuZA0KPiBjbGVh
biBpdCB1cCB3aGVuIHRoZSBuZml0IGRyaXZlciBpbnN0YW5jZSBpcyB0b3JuIGRvd24uDQo+IA0K
PiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+IENjOiBUb3NoaSBLYW5pIDx0b3NoaS5r
YW5pQGhwZS5jb20+DQo+IENjOiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNv
bT4NCj4gRml4ZXM6IGJhOWM4ZGQzYzIyMiAoImFjcGksIG5maXQ6IGFkZCBkaW1tIGRldmljZSBu
b3RpZmljYXRpb24gc3VwcG9ydCIpDQo+IFJlcG9ydGVkLWJ5OiBEYW5pZWwgT3Nhd2EgPGRhbmll
bC5rLm9zYXdhQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4u
ai53aWxsaWFtc0BpbnRlbC5jb20+DQoNClRoZSBmaXggbG9va3MgZ29vZC4gIFNvcnJ5IGl0IGFw
cGVhcnMgdGhhdCBJIG9ubHkgdGVzdGVkIEFDUEkNCm5vdGlmaWNhdGlvbiwgbm90IHN5c2ZzIGV2
ZW50LCBmb3IgdGhlIG9yaWdpbmFsIGNoYW5nZS4NCg0KUmV2aWV3ZWQtYnk6IFRvc2hpIEthbmkg
PHRvc2hpLmthbmlAaHBlLmNvbT4NCg0KVGhhbmtzIQ0KLVRvc2hp
