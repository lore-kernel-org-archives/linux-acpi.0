From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v2 1/2] mce: acpi/apei: Honour Firmware First for MCA
 banks listed in APEI HEST CMC
Date: Tue, 25 Jun 2013 17:55:27 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31C54AF9@ORSMSX106.amr.corp.intel.com>
References: <20130621174057.GI22006@pd.tnic>
 <20130625174536.5226.66421.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1466 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101Ab3FYRz3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jun 2013 13:55:29 -0400
In-Reply-To: <20130625174536.5226.66421.stgit@localhost.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, "bp@alien8.de" <bp@alien8.de>
Cc: "ananth@in.ibm.com" <ananth@in.ibm.com>, "masbock@linux.vnet.ibm.com" <masbock@linux.vnet.ibm.com>, "lcm@linux.vnet.ibm.com" <lcm@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>

Ky8qDQorICogSW5kaWNhdGVzIE1DQSBiYW5rcyBjb250cm9sbGVkIGJ5IHRoZSBjdXJyZW50IGNw
dSBmb3IgQ01DSS4gTm90ZSB0aGF0IHRoaXMNCisgKiBjYW4gY2hhbmdlIHdoZW4gYSBjcHUgaXMg
b2ZmbGluZWQgb3IgYnJvdWdodCBvbmxpbmUgc2luY2Ugc29tZSBNQ0EgYmFua3MNCisgKiBhcmUg
c2hhcmVkIGFjcm9zcyBjcHVzLiBXaGVuIGEgY3B1IGlzIG9mZmxpbmVkLCBjbWNpX2NsZWFyKCkg
ZGlzYWJsZXMgQ01DSQ0KKyAqIG9uIGFsbCBiYW5rcyBvd25lZCBieSB0aGUgY3B1IGFuZCBjbGVh
cnMgdGhpcyBiaXRmaWVsZC4gQXQgdGhpcyBwb2ludCwNCisgKiBjbWNpX3JlZGlzY292ZXIoKSBr
aWNrcyBpbiBhbmQgYSBkaWZmZXJlbnQgY3B1IG1heSBlbmQgdXAgdGFraW5nDQorICogb3duZXJz
aGlwIG9mIHNvbWUgb2YgdGhlIHNoYXJlZCBNQ0EgYmFua3MgdGhhdCB3ZXJlIHByZXZpb3VzbHkg
b3duZWQNCisgKiBieSB0aGUgb2ZmbGluZWQgY3B1Lg0KKyAqLw0KIHN0YXRpYyBERUZJTkVfUEVS
X0NQVShtY2VfYmFua3NfdCwgbWNlX2JhbmtzX293bmVkKTsNCg0KTWF5YmUgYW4gZXh0cmEgc2Vu
dGVuY2Ugb3IgdHdvIGF0IHRoZSBiZWdpbm5pbmcgdG8gc2F5ICp3aHkqIHdlIG5lZWQgdGhpcy4N
CkUuZy4NCg0KLyoNCiAqIENNQ0kgY2FuIGJlIGRlbGl2ZXJlZCB0byBtdWx0aXBsZSBjcHVzIHRo
YXQgc2hhcmUgYSBtYWNoaW5lIGNoZWNrIGJhbmsNCiAqIHNvIHdlIG5lZWQgdG8gZGVzaWduYXRl
IGEgc2luZ2xlIGNwdSB0byBwcm9jZXNzIGVycm9ycyBsb2dnZWQgaW4gZWFjaCBiYW5rDQogKiBp
biB0aGUgaW50ZXJydXB0IGhhbmRsZXIgKG90aGVyd2lzZSB3ZSB3b3VsZCBoYXZlIG1hbnkgcmFj
ZXMgYW5kIHBvdGVudGlhbA0KICogZG91YmxlIHJlcG9ydGluZyBvZiB0aGUgc2FtZSBlcnJvci4N
CiAqLw0KLi4uDQoNCi1Ub255DQo=
