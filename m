From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: remove duplicate u8 typedef
Date: Wed, 29 Apr 2015 00:29:44 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880270FB14@SHSMSX101.ccr.corp.intel.com>
References: <1430232844-11018-1-git-send-email-olaf@aepfle.de>
 <1624281.lNzTEna4Ru@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29933 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031206AbbD2A3y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Apr 2015 20:29:54 -0400
In-Reply-To: <1624281.lNzTEna4Ru@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olaf Hering <olaf@aepfle.de>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

SGksDQoNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgW21haWx0bzpyandAcmp3eXNvY2tpLm5l
dF0NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAyOSwgMjAxNSA4OjQ0IEFNDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIEFDUElDQTogcmVtb3ZlIGR1cGxpY2F0ZSB1OCB0eXBlZGVmDQo+IA0KPiBP
biBUdWVzZGF5LCBBcHJpbCAyOCwgMjAxNSAwNDo1NDowNCBQTSBPbGFmIEhlcmluZyB3cm90ZToN
Cj4gPiBEdXJpbmcgY29tbWl0IGUyNTI2NTJmYjI2NjRkNDJkZTE5ZjkzM2FhMzY4OGJiYzQ3MGRl
M2YgKCJBQ1BJQ0E6DQo+ID4gYWNwaWR1bXA6IFJlbW92ZSBpbnRlZ2VyIHR5cGVzIHRyYW5zbGF0
aW9uIHByb3RlY3Rpb24uIikgdHdvICd1bnNpZ25lZA0KPiA+IGNoYXInIHR5cGVzIGdvdCBjb252
ZXJ0ZWQgdG8gJ3U4Jy4NCj4gPg0KPiA+IFRoZSByZXN1bHQgZG9lcyBub3QgY29tcGlsZSB3aXRo
IGdjYy00LjUsIGl0IGNhbiBub3QgY29wZSB3aXRoIGR1cGxpY2F0ZQ0KPiA+IHR5cGVkZWZzLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogT2xhZiBIZXJpbmcgPG9sYWZAYWVwZmxlLmRlPg0KPiAN
Cj4gQXBwbGllZCwgdGhhbmtzIQ0KPiANCj4gTHYsIGNhbiB5b3UgcGxlYXNlIHNlZSBpZiB0aGF0
J3MgYW4gdXBzdHJlYW0gaXNzdWUgdG9vPw0KDQpJbiBBQ1BJQ0EsIG9uZSB1OCBpcyBVSU5UOCBh
bmQgdGhlIG90aGVyIGlzIGZvciBCT09MRUFOLg0KUGxlYXMgbWVyZ2UgdGhpcyBmaXJzdC4NCkkn
bGwgdGhpbmsgYWJvdXQgYSBzb2x1dGlvbiB0byByZWR1Y2UgdGhpcyBkaXZlcmdlbmNlLg0KDQpU
aGFua3MgYW5kIGJlc3QgcmVnYXJkcw0KLUx2DQoNCj4gDQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUv
YWNwaS9hY3R5cGVzLmggfCAxIC0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2FjcGkvYWN0eXBlcy5oIGIvaW5jbHVkZS9h
Y3BpL2FjdHlwZXMuaA0KPiA+IGluZGV4IGY1Y2EwZTkuLjFjMzAwMmUgMTAwNjQ0DQo+ID4gLS0t
IGEvaW5jbHVkZS9hY3BpL2FjdHlwZXMuaA0KPiA+ICsrKyBiL2luY2x1ZGUvYWNwaS9hY3R5cGVz
LmgNCj4gPiBAQCAtMTI0LDcgKzEyNCw2IEBADQo+ID4gICNpZm5kZWYgQUNQSV9VU0VfU1lTVEVN
X0lOVFRZUEVTDQo+ID4NCj4gPiAgdHlwZWRlZiB1bnNpZ25lZCBjaGFyIHU4Ow0KPiA+IC10eXBl
ZGVmIHVuc2lnbmVkIGNoYXIgdTg7DQo+ID4gIHR5cGVkZWYgdW5zaWduZWQgc2hvcnQgdTE2Ow0K
PiA+ICB0eXBlZGVmIHNob3J0IHMxNjsNCj4gPiAgdHlwZWRlZiBDT01QSUxFUl9ERVBFTkRFTlRf
VUlOVDY0IHU2NDsNCj4gPiAtLQ0KPiA+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBsaXN0OiBz
ZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmliZSBsaW51eC1hY3BpIiBpbg0KPiA+IHRoZSBib2R5IG9m
IGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3JnDQo+ID4gTW9yZSBtYWpvcmRv
bW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1sDQo+
IA0KPiAtLQ0KPiBJIHNwZWFrIG9ubHkgZm9yIG15c2VsZi4NCj4gUmFmYWVsIEouIFd5c29ja2ks
IEludGVsIE9wZW4gU291cmNlIFRlY2hub2xvZ3kgQ2VudGVyLg0K
