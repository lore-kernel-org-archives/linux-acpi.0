From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2] Xen/ACPI: support sleep state entering on hardware
 reduced systems
Date: Tue, 12 Mar 2013 00:59:20 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88C1A230@SHSMSX101.ccr.corp.intel.com>
References: <513DB68E02000078000C4864@nat28.tlf.novell.com>
 <20130311135322.GA25036@phenom.dumpdata.com>
 <513DF30B02000078000C49EB@nat28.tlf.novell.com>
 <2127236.DctbS7jp3r@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:53620 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754958Ab3CLBBU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Mar 2013 21:01:20 -0400
In-Reply-To: <2127236.DctbS7jp3r@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Jan Beulich <JBeulich@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Wei, Gang" <gang.wei@intel.com>, "Maliszewski, Richard L" <richard.l.maliszewski@intel.com>, "Wang, Shane" <shane.wang@intel.com>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xen.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

PiA+ICsjaW5jbHVkZSA8bGludXgvYWNwaS5oPg0KDQpUaGlzIGxpbmUgc2hvdWxkbid0IGFwcGVh
ciBpbiBBQ1BJQ0EgY29kZXMgKGRyaXZlcnMvYWNwaS9hY3BpY2EpLg0KUGxlYXNlIHRyeSB0byBk
ZWNsYXJlIE9TTCBpbnRlcmZhY2VzIHZpYSBpbmNsdWRlL2FjcGkvcGxhdGZvcm0vYWNsaW51eC5o
Lg0KDQo+ID4NCj4gPiArCXN0YXR1cyA9IGFjcGlfb3NfcHJlcGFyZV9zbGVlcChzbGVlcF9zdGF0
ZSwgYWNwaV9nYmxfc2xlZXBfdHlwZV9hLA0KPiA+ICsJCQkJICAgICAgIGFjcGlfZ2JsX3NsZWVw
X3R5cGVfYiwgdHJ1ZSk7DQoNCmJvb2wgaXMgbm90IHVzZWQgaW4gQUNQSUNBLCBwbGVhc2UgdHJ5
IHU4IGluc3RlYWQuDQoNCj4gPiAgCXN0YXR1cyA9IGFjcGlfb3NfcHJlcGFyZV9zbGVlcChzbGVl
cF9zdGF0ZSwgcG0xYV9jb250cm9sLA0KPiA+IC0JCQkJICAgICAgIHBtMWJfY29udHJvbCk7DQo+
ID4gKwkJCQkgICAgICAgcG0xYl9jb250cm9sLCBmYWxzZSk7DQoNCkxpa2V3aXNlLg0KDQo+ID4g
LWFjcGlfc3RhdHVzIGFjcGlfb3NfcHJlcGFyZV9zbGVlcCh1OCBzbGVlcF9zdGF0ZSwgdTMyIHBt
MWFfY29udHJvbCwNCj4gPiAtCQkJCSAgdTMyIHBtMWJfY29udHJvbCkNCj4gPiArYWNwaV9zdGF0
dXMgYWNwaV9vc19wcmVwYXJlX3NsZWVwKHU4IHNsZWVwX3N0YXRlLCB1MzIgdmFsX2EsIHUzMiB2
YWxfYiwNCj4gPiArCQkJCSAgYm9vbCBleHRlbmRlZCkNCg0KSXMgdGhpcyBhbiBBQ1BJQ0EgT1NM
IGludGVyZmFjZT8gVGhlbiBpdCBzaG91bGQgbm90IGluY2x1ZGUgYm9vbCBwYXJhbWV0ZXIuDQoN
ClRoYW5rcw0KLUx2DQoNCg==
