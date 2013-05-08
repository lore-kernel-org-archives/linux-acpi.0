From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [Patch] MCE, APEI: Don't enable CMCI when Firmware First mode
 is set in HEST for corrected machine checks
Date: Wed, 8 May 2013 21:55:28 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F2DA47E5E@ORSMSX101.amr.corp.intel.com>
References: <1367881102.4518.68.camel@oc3432500282.ibm.com>
 <20130506232537.GF22041@pd.tnic>
 <1367897566.4518.83.camel@oc3432500282.ibm.com>
 <20130507131946.GC7633@pd.tnic>
 <1367941214.4518.90.camel@oc3432500282.ibm.com>
 <20130508212237.GI30955@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58824 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520Ab3EHVza (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 May 2013 17:55:30 -0400
In-Reply-To: <20130508212237.GI30955@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Max Asbock <masbock@linux.vnet.ibm.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>, "naveen.n.rao@in.ibm.com" <naveen.n.rao@in.ibm.com>, "ananth@in.ibm.com" <ananth@in.ibm.com>, "lcm@linux.vnet.ibm.com" <lcm@linux.vnet.ibm.com>

PiBCZWNhdXNlIGlmIHllcywgeW91IHdvbid0IG5lZWQgYW55IG9mIHRoZSBIRVNUIGhlYWRlciBw
YXJzaW5nIGhlcmUuIFNvDQo+IHdoYXQncyB1cD8NCg0KSSB0aGlua1sxXSBIRVNUIGNhbiB0ZWxs
IHlvdSB3aGljaCBiYW5rcyByZXBvcnQgdXNpbmcgQVBFSSAoYXMgd2VsbCBhcy9pbnN0ZWFkIG9m
KSBDTUNJLg0KDQpTbyBhIGZ1bGwgc29sdXRpb24gc2hvdWxkIHRha2UgaW50byBhY2NvdW50IGxv
dHMgb2YgcG9zc2liaWxpdGllczoNCg0KMSkgU29tZSBiYW5rcyBtYXkgbm90IHN1cHBvcnQgQ01D
SSBhdCBhbGwgKGJpdCAzMCBpbiBNQ2lfQ1RMMiByZWdpc3RlciBpZ25vcmVzIGF0dGVtcHRzIHRv
IGVuYWJsZSkuIEZvciB0aGVzZSBiYW5rcyBMaW51eCBzaG91bGQgcG9sbC4NCjIpIEJJT1MgbWF5
IHN1cHBvcnQgZ2VuZXJhdGlvbiBvZiBBUEVJIHJlY29yZHMgZm9yIGNlcnRhaW4gY2xhc3NlcyBv
ZiBlcnJvcnMuIEhFU1Qgd2lsbCBzYXkgd2hpY2ggYmFua3MgYXJlIGFmZmVjdGVkLCBhbmQgaWYg
d2UgcHJlZmVyIEFQRUksIHdlIHNob3VsZCBkaXNhYmxlIENNQ0kgZm9yIHRoZXNlIGJhbmtzIChh
bmQgbm90IHBvbGwgdGhlbSkuDQozKSBTb21lIGJhbmtzIG1heSBzdXBwb3J0IENNQ0ksIGJ1dCBk
b24ndCBoYXZlIEJJT1Mgc3VwcG9ydCB0byBnZW5lcmF0ZSBBUEVJIHJlY29yZHMuICBXZSBzaG91
bGQgY29udGludWUgdG8gZW5hYmxlIENNQ0kgZm9yIHRoZXNlLg0KDQpXZSBzaG91bGQgYWxzbyB0
YWtlIGFkdmFudGFnZSBvZiBtb3JlIGluZm9ybWF0aW9uIHByb3ZpZGVkIGluIHRoZSBBUEVJIHJl
Y29yZC4gIFdlIG9ubHkgbG9vayBhdCBtZW1fZXJyLT5waHlzaWNhbF9hZGRyIGZvciBtZW1vcnkg
ZXJyb3JzIC0gYnV0IHRoZXJlIGFyZSBhIHRvbiBvZiBvdGhlciBwb3RlbnRpYWxseSBpbnRlcmVz
dGluZyB0aGluZ3MgaW4gdGhlcmUuDQoNCi1Ub255DQoNClsxXSBCdXQgSSBtYXkgYmUgbWlzcmVh
ZGluZyBBQ1BJIHNwZWMgLSB1bmZvcnR1bmF0ZWx5IGl0IGp1c3QgaGFzIGRlc2NyaXB0aW9ucyBv
ZiAqd2hhdCogYml0cyBkbywgYnV0IG5vIHJhdGlvbmFsZSBhcyB0byAqd2h5KiBhbnlvbmUgd291
bGQgd2FudCB0byB1c2UgdGhlbSwgb3IgdHJhZGVvZmZzIGJldHdlZW4gZGlmZmVyZW50IG9wZXJh
dGluZyBtb2Rlcy4gV2lsbGluZyB0byBiZSByZS1lZHVjYXRlZCBpZiB0aGlzIGlzIGFsbCBob3Jy
aWJseSB3cm9uZy4NCg==
