From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [Update][PATCH] ACPI / hotplug: Fix concurrency issues and
 memory leaks
Date: Thu, 14 Feb 2013 02:31:22 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E368CB39A9@ORSMSX101.amr.corp.intel.com>
References: <1837481.7dT8hTZ4MT@vostro.rjw.lan>
 <4594350.VXNmDOeCvt@vostro.rjw.lan>
 <1360796969.3869.146.camel@misato.fc.hp.com>
 <5284026.QPQbFciqVT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42088 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712Ab3BNCbY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Feb 2013 21:31:24 -0500
In-Reply-To: <5284026.QPQbFciqVT@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Toshi Kani <toshi.kani@hp.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Myron Stowe <mstowe@redhat.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>

PiA+ID4gSSB0aG91Z2h0IGFib3V0IHRoYXQsIGJ1dCBhY3R1YWxseSB0aGVyZSdzIG5vIGd1YXJh
bnRlZSB0aGF0IHRoZQ0KPiA+ID4gaGFuZGxlIHdpbGwgYmUgdmFsaWQgYWZ0ZXIgX0VKMCBhcyBm
YXIgYXMgSSBjYW4gc2F5LiAgU28gdGhlIHJhY2UNCj4gPiA+IGNvbmRpdGlvbiBpcyBnb2luZyB0
byBiZSB0aGVyZSBhbnl3YXkgYW5kIHVzaW5nIHN0cnVjdCBhY3BpX2RldmljZQ0KPiA+ID4ganVz
dCBtYWtlcyBpdCBlYXNpZXIgdG8gYXZvaWQgaXQuDQo+ID4NCj4gPiBJbiB0aGVvcnksIHllcywg
YSBzdGFsZSBoYW5kbGUgY291bGQgYmUgYSBwcm9ibGVtLCBpZiBfRUowIHBlcmZvcm1zDQo+ID4g
dW5sb2FkIHRhYmxlIGFuZCBpZiBBQ1BJQ0EgZnJlZXMgdXAgaXRzIGludGVybmFsIGRhdGEgc3Ry
dWN0dXJlDQo+ID4gcG9pbnRlZCBieSB0aGUgaGFuZGxlIGFzIGEgcmVzdWx0LiAgQnV0IHdlIHNo
b3VsZCBub3Qgc2VlIHN1Y2ggaXNzdWUNCj4gPiBub3cgc2luY2Ugd2UgZG8gbm90IHN1cHBvcnQg
ZHluYW1pYyBBQ1BJIG5hbWVzcGFjZSB5ZXQuDQo+IA0KPiBJJ20gd2FpdGluZyBmb3IgaW5mb3Jt
YXRpb24gZnJvbSBCb2IgYWJvdXQgdGhhdC4gIElmIHdlIGNhbiBhc3N1bWUgQUNQSQ0KPiBoYW5k
bGVzIHRvIGJlIGFsd2F5cyB2YWxpZCwgdGhhdCB3aWxsIHNpbXBsaWZ5IHRoaW5ncyBxdWl0ZSBh
IGJpdC4NCg0KSWYgYSB0YWJsZSBpcyB1bmxvYWRlZCwgYWxsIHRoZSBuYW1lc3BhY2Ugbm9kZXMg
Zm9yIHRoYXQgdGFibGUgYXJlIHJlbW92ZWQgZnJvbSB0aGUgbmFtZXNwYWNlLCBhbmQgdGh1cyBh
bnkgQUNQSV9IQU5ETEUgcG9pbnRlcnMgZ28gc3RhbGUgYW5kIGludmFsaWQuDQoNCkJvYg0KDQo=
