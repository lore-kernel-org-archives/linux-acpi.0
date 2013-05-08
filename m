From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [Patch] MCE, APEI: Don't enable CMCI when Firmware First mode
 is set in HEST for corrected machine checks
Date: Wed, 8 May 2013 22:22:00 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F2DA47F03@ORSMSX101.amr.corp.intel.com>
References: <1367881102.4518.68.camel@oc3432500282.ibm.com>
 <20130506232537.GF22041@pd.tnic>
 <1367897566.4518.83.camel@oc3432500282.ibm.com>
 <20130507131946.GC7633@pd.tnic>
 <1367941214.4518.90.camel@oc3432500282.ibm.com>
 <20130508212237.GI30955@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F2DA47E5E@ORSMSX101.amr.corp.intel.com>
 <20130508221501.GK30955@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32676 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195Ab3EHWWV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 May 2013 18:22:21 -0400
In-Reply-To: <20130508221501.GK30955@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Max Asbock <masbock@linux.vnet.ibm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>, "naveen.n.rao@in.ibm.com" <naveen.n.rao@in.ibm.com>, "ananth@in.ibm.com" <ananth@in.ibm.com>, "lcm@linux.vnet.ibm.com" <lcm@linux.vnet.ibm.com>

Pj4gMSkgU29tZSBiYW5rcyBtYXkgbm90IHN1cHBvcnQgQ01DSSBhdCBhbGwgKGJpdCAzMCBpbiBN
Q2lfQ1RMMiByZWdpc3Rlcg0KPj4gaWdub3JlcyBhdHRlbXB0cyB0byBlbmFibGUpLiBGb3IgdGhl
c2UgYmFua3MgTGludXggc2hvdWxkIHBvbGwuDQo+DQo+IFRoYXQncyB0aGUgZGV0ZWN0aW9uIG1l
dGhvZCwgdHJ5IHNldHRpbmcgYml0IDMwIHRvIHNlZSBpZiBpdCBzdGlja3M/DQoNClllcy4gU2Vl
IEludGVsIFNETSBWb2wgM0Igc2VjdGlvbiAiMTUuMy4yLjUgSUEzMl9NQ2lfQ1RMMiBNU1JzIg0K
DQo+PiAyKSBCSU9TIG1heSBzdXBwb3J0IGdlbmVyYXRpb24gb2YgQVBFSSByZWNvcmRzIGZvciBj
ZXJ0YWluIGNsYXNzZXMgb2YNCj4+IGVycm9ycy4gSEVTVCB3aWxsIHNheSB3aGljaCBiYW5rcyBh
cmUgYWZmZWN0ZWQsIGFuZCBpZiB3ZSBwcmVmZXIgQVBFSSwNCj4+IHdlIHNob3VsZCBkaXNhYmxl
IENNQ0kgZm9yIHRoZXNlIGJhbmtzIChhbmQgbm90IHBvbGwgdGhlbSkuDQoNCj4gT2ssIHNvIGl0
IGxvb2tzIGxpa2UgY29kZSBzaG91bGQgaXRlcmF0ZSBvdmVyIHRob3NlIGFuZCByZW1vdmUgdGhl
bSBmcm9tDQo+IHRoZSBtY2VfYmFua3MgbGlzdCB3ZSBwYXNzIG9uIHRvIG1hY2hpbmVfY2hlY2tf
cG9sbC4NCg0KSSB0aGluayBzby4gIHRoZSBtY2VfYmFua3MgYml0bWFwcyBrZWVwIHRyYWNrIG9m
IHdoaWNoIGNwdSBpcyByZXNwb25zaWJsZQ0KZm9yIGNoZWNraW5nIGEgYmFuayAoYmVjYXVzZSBi
YW5rcyBjYW4gYmUgc2hhcmVkIGJ5IG11bHRpcGxlIGNwdXMgLi4uIGUuZy4NCnNvY2tldCBsZXZl
bCBiYW5rIGlzIHNhbWUgdG8gYWxsIGxvZ2ljYWwgY3B1cyBvbiBhIHBhY2thZ2UuIENvcmUgbGV2
ZWwgYmFuaw0KaXMgc2hhcmVkIGJ5IGp1c3QgdGhlIHR3byBoeXBlcnRocmVhZHMgb24gYSBjb3Jl
KS4gIElmIHdlIHRydXN0IEFQRUkgdG8gaGFuZGxlDQp0aGluZ3MsIHRoZW4gdGhlIGJhbmsgc2hv
dWxkbid0IGJlIG93bmVkIGJ5IGFueSBjcHUuDQoNCj4+IDMpIFNvbWUgYmFua3MgbWF5IHN1cHBv
cnQgQ01DSSwgYnV0IGRvbid0IGhhdmUgQklPUyBzdXBwb3J0IHRvDQo+PiBnZW5lcmF0ZSBBUEVJ
IHJlY29yZHMuIFdlIHNob3VsZCBjb250aW51ZSB0byBlbmFibGUgQ01DSSBmb3IgdGhlc2UuDQo+
DQo+IEhvdyBkbyB5b3UgZ2V0IHRoYXQgb3V0IG9mIHRoZSBIRVNUPyBUaGUgaW5hYmlsaXR5IHRv
IGdlbmVyYXRlIEFQRUkNCj4gcmVjb3Jkcy4NCg0KUGVyaGFwcyBqdXN0IGJ5IHdoYXRldmVyIGJh
bmtzIHlvdSBmaW5kIGxlZnQgb3ZlciBhZnRlciBpdGVyYXRpbmcgdGhlIG9uZXMNCnRoYXQgKmFy
ZSogaW4gSEVTVD8gIFRoZXJlIGlzbid0IGFuIGV4cGxpY2l0IGxpc3QuDQoNCi1Ub255DQo=
