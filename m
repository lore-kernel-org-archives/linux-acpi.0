From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 2/2] ACPICA: support Generic Address Structure
 bit_offset in acpi_read/write
Date: Thu, 1 Dec 2011 09:35:28 -0800
Message-ID: <0207C53569FE594381A4F2EB66570B2A018ED461AE@orsmsx508.amr.corp.intel.com>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
	 <201111172127.40664.rjw@sisk.pl> <1321578279.13860.108.camel@yhuang-dev>
	 <201111181025.58650.rjw@sisk.pl> <1321861880.13860.128.camel@yhuang-dev>
	 <987664A83D2D224EAE907B061CE93D53027D89B5A9@orsmsx505.amr.corp.intel.com>
	 <1322532903.4849.24.camel@yhuang-dev>
	 <0207C53569FE594381A4F2EB66570B2A018ED45AA8@orsmsx508.amr.corp.intel.com>
	 <1322700551.4849.66.camel@yhuang-dev>
	 <0207C53569FE594381A4F2EB66570B2A018ED45DA7@orsmsx508.amr.corp.intel.com>
	 <1322701065.4849.69.camel@yhuang-dev>
	 <0207C53569FE594381A4F2EB66570B2A018ED45DCF@orsmsx508.amr.corp.intel.com>
 <1322701894.4849.72.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:43455 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755632Ab1LARfb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Dec 2011 12:35:31 -0500
In-Reply-To: <1322701894.4849.72.camel@yhuang-dev>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Russell King <linux@arm.linux.org.uk>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bondd@us.ibm.com" <bondd@us.ibm.com>, Myron Stowe <myron.stowe@redhat.com>

Pj4gVGhhdCBkb2Vzbid0IGRlYWwgd2l0aCBsb25nLWxpdmVkIG1hcHBpbmdzIGFuZCBjaGFuZ2Vz
IHRoYXQgSSBqdXN0DQo+PiBtZW50aW9uZWQgaW4gbGFzdCBlLW1haWwgLSBidXQgaXQgZG9lcyBt
ZWFuIHRoYXQgY2FsbGVycyBvZiBpb3JlbWFwKCkNCj4+IGRvbid0IG5lZWQgdG8gd29ycnkgLi4u
IHRoZXkgY2FuIGNhbGwgImJsaW5kbHkiLg0KPg0KPiBJIHNlZS4gIFNvIHlvdSB0aGluayBpdCBp
cyBiZXR0ZXIgdG8gZW5jbG9zZSBwYWdlX2lzX3JhbSgpIHdpdGggI2lmbmRlZg0KPiBDT05GSUdf
SUE2NCBpbiB0aGUgcGF0Y2gsIHNvIHRoYXQgb25seSBpb3JlbWFwKCkgaXMgdXNlZD8NCg0KRnVu
Y3Rpb25hbGx5IHllcyAtIHRob3VnaCB0aGUgYXZlcnNpb24gdG8gI2lmZGVmIGluIHRoZSBtaWRk
bGUgb2YgY29kZQ0Kd291bGQgaW1wbHkgc29tZSBleHRyYSBob29wcy4gIFBlcmhhcHMNCg0KI2lm
bmRlZiBDT05GSUdfSUE2NA0KI2RlZmluZSBjYW5fdXNlX2ttYXAocGZuKSBwYWdlX2lzX3JhbShw
Zm4pDQojZWxzZQ0KI2RlZmluZSBjYW5fdXNlX2ttYXAocGZuKSAoMCkgLyogaW9yZW1hcCgpIHdp
bGwgdGFrZSBjYXJlIG9mIGNhY2hlIGF0dHJpYnV0ZXMgKi8NCiNlbmRpZg0KDQoNCi4uLg0KDQoJ
CWlmIChjYW5fdXNlX2ttYXAocGZuKSkgew0KDQoNCi1Ub255DQo=
