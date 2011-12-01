From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 2/2] ACPICA: support Generic Address Structure
 bit_offset in acpi_read/write
Date: Wed, 30 Nov 2011 17:03:40 -0800
Message-ID: <0207C53569FE594381A4F2EB66570B2A018ED45DCF@orsmsx508.amr.corp.intel.com>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
	 <201111172127.40664.rjw@sisk.pl> <1321578279.13860.108.camel@yhuang-dev>
	 <201111181025.58650.rjw@sisk.pl> <1321861880.13860.128.camel@yhuang-dev>
	 <987664A83D2D224EAE907B061CE93D53027D89B5A9@orsmsx505.amr.corp.intel.com>
	 <1322532903.4849.24.camel@yhuang-dev>
	 <0207C53569FE594381A4F2EB66570B2A018ED45AA8@orsmsx508.amr.corp.intel.com>
	 <1322700551.4849.66.camel@yhuang-dev>
	 <0207C53569FE594381A4F2EB66570B2A018ED45DA7@orsmsx508.amr.corp.intel.com>
 <1322701065.4849.69.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41215 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753526Ab1LABDm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Nov 2011 20:03:42 -0500
In-Reply-To: <1322701065.4849.69.camel@yhuang-dev>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Russell King <linux@arm.linux.org.uk>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bondd@us.ibm.com" <bondd@us.ibm.com>, Myron Stowe <myron.stowe@redhat.com>

PiBJbiB0aGUgb3JpZ2luYWwgYWNwaV9yZWFkL3dyaXRlLCB3ZSBqdXN0IGNhbGwgaW9yZW1hcCBi
bGluZGx5LCBzbyB0aGUNCj4gY29kZSBpbiB0aGUgYmVsb3cgcGF0Y2ggd2lsbCBub3QgaW50cm9k
dWNlIG5ldyBpc3N1ZSBmb3IgaWE2NC4gIERvIHlvdQ0KPiBhZ3JlZT8NCg0KU2VlIGFyY2gvaWE2
NC9tbS9pb3JlbWFwLmMgLi4uIGlvcmVtYXAoKSBvbiBpYTY0IGlzIHNtYXJ0IGFuZCBsb29rcw0K
YXQgYXR0cmlidXRlcyBhbmQgbWFrZXMgbmV3IG1hcHBpbmcgbWF0Y2ggZXhpc3Rpbmcgb25lcw0K
DQpUaGF0IGRvZXNuJ3QgZGVhbCB3aXRoIGxvbmctbGl2ZWQgbWFwcGluZ3MgYW5kIGNoYW5nZXMg
dGhhdCBJIGp1c3QNCm1lbnRpb25lZCBpbiBsYXN0IGUtbWFpbCAtIGJ1dCBpdCBkb2VzIG1lYW4g
dGhhdCBjYWxsZXJzIG9mIGlvcmVtYXAoKQ0KZG9uJ3QgbmVlZCB0byB3b3JyeSAuLi4gdGhleSBj
YW4gY2FsbCAiYmxpbmRseSIuDQoNCi1Ub255DQo=
