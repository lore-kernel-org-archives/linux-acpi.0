From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 2/2] ACPI: ACPICA: Cleanup drivers/acpi/acpica Makefile
Date: Wed, 12 Apr 2017 02:11:12 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE90152@SHSMSX101.ccr.corp.intel.com>
References: <796420b4be45373de2e0c6148062fb8d8ddbbcb4.1490930522.git.lv.zheng@intel.com>
 <201704021640.4xwSssrU%fengguang.wu@intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CE8DA28@SHSMSX101.ccr.corp.intel.com>
 <CAJZ5v0hjA+VF3UG5+7Y+YpTMh48bXs6P6v0tnn9iRWBeKknHxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59891 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751992AbdDLCLQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Apr 2017 22:11:16 -0400
In-Reply-To: <CAJZ5v0hjA+VF3UG5+7Y+YpTMh48bXs6P6v0tnn9iRWBeKknHxw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "kbuild-all@01.org" <kbuild-all@01.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, lkp <lkp@intel.com>

SGksDQoNCj4gRnJvbTogbGludXgtYWNwaS1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzps
aW51eC1hY3BpLW93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIFJhZmFlbCBKLg0K
PiBXeXNvY2tpDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBBQ1BJOiBBQ1BJQ0E6IENsZWFu
dXAgZHJpdmVycy9hY3BpL2FjcGljYSBNYWtlZmlsZQ0KPiANCj4gT24gVHVlLCBBcHIgMTEsIDIw
MTcgYXQgOToxOSBBTSwgWmhlbmcsIEx2IDxsdi56aGVuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+
IEhpLCBSYWZhZWwNCj4gPg0KPiA+IEFjY29yZGluZyB0byB0aGUgdGVzdCwgUEFUQ0ggMDIgaXMg
bm90IHBvc3NpYmxlIHVubGVzcyBBQ1BJQ0EgZGVidWdnaW5nIGZ1bmN0aW9uIHN0dWJzIGFyZSBj
b3JyZWN0bHkNCj4gcHJlcGFyZWQgZm9yIEFDUElfREVCVUdfT1VUUFVUPW4uDQo+ID4gU28gcGxl
YXNlIGhlbHAgdG8gZHJvcCBQQVRDSCAwMiBhbmQgb25seSBQQVRDSCAwMSBpcyB1c2VmdWwgZm9y
IG5vdy4NCj4gDQo+IE9LDQo+IA0KPiBDYW4geW91IHBsZWFzZSByZXNlbmQgcGF0Y2ggWzEvMl0g
c2VwYXJhdGVseSwgdGhlbiwgYW5kIGxldCBtZSBrbm93DQo+IHdoYXQgaXMgc3VwZXJzZWRlZCBi
eSBpdD8NCg0KWWVzLCBpdCBpcyByZS1zZW50IGFuZCB5b3UgY2FuIGZpbmQgaXQgaGVyZToNCmh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3JhZmFlbC9saW51
eC1wbS5naXQvY29tbWl0Lz9pZD1mZmFiOTE4OGU0NA0KVGhlIG9ubHkgY2hhbmdlIGlzIHRvIGFk
ZCBUZXN0ZWQtYnkgdGFnIGZyb20gQWwgU3RvbmUgYWxvbmcgd2l0aCBjb3JyZWN0ZWQgZW1haWwg
YWRkcmVzcy4NCg0KVGhhbmtzLA0KTHYNCg0KPiANCj4gVGhhbmtzLA0KPiBSYWZhZWwNCj4gLS0N
Cj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vic2Ny
aWJlIGxpbnV4LWFjcGkiIGluDQo+IHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9A
dmdlci5rZXJuZWwub3JnDQo+IE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0dHA6Ly92Z2VyLmtl
cm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbA0K
