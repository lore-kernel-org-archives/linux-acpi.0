From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] acpi: Use NULL from <linux/stddef.h>
Date: Fri, 18 Nov 2016 02:27:06 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5313C8@ORSMSX110.amr.corp.intel.com>
References: <4f698429-49cf-689a-9eb5-978b182bb4bb@sandisk.com>
 <CAJZ5v0jof4-JV+Fm_bBa+Fzxe2dLZ5KfoPNhZ_KfxvWX_NHDdg@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E523C92@ORSMSX108.amr.corp.intel.com>
 <c272e98e-c4f7-3cfc-c8ef-6a0dd2511837@sandisk.com>
 <1AE640813FDE7649BE1B193DEA596E886A28FC56@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41815 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751802AbcKRC1I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Nov 2016 21:27:08 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A28FC56@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, Bart Van Assche <bart.vanassche@sandisk.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

SWYgd2UgZG9uJ3QgYWJzb2x1dGVseSBuZWVkIHRvIG1ha2UgYW55IGNoYW5nZXMgKGlmIGl0IGFp
bid0IGJyb2tlKSwgdGhlbiB3ZSBzaG91bGQgbm90IHRyeSB0byBmaXggaXQuDQpZZXMsIHRoZXJl
IGFyZSBzb21lIHN0cmFuZ2UgdGhpbmdzIGluIHRoZSBBQ1BJQ0EgaGVhZGVycy4NCg0KTWFraW5n
IHRoZSBBQ1BJQ0EgY29kZSBjb21waWxlIHdpdGggbWFueSBkaWZmZXJlbnQgQyBjb21waWxlcnMg
Zm9yIG1hbnkgZGlmZmVyZW50IG9wZXJhdGluZyBzeXN0ZW1zIGhhcyBiZWVuIGFuIGV4dHJlbWVs
eSBjaGFsbGVuZ2luZyBhbmQgZGlmZmljdWx0IHByb2plY3QuDQoNCkV2ZW4gdGhlIHNtYWxsZXN0
IGNoYW5nZSBoYXMgdGhlIHBvdGVudGlhbCB0byBjYXVzZSBwcm9ibGVtcyBlbHNld2hlcmUuDQoN
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBaaGVuZywgTHYNCj4gU2Vu
dDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxNiwgMjAxNiA5OjU1IFBNDQo+IFRvOiBCYXJ0IFZhbiBB
c3NjaGU7IE1vb3JlLCBSb2JlcnQ7IFJhZmFlbCBKLiBXeXNvY2tpDQo+IENjOiBSYWZhZWwgSi4g
V3lzb2NraTsgTGVuIEJyb3duOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSRTogW1BBVENIXSBhY3BpOiBVc2UgTlVMTCBmcm9tIDxsaW51eC9zdGRkZWYuaD4NCj4gDQo+
IEhpLA0KPiANCj4gPiBGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgW21haWx0bzpiYXJ0LnZhbmFzc2No
ZUBzYW5kaXNrLmNvbV0NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBhY3BpOiBVc2UgTlVMTCBm
cm9tIDxsaW51eC9zdGRkZWYuaD4NCj4gPg0KPiA+IE9uIDExLzE2LzIwMTYgMDk6MDggQU0sIE1v
b3JlLCBSb2JlcnQgd3JvdGU6DQo+ID4gPiBXaGF0IGlzIHRoZSBwb2ludCBvZiB0aGVzZSBjaGFu
Z2VzPw0KPiA+DQo+ID4gV2hhdCdzIHRoZSBwb2ludCBvZiByZWRlZmluaW5nIE5VTEw/IFdoYXQn
cyB0aGUgcG9pbnQgb2YgY2FzdGluZyBhDQo+ID4gdm9pZCBwb2ludGVyIHRvIHZvaWQgKj8NCj4g
DQo+IE1heWJlIHlvdSBvbmx5IG5lZWQgdG8gcHV0IHRoZSBmb2xsb3dpbmcgbGluZSBpbnRvIGFj
bGludXguaDoNCj4gKyNpbmNsdWRlIDxsaW51eC9zdGRkZWYuaD4gLyogTlVMTCAqLw0KPiANCj4g
QW5kIGxlYXZlIEFDUElDQSBwcm90ZWN0aW9uIHRoZXJlOg0KPiANCj4gI2lmbmRlZiBOVUxMDQo+
IC4uLg0KPiAjZW5kaWYNCj4gDQo+IEZvciBjaGFuZ2luZyAodm9pZCAqKSBOVUxMIHRvIE5VTEws
IHNvdW5kcyBtaW5vci4NCj4gSXQgY2FuIGJlIHRoZXJlIGZvciBvdGhlciBPU1BNcy4NCj4gDQo+
IFRoYW5rcw0KPiBMdg0K
