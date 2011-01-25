From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: thermal: Avoid CONFIG_NET compile dependency
Date: Tue, 25 Jan 2011 15:15:41 +0530
Message-ID: <D6D887BA8C9DFF48B5233887EF046541094488C038@bgsmsx502.gar.corp.intel.com>
References: <D6D887BA8C9DFF48B5233887EF046541094482F511@bgsmsx502.gar.corp.intel.com>
 <201101241135.23576.trenn@suse.de>
 <D6D887BA8C9DFF48B5233887EF046541094488BDF5@bgsmsx502.gar.corp.intel.com>
 <201101251020.03299.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57467 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab1AYJpq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jan 2011 04:45:46 -0500
In-Reply-To: <201101251020.03299.trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "jdelvare@novell.com" <jdelvare@novell.com>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>, Guenter Roeck <guenter.roeck@ericsson.com>

SGkgVGhvbWFzLA0KDQo+IA0KPiBJIHRoaW5rIGEgZ2VuZXJpYyB0aGVybWFsIG5ldGxpbmsgaW50
ZXJmYWNlIGNhbiBnZXQNCj4gaW1wbGVtZW50ZWQgc2VwYXJhdGVseSwgYmVzdCB3aXRob3V0IGxv
b2tpbmcgYXQgYW55IHNwZWNpZmljDQo+IGRyaXZlciBpbXBsZW1lbnRhdGlvbi4NCg0KQnkgZ2Vu
ZXJpYyBpbnRlcmZhY2UsIEkgdW5kZXJzdGFuZCwgYW55IHRoZXJtYWwgcmVsYXRlZCBkcml2ZXIs
DQpTaG91bGQgYmUgYWJsZSB0byB1c2UgaXQsIGJ5IHNlbmRpbmcgbmV0bGluayBldmVudHMgd2l0
aCBhDQpPcmlnaW5hdG9yIG9mIHRoZSBldmVudCwgYW5kIHRoZSB0eXBlIG9mIHRoZSBldmVudChh
cyB3ZSBkaXNjdXNzZWQNCmVhcmxpZXIsIHRoaXMgdHlwZSBpcyBvbmUgaW4gdGhlIGVudW0uLikN
Cg0KV2UgY2FuIGFkZCBtb3JlIGRldGFpbHMsIHRvIHRoZSBlbnVtIGFuZCBlbmhhbmNlIHRoZSBn
ZW5lcmljIG5ldGxpbmsNCkludGVyZmFjZS4NCg0KVGhlIHByb2JsZW0gSSBzZWUgaXMsIGhvdyBk
byB3ZSBnZXQgYSB1bmlxdWUgb3JpZ2luYXRvciBpZCwNCmZvciBldmVyeSB0aGVybWFsIGRyaXZl
ciB0aGF0IHdhbnRzIHRvIHNlbmQgZXZlbnRzLCB1bmxlc3MgaXQNCnJlZ2lzdGVycyB3aXRoIHRo
ZSB0aGVybWFsIGZyYW1ld29yaz8NClNvbWUgdGhvdWdodHM6DQoxLiBXZSBzaG91bGQgZGVmaW5l
IGEgbGlzdCBvZiBvcmlnaW5hdG9ycyBhcyBhbiBlbnVtKGxpa2UgZXZlbnRfdHlwZSkNCjIuIEp1
c3QgdXNlIHRoZSBnZXRfaWQgZnVuY3Rpb24odG8gZ2VuZXJhdGUgdW5pcXVlIGlkcykgZnJvbSB0
aGVybWFsIGZyYW1ld29yaw0KICAgd2l0aG91dCByZWdpc3RlcmluZyB3aXRoIGl0Lg0KDQpLaW5k
bHkgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cyBvbiB0aGlzLg0KDQo+IEJlc3Qgd291bGQgYmUg
dG8gcmV2ZXJ0IHRoZSBjdXJyZW50IHBhdGNoIGFuZCBzZW5kIGEgbW9yZSBnZW5lcmljDQo+IGlt
cGxlbWVudGF0aW9uIHdpdGggYXQgbGVhc3QgdGhlc2UgaW4gQ0MgKG9yIG90aGVyIGxpc3RzIG1h
aW50YWluaW5nDQo+IGRyaXZlcnMgd2hvIG1pZ2h0IG1ha2UgdXNlIG9mIGl0KToNCj4gcGxhdGZv
cm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmcNCj4gbGludXgtcG1AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcNCj4gDQo+IFRoZW4gcGVvcGxlIGNhbiBicmluZyBpbiB0aGVpciBuZWVkcyBh
bmQgZXZlbnR1YWxseQ0KPiBjb21lIHVwIHdpdGggY29kZSBtYWtpbmcgdXNlIG9mIGl0Lg0KDQpJ
IGNhbiBkbyB0aGUgY2xlYW51cCwgb25jZSB3ZSBmaW5hbGl6ZSBob3cgdG8gZ28gYWJvdXQgaXQu
DQoNClRoYW5rcywNCkR1cmdhDQoNCg==
