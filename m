From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 2/2] ACPICA: support Generic Address Structure
 bit_offset in acpi_read/write
Date: Wed, 30 Nov 2011 13:54:58 -0800
Message-ID: <0207C53569FE594381A4F2EB66570B2A018ED45AA8@orsmsx508.amr.corp.intel.com>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
	 <201111172127.40664.rjw@sisk.pl> <1321578279.13860.108.camel@yhuang-dev>
	 <201111181025.58650.rjw@sisk.pl> <1321861880.13860.128.camel@yhuang-dev>
	 <987664A83D2D224EAE907B061CE93D53027D89B5A9@orsmsx505.amr.corp.intel.com>
 <1322532903.4849.24.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47109 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab1K3VzA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Nov 2011 16:55:00 -0500
In-Reply-To: <1322532903.4849.24.camel@yhuang-dev>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Russell King <linux@arm.linux.org.uk>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bondd@us.ibm.com" <bondd@us.ibm.com>, Myron Stowe <myron.stowe@redhat.com>

PiBCdXQgYXMgdGhpcyBjb2RlIG1heSBiZSB1c2VkIGluIGdlbmVyYWwgYWNwaV9yZWFkL3dyaXRl
IHBhdGggdG9vIGluIHRoZQ0KPiBmdXR1cmUsIGNhbiB5b3UgdmVyaWZ5IHdoZXRoZXIgaXQgaXMg
aGFybWxlc3Mgb24gaWE2ND8NCg0KVGhpcyBtaWdodCBiZSBhIHByb2JsZW0gb24gaWE2NCAtIGl0
IGlzIHMvdyByZXNwb25zaWJpbGl0eSB0byBtYWtlIHN1cmUNCnRoYXQgd2UgZG9uJ3QgbWFwIHRo
ZSBzYW1lIHVuZGVybHlpbmcgcGh5c2ljYWwgYWRkcmVzcyB1c2luZyBkaWZmZXJlbnQNCmNhY2hl
IGF0dHJpYnV0ZXMgLSBlLmcuIHdlIG11c3Qgbm90IG1hcCBtZW1vcnkgYm90aCBjYWNoZWFibGUg
YW5kIHVuY2FjaGVhYmxlDQphdCB0aGUgc2FtZSB0aW1lLiAgQWNjZXNzaW5nIHN1Y2ggYSBtaXMt
YXR0cmlidXRlZCBwYWdlIHdpbGwgcmVzdWx0IGluIGENCm1hY2hpbmUgY2hlY2suDQoNClNvIEkn
ZCB3b3JyeSB0aGF0IGlmIHRoZSBtZW1vcnkgaW4gcXVlc3Rpb24gd2FzIGJlaW5nIHVzZWQgYXMg
dW5jYWNoZWFibGUsDQp0aGlzIGNvZGUgbWlnaHQgcmVzdWx0IGluIGEgY2FjaGVkIGFjY2Vzcywg
d2hpY2ggd291bGQgY3Jhc2ggdGhlIG1hY2hpbmUuDQoNCi1Ub255DQo=
