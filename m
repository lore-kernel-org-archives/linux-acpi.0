From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 10/13] Thermal: Remove throttling logic out of
 thermal_sys.c
Date: Mon, 13 Aug 2012 08:04:03 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB5919A46B@BGSMSX101.gar.corp.intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
	 <1344516365-7230-11-git-send-email-durgadoss.r@intel.com>
 <1344841200.1682.794.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23693 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab2HMIEH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Aug 2012 04:04:07 -0400
In-Reply-To: <1344841200.1682.794.camel@rui.sh.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

SGkgUnVpLA0KDQpbY3V0Ll0NCj4gPiArc3RhdGljIHZvaWQgbm90aWZ5X3VzZXJfc3BhY2Uoc3Ry
dWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6LCBpbnQgdHJpcCkNCj4gPiArew0KPiA+ICsJbXV0
ZXhfbG9jaygmdHotPmxvY2spOw0KPiA+ICsNCj4gPiArCWtvYmplY3RfdWV2ZW50KCZ0ei0+ZGV2
aWNlLmtvYmosIEtPQkpfQ0hBTkdFKTsNCj4gPiArDQo+ID4gKwltdXRleF91bmxvY2soJnR6LT5s
b2NrKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgaGFuZGxlX25vbl9jcml0aWNh
bF90cmlwcyhzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHosDQo+ID4gKwkJCWludCB0cmlw
LCBlbnVtIHRoZXJtYWxfdHJpcF90eXBlIHRyaXBfdHlwZSkNCj4gPiArew0KPiA+ICsJaW50IHRo
cm90dGxlX3BvbGljeSA9IFRIRVJNQUxfU1RFUF9XSVNFOw0KPiA+ICsNCj4gPiArCWlmICh0ei0+
dHpwKQ0KPiA+ICsJCXRocm90dGxlX3BvbGljeSA9IHR6LT50enAtPnRocm90dGxlX3BvbGljeTsN
Cj4gPiArDQo+ID4gKwlzd2l0Y2ggKHRocm90dGxlX3BvbGljeSkgew0KPiA+ICsJY2FzZSBUSEVS
TUFMX0ZBSVJfU0hBUkU6DQo+ID4gKwkJZmFpcl9zaGFyZV90aHJvdHRsZSh0eiwgdHJpcCk7DQo+
ID4gKwkJYnJlYWs7DQo+ID4gKwljYXNlIFRIRVJNQUxfU1RFUF9XSVNFOg0KPiA+ICsJCXN0ZXBf
d2lzZV90aHJvdHRsZSh0eiwgdHJpcCk7DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwljYXNlIFRIRVJN
QUxfVVNFUl9TUEFDRToNCj4gPiArCQlub3RpZnlfdXNlcl9zcGFjZSh0eiwgdHJpcCk7DQo+ID4g
KwkJYnJlYWs7DQo+ID4gKwl9DQo+IA0KPiB0aGlzIGlzIGEgbGl0dGxlIGRpZmZlcmVudCBmcm9t
IHdoYXQgSSB0aG91Z2h0Lg0KPiBJTU8sIGVhY2ggcG9saWN5IHNob3VsZCByZWdpc3RlciBpdHMg
cG9pbnRlciB0byB0aGUgdGhlcm1hbCBmcmFtZXdvcmsuDQo+IGFuZCB0ei0+dHpwIHBvaW50cyB0
byB0aGUgcG9pbnRlciBvZiB0aGUgcG9saWN5IHVzaW5nLg0KPiBhbmQgdGhlbiwgaW4gaGFuZGxl
X25vbl9jcml0aWNhbF90cmlwcygpLCB0aGUgY29kZSB3b3VsZCBiZSBsaWtlIHRoaXM6DQo+IGlm
KHR6LT50enApDQo+IAl0ei0+dHpwLT50aHJvdHRsZSh0eiwgdHJpcCk7DQo+IA0KPiBCdXQgdGhp
cyBpcyBhbHNvIG9rYXkgZm9yIG5vdywgYmVjYXVzZSB3ZSBoYXZlIG9ubHkgb25lIGNhbGxiYWNr
IGZvcg0KPiBlYWNoIHBvbGljeS4NCg0KSSBjb21wbGV0ZWx5IGFncmVlIHdpdGggeW91IGhlcmUu
IFdoZW4gSSB3YXMgZG9pbmcgbXkgaW5pdGlhbCBkZXZlbG9wbWVudCwNCkkgZm91bmQgdGhhdCBz
b21lIHBvbGljaWVzIG5lZWQgdHdvIGFyZ3VtZW50cy8gc29tZSBuZWVkIHRocmVlIGV0Yy4uDQpU
aGF04oCZcyB3aHkgY291bGQgbm90IGRvIGEgZnVuY3Rpb24gcG9pbnRlciBpbXBsZW1lbnRhdGlv
bi4NCg0KV2lsbCB0cnkgdG8gZml4IGl0IHVwIGluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBh
dGNoZXMuDQoNClRoYW5rIHlvdSwNCkR1cmdhDQo=
