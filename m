From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Delete an unnecessary check before the function
 call "acpi_ds_delete_walk_state"
Date: Wed, 24 Jun 2015 15:16:25 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D306826@ORSMSX112.amr.corp.intel.com>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <558A9864.2020608@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32844 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660AbbFXPQb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Jun 2015 11:16:31 -0400
In-Reply-To: <558A9864.2020608@users.sourceforge.net>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>

R290IGl0LCB0aGFua3MuDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBTRiBNYXJrdXMgRWxmcmluZyBbbWFpbHRvOmVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0
XQ0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjQsIDIwMTUgNDo0NiBBTQ0KPiBUbzogTGVuIEJy
b3duOyBaaGVuZywgTHY7IFd5c29ja2ksIFJhZmFlbCBKOyBNb29yZSwgUm9iZXJ0OyBsaW51eC0N
Cj4gYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGRldmVsQGFjcGljYS5vcmcNCj4gQ2M6IExLTUw7IGtl
cm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmc7IEp1bGlhIExhd2FsbA0KPiBTdWJqZWN0OiBb
UEFUQ0hdIEFDUElDQTogRGVsZXRlIGFuIHVubmVjZXNzYXJ5IGNoZWNrIGJlZm9yZSB0aGUgZnVu
Y3Rpb24NCj4gY2FsbCAiYWNwaV9kc19kZWxldGVfd2Fsa19zdGF0ZSINCj4gDQo+IEZyb206IE1h
cmt1cyBFbGZyaW5nIDxlbGZyaW5nQHVzZXJzLnNvdXJjZWZvcmdlLm5ldD4NCj4gRGF0ZTogV2Vk
LCAyNCBKdW4gMjAxNSAxMzozMzo0NyArMDIwMA0KPiANCj4gVGhlIGFjcGlfZHNfZGVsZXRlX3dh
bGtfc3RhdGUoKSBmdW5jdGlvbiB0ZXN0cyB3aGV0aGVyIGl0cyBhcmd1bWVudCBpcw0KPiBOVUxM
IGFuZCB0aGVuIHJldHVybnMgaW1tZWRpYXRlbHkuIFRodXMgdGhlIHRlc3QgYXJvdW5kIHRoZSBj
YWxsIGlzIG5vdA0KPiBuZWVkZWQuDQo+IA0KPiBUaGlzIGlzc3VlIHdhcyBkZXRlY3RlZCBieSB1
c2luZyB0aGUgQ29jY2luZWxsZSBzb2Z0d2FyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1
cyBFbGZyaW5nIDxlbGZyaW5nQHVzZXJzLnNvdXJjZWZvcmdlLm5ldD4NCj4gLS0tDQo+ICBkcml2
ZXJzL2FjcGkvYWNwaWNhL2RzbWV0aG9kLmMgfCA1ICstLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9hY3BpL2FjcGljYS9kc21ldGhvZC5jDQo+IGIvZHJpdmVycy9hY3BpL2FjcGljYS9kc21ldGhv
ZC5jIGluZGV4IDg1YmI5NTEuLjE4OGIyNTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYWNwaS9h
Y3BpY2EvZHNtZXRob2QuYw0KPiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2RzbWV0aG9kLmMN
Cj4gQEAgLTU3NCwxMCArNTc0LDcgQEAgY2xlYW51cDoNCj4gIAkvKiBPbiBlcnJvciwgd2UgbXVz
dCB0ZXJtaW5hdGUgdGhlIG1ldGhvZCBwcm9wZXJseSAqLw0KPiANCj4gIAlhY3BpX2RzX3Rlcm1p
bmF0ZV9jb250cm9sX21ldGhvZChvYmpfZGVzYywgbmV4dF93YWxrX3N0YXRlKTsNCj4gLQlpZiAo
bmV4dF93YWxrX3N0YXRlKSB7DQo+IC0JCWFjcGlfZHNfZGVsZXRlX3dhbGtfc3RhdGUobmV4dF93
YWxrX3N0YXRlKTsNCj4gLQl9DQo+IC0NCj4gKwlhY3BpX2RzX2RlbGV0ZV93YWxrX3N0YXRlKG5l
eHRfd2Fsa19zdGF0ZSk7DQo+ICAJcmV0dXJuX0FDUElfU1RBVFVTKHN0YXR1cyk7DQo+ICB9DQo+
IA0KPiAtLQ0KPiAyLjQuNA0KDQo=
