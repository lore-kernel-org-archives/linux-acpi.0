From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] acpica: modify a commit error in file
 drivers/acpi/acpica/nsxfeval.c
Date: Mon, 13 Apr 2015 17:42:45 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2BD73F@ORSMSX112.amr.corp.intel.com>
References: <1428915907-14302-1-git-send-email-gongzhaogang@inspur.com>
 <1536129.vQOiq1xQa9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33147 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996AbbDMRms (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Apr 2015 13:42:48 -0400
In-Reply-To: <1536129.vQOiq1xQa9@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhaogang Gong <gongzhaogang@inspur.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yanxiaofeng@inspur.com" <yanxiaofeng@inspur.com>

WWVzLCB0aGlzIGNvbWVzIHVwIGV2ZXJ5IG5vdyBhbmQgdGhlbi4NCg0KImlmZiIgbWVhbnMgImlm
IGFuZCBvbmx5IGlmIiBieSBjb252ZW50aW9uLg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgW21haWx0bzpyandAcmp3eXNvY2tpLm5l
dF0NCj4gU2VudDogTW9uZGF5LCBBcHJpbCAxMywgMjAxNSA2OjM4IEFNDQo+IFRvOiBaaGFvZ2Fu
ZyBHb25nDQo+IENjOiBNb29yZSwgUm9iZXJ0OyBaaGVuZywgTHY7IFd5c29ja2ksIFJhZmFlbCBK
OyBsZW5iQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBhY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgeWFueGlhb2ZlbmdAaW5zcHVyLmNvbQ0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBhY3BpY2E6IG1vZGlmeSBhIGNvbW1pdCBlcnJvciBpbiBmaWxlDQo+IGRy
aXZlcnMvYWNwaS9hY3BpY2EvbnN4ZmV2YWwuYw0KPiANCj4gT24gTW9uZGF5LCBBcHJpbCAxMywg
MjAxNSAwNTowNTowNyBQTSBaaGFvZ2FuZyBHb25nIHdyb3RlOg0KPiA+IENoYW5nZSAiaWZmIiBp
biBmdW5jdGlvbiBhY3BpX2V2YWx1YXRlX29iamVjdCgpIHRvICJpZiIuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBaaGFvZ2FuZyBHb25nIDxnb25nemhhb2dhbmdAaW5zcHVyLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9hY3BpL2FjcGljYS9uc3hmZXZhbC5jIHwgMiArLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaWNhL25zeGZldmFsLmMNCj4gPiBiL2RyaXZlcnMvYWNw
aS9hY3BpY2EvbnN4ZmV2YWwuYyBpbmRleCBiNjAzMGEyLi45NTcxNDI5IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvbnN4ZmV2YWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYWNw
aS9hY3BpY2EvbnN4ZmV2YWwuYw0KPiA+IEBAIC0yMTQsNyArMjE0LDcgQEAgYWNwaV9ldmFsdWF0
ZV9vYmplY3QoYWNwaV9oYW5kbGUgaGFuZGxlLA0KPiA+ICAJCWluZm8tPnByZWZpeF9ub2RlID0g
TlVMTDsNCj4gPiAgCX0gZWxzZSBpZiAoIWhhbmRsZSkgew0KPiA+ICAJCS8qDQo+ID4gLQkJICog
QSBoYW5kbGUgaXMgb3B0aW9uYWwgaWZmIGEgZnVsbHkgcXVhbGlmaWVkIHBhdGhuYW1lIGlzDQo+
IHNwZWNpZmllZC4NCj4gPiArCQkgKiBBIGhhbmRsZSBpcyBvcHRpb25hbCBpZiBhIGZ1bGx5IHF1
YWxpZmllZCBwYXRobmFtZSBpcw0KPiBzcGVjaWZpZWQuDQo+IA0KPiBUaGlzIGlzIG5vdCBhIG1p
c3Rha2UuDQo+IA0KPiA+ICAJCSAqIFNpbmNlIHdlJ3ZlIGFscmVhZHkgaGFuZGxlZCBmdWxseSBx
dWFsaWZpZWQgbmFtZXMgYWJvdmUsDQo+IHRoaXMgaXMNCj4gPiAgCQkgKiBhbiBlcnJvci4NCj4g
PiAgCQkgKi8NCj4gPg0KPiANCj4gLS0NCj4gSSBzcGVhayBvbmx5IGZvciBteXNlbGYuDQo+IFJh
ZmFlbCBKLiBXeXNvY2tpLCBJbnRlbCBPcGVuIFNvdXJjZSBUZWNobm9sb2d5IENlbnRlci4NCg==
