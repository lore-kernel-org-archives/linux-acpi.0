From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v3] aerdrv: Move cper_print_aer() call out of interrupt
 context
Date: Wed, 29 May 2013 23:07:47 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F2DA70112@ORSMSX106.amr.corp.intel.com>
References: <20130529190326.24171.86905.stgit@grignak.americas.hpqcorp.net>
 <30463843.EmBn1xaq3I@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57930 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966322Ab3E2XHt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 May 2013 19:07:49 -0400
In-Reply-To: <30463843.EmBn1xaq3I@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Lance Ortiz <lance.ortiz@hp.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, "lance_ortiz@hotmail.com" <lance_ortiz@hotmail.com>, "jiang.liu@huawei.com" <jiang.liu@huawei.com>, "bp@alien8.de" <bp@alien8.de>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mchehab@redhat.com" <mchehab@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

PiArCS8qDQo+ICsJICogVE9ETzogVGhpcyBmdW5jdGlvbiBuZWVkcyB0byBiZSByZS13cml0dGVu
IHNvIHRoYXQgaXQncyBvdXRwdXQNCj4gKwkgKiBtYXRjaGVzIHRoZSBvdXRwdXQgb2YgYWVyX3By
aW50X2Vycm9yKCkuICBSaWdodCBub3csIHRoZSBvdXRwdXQNCj4gKwkgKiBpcyBmb3JtYXR0ZWQg
dmVyeSBkaWZmZXJlbnRseS4NCj4gKwkgKi8NCg0KU28gd2UgaGF2ZSB0aGlzIGJpZyAiVE9ETyIg
Y29tbWVudCBzaXR0aW5nIHRoZXJlIHZlcnkgcHJvbWluZW50bHkgLi4uIHdoaWNoIExpbnVzDQpp
cyBib3VuZCB0byBhc2sgYWJvdXQgaWYgSSBhc2sgaGltIHRvIHB1bGwgdGhpcyBpbnRvIDMuMTAt
cmNYIC4uLiB3aGF0J3MgdGhlIGltcGFjdCBvZg0KdGhpcz8gIFdoYXQgc2hvdWxkIEkgc2F5IHdo
ZW4gaGUgYXNrcyB3aHkgc2hvdWxkIGhlIHB1bGwgdGhpcyBmaXggaW50byAzLjEwIHdoZW4NCnRo
ZXJlIGlzIHN0aWxsIHNvbWUgd29yayB0byBkbz8gIElzIG1hdGNoaW5nIHRoZSBvdXRwdXQgbm8g
YmlnIGRlYWwgYW5kIGNhbiB3YWl0IGZvcg0Kc29tZSBmdXR1cmUsIHdoaWxlIG1vdmluZyB0aGUg
cGNpIGJpdHMgdG8gdGhlIHdvcmsgZnVuY3Rpb24gbmVlZHMgdG8gZ28gaW4gbm93Pw0KDQotVG9u
eQ0K
