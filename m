From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v2 2/2] mce: acpi/apei: Add a boot option to disable ff
 mode for corrected errors
Date: Wed, 19 Jun 2013 21:28:50 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F2DA884F0@ORSMSX106.amr.corp.intel.com>
References: <20130619175438.2852.93449.stgit@localhost.localdomain>
 <20130619175728.2852.73156.stgit@localhost.localdomain>
 <20130619180441.GK28300@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F2DA88106@ORSMSX106.amr.corp.intel.com>
 <20130619183640.GL28300@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F2DA881C2@ORSMSX106.amr.corp.intel.com>
 <20130619201438.GM28300@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F2DA8838B@ORSMSX106.amr.corp.intel.com>
 <20130619210706.GP28300@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20365 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934566Ab3FSV27 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Jun 2013 17:28:59 -0400
In-Reply-To: <20130619210706.GP28300@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, "ananth@in.ibm.com" <ananth@in.ibm.com>, "masbock@linux.vnet.ibm.com" <masbock@linux.vnet.ibm.com>, "lcm@linux.vnet.ibm.com" <lcm@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>, Robert Richter <rric@kernel.org>

PiBPaywgd2hlcmUgaXMgdGhhdCBzZW1hbnRpY3M/IFdoYXQgaW4gYSBDUEVSIHJlY29yZCBkb2Vz
IHNheSAidGhpcyBlcnJvcg0KPiBzaG91bGQgdGVsbCB5b3UgdGhhdCB5b3UgbmVlZCB0byBvZmZs
aW5lIHRoZSBjb250YWluaW5nIHBhZ2UgYW5kIEknbQ0KPiB0ZWxsaW5nIHlvdSB0aGlzIGV4YWN0
bHkgb25seSBvbmNlIj8gRXJyb3IgU2V2ZXJpdHkgMCwgaS5lLiBSZWNvdmVyYWJsZT8NCg0KTmF2
ZWVuIC0gdGhpcyBvbmUgaXMgZm9yIHlvdSAob3IgZm9yIHlvdXIgQklPUyB0ZWFtKS4gIENhbiB5
b3UgZ2V0IHVzIGEgc2FtcGxlDQpDUEVSIHRoYXQgeW91IHBsYW4gdG8gcHJvdmlkZSB3aGVuIHRo
ZSBCSU9TIGRlY2lkZXMgdGhhdCBpdHMgdGhyZXNob2xkIGhhcw0KYmVlbiBleGNlZWRlZD8gIEhv
dyB3aWxsIGl0IGJlIGRpZmZlcmVudCBmcm9tIHdoYXQgb2xkIFdTTS1FWCBwbGF0Zm9ybXMNCndl
cmUgc2VuZGluZyB0byB1cz8gIEhvcGVmdWxseSB0aGUgYW5zd2VyIGlzIGVuY29kZWQgaW4gdGhl
IENQRVIgcmVjb3JkDQphbmQgbm90IGluIHNvbWUgY29kZSB3ZSBoYXZlIHRvIHB1dCBpbiBMaW51
eCB0byBzYXkgImlmIChJQk1wbGF0Zm9ybSkgZG9fdGhpbmdfMSgpOyBlbHNlIC4uLiAiDQoNCj4g
T2ssIHdlJ3JlIHRhbGtpbmcgYWJvdXQgdGhlIFMgaW4gUkFTIG5vdy4gRG8gd2UgaGF2ZSBlcnJv
ciByZWNvdmVyeQ0KPiBzdHJhdGVnaWVzIHNwZWNpZmllZCBhbnl3aGVyZT8gQXJlIHRoZXkgcGVy
LXBsYXRmb3JtIG9yIGdlbmVyaWM/IElzIHRoaXMNCj4gQ1BFUiBzdHJhdGVneSBhYm92ZSwgZm9y
IGV4YW1wbGUsIG9ubHkgdmFsaWQgZm9yIHNvbWUgcGxhdGZvcm1zIG9yIGZvcg0KPiBhbGwgQVBF
SS11c2luZyBoYXJkd2FyZT8NCg0KbWNlbG9nKDgpIGRhZW1vbiBoYXMgYmVlbiBkb2luZyB0aGlz
IGZvciB5ZWFycyAuLi4gYnV0IGl0IHVzZWQgdGhlICJwcmVkaWN0aXZlDQpmYWlsdXJlIGFuYWx5
c2lzIiBidXp6d29yZHMgdGhhdCB3ZXJlIHBvcHVsYXIgd2F5IGJhY2sgdGhlbiAodG9kYXkgdGhl
DQptYXJrZXRpbmcgcGVvcGxlIHNlZW0gdG8gcHJlZmVyICJzZWxmIGhlYWxpbmciICkuIFdoYXRl
dmVyIHRoZSBuYW1lLCB0aGUNCmNvbmNlcHQgaXMgdGhlIHNhbWUgLi4uIHRha2Ugc29tZSBzZXQg
b2YgY29ycmVjdGVkIGV2ZW50IHJlcG9ydHMgYW5kIGluZmVyDQpmcm9tIHRoZW0gdGhhdCBzb21l
dGhpbmcgd29yc2UgbWF5IGhhcHBlbiBzb29uLCBhbmQgdXNlIHRoYXQgaW5mb3JtYXRpb24NCnRv
IHRyeSB0byBhdm9pZCB0aGUgKHBvc3NpYmx5KSBpbXBlbmRpbmcgY3Jhc2guDQoNCj4gUXVlc3Rp
b25zIG92ZXIgcXVlc3Rpb25zLi4uDQoNClF1ZXN0aW9ucyBhcmUgZ29vZCAtIHRoZXkgaGVscCBm
aWxsIG91dCBnYXBzDQoNCi1Ub255DQo=
