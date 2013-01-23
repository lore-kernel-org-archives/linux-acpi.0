From: Seiji Aguchi <seiji.aguchi@hds.com>
Subject: RE: ERST: how to avoid a dynamic memory allocation in panic case
Date: Wed, 23 Jan 2013 00:44:19 +0000
Message-ID: <A5ED84D3BB3A384992CBB9C77DEDA4D414A520D4@USINDEM103.corp.hds.com>
References: <A5ED84D3BB3A384992CBB9C77DEDA4D414A51F3D@USINDEM103.corp.hds.com>
 <1358901594.7408.85.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usindpps06.hds.com ([207.126.252.19]:35581 "EHLO
	usindpps06.hds.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab3AWApI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2013 19:45:08 -0500
In-Reply-To: <1358901594.7408.85.camel@yhuang-dev>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "H. Peter Anvin (hpa@zytor.com)" <hpa@zytor.com>, "robert.moore@intel.com" <robert.moore@intel.com>, "trenn@suse.de" <trenn@suse.de>, "myron.stowe@redhat.com" <myron.stowe@redhat.com>

DQoNCj4gPiA8c25pcD4NCj4gPiBAQCAtOTE4LDEwICs5MTgsNyBAQCBhY3BpX29zX3JlYWRfbWVt
b3J5KGFjcGlfcGh5c2ljYWxfYWRkcmVzcyBwaHlzX2FkZHIsIHU2NCAqdmFsdWUsIHUzMiB3aWR0
aCkNCj4gPiAgCXZpcnRfYWRkciA9IGFjcGlfbWFwX3ZhZGRyX2xvb2t1cChwaHlzX2FkZHIsIHNp
emUpOw0KPiA+ICAJaWYgKCF2aXJ0X2FkZHIpIHsNCj4gPiAgCQlyY3VfcmVhZF91bmxvY2soKTsN
Cj4gPiAtCQl2aXJ0X2FkZHIgPSBhY3BpX29zX2lvcmVtYXAocGh5c19hZGRyLCBzaXplKTsNCj4g
PiAtCQlpZiAoIXZpcnRfYWRkcikNCj4gPiAtCQkJcmV0dXJuIEFFX0JBRF9BRERSRVNTOw0KPiA+
IC0JCXVubWFwID0gdHJ1ZTsNCj4gPiArCQlyZXR1cm4gQUVfQkFEX0FERFJFU1M7DQo+IA0KPiBO
by4gIFdlIGNhbiBub3QgZG8gdGhhdC4gIEJlY2F1c2Ugc29tZSB1c2VycyByZWx5IG9uIGFjcGlf
b3NfcmVhZF9tZW1vcnkgdG8gZG8gaW9yZW1hcCBmb3IgdGhlbS4NCg0KVGhhbmsgeW91IGZvciBn
aXZpbmcgbWUgdGhlIGluZm9ybWF0aW9uLg0KDQo+IFRoZSBjb3JyZWN0IGZpeGluZyBzaG91bGQg
YmUgcHJlLW1hcCB0aGUgaW8tbWVtb3J5IHRoYXQgbWF5IGJlIGFjY2Vzc2VkIGluIGVyc3QgY29k
ZSBwYXRjaCB3aXRoIGFjcGlfbWFwKCkuDQoNCkkgd2lsbCB0YWtlIGEgbG9vayBhdCB0aGUgY29k
ZS4NCg0KU2VpamkNCg==
