From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 09/14] ACPICA: Debugger: Fix "quit/exit" command by
 cleaning up user commands termination logic
Date: Tue, 20 Oct 2015 07:14:14 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BAC95F8@SHSMSX101.ccr.corp.intel.com>
References: <98d60fa60319a9f62938628f78531f59d2fc9d2a.1445221165.git.lv.zheng@intel.com>
 <3263599.JhYyYcsC47@vostro.rjw.lan>
 <1AE640813FDE7649BE1B193DEA596E883BAC93DE@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:23618 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbbJTHOj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Oct 2015 03:14:39 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BAC93DE@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

SXQgbG9va3MgcGF0Y2ggMDggaXMgbm90IGxpc3RlZCBvbiB0aGUgaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWFjcGkvbGlzdC8uDQpJIGp1c3QgcmUtc2VudCBpdCwg
aG9wZSBpdCBjb3VsZCByZWFjaCB0aGUgbWFpbGluZyBsaXN0IHRoaXMgdGltZS4NCkknbGwgYWxz
byBzZW5kIGl0IGluIGF0dGFjaG1lbnQgc3R5bGUgdmlhIHByaXZhdGUgcm91dGUgdG8geW91Lg0K
DQpUaGFua3MgYW5kIGJlc3QgcmVnYXJkcw0KLUx2DQoNCj4gRnJvbTogbGludXgtYWNwaS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1hY3BpLW93bmVyQHZnZXIua2VybmVsLm9y
Z10gT24gQmVoYWxmIE9mIFpoZW5nLCBMdg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIwLCAy
MDE1IDEwOjA0IEFNDQo+IA0KPiBJIHdhcyB1c2luZyBsaW51eC1wbS5naXQvbGludXgtbmV4dCBi
YXNlIHdoaWNoIEkgZG93bmxvYWRlZCBhIHdlZWsgYWdvLg0KPiBNYXliZSB0aGUgY29uZmxpY3Qg
d2FzIGNhdXNlZCBieSB0aGUgZmFzdC1wYXRoIEFDUElDQSB0YWJsZSBmaXggbWVyZ2VkIGFmdGVy
IG15IGRvd25sb2FkaW5nLg0KPiBMZXQgbWUgY2hlY2sgYWdhaW4uDQo+IA0KPiBUaGFua3MgYW5k
IGJlc3QgcmVnYXJkcw0KPiAtTHYNCj4gDQo+ID4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgW21h
aWx0bzpyandAcmp3eXNvY2tpLm5ldF0NCj4gPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIwLCAy
MDE1IDU6MDQgQU0NCj4gPg0KPiA+IE9uIE1vbmRheSwgT2N0b2JlciAxOSwgMjAxNSAxMDoyNToz
MiBBTSBMdiBaaGVuZyB3cm90ZToNCj4gPiA+IEFDUElDQSBjb21taXQgMGRkNjhlMTYyNzRjZDM4
MjI0YWE0NzgxZWRkYzU3ZGMyY2JhYTEwOA0KPiA+ID4NCj4gPiA+IFRoZSBxdWl0L2V4aXQgY29t
bWFuZHMgc2hvdWxkbid0IGludm9rZSBhY3BpX3Rlcm1pbmF0ZV9kZWJ1Z2dlcigpIGFuZA0KPiA+
ID4gYWNwaV90ZXJtaW5hdGUoKSByaWdodCBpbiB0aGUgdXNlciBjb21tYW5kIGxvb3AsIGJlY2F1
c2Ugd2hlbiB0aGUgZGVidWdnZXINCj4gPiA+IGV4aXRzLCB0aGUga2VybmVsIEFDUEkgc3Vic3lz
dGVtIHNob3VsZG4ndCBiZSB0ZXJtaW5hdGVkIChhY3BpX3Rlcm1pbmF0ZSgpKQ0KPiA+ID4gYW5k
IHRoZSBkZWJ1Z2dlciBzaG91bGQgb25seSBiZSB0ZXJtaW5hdGVkIGJ5IGl0cyB1c2Vycw0KPiA+
ID4gKGFjcGlfdGVybWluYXRlX2RlYnVnZ2VyKCkpIHJhdGhlciB0aGFuIGJlaW5nIHRlcm1pbmF0
ZWQgaXRzZWxmLiBMZWF2aW5nIHN1Y2gNCj4gPiA+IGludm9jYXRpb25zIGNhdXNlcyBrZXJuZWwg
cGFuaWMgd2hlbiB0aGUgZGVidWdnZXIgaXMgc2hpcHBlZCBpbiB0aGUgTGludXgNCj4gPiA+IGtl
cm5lbC4NCj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoIGZpeGVzIHRoaXMgaXNzdWUuIEx2IFpoZW5n
Lg0KPiA+ID4NCj4gPiA+IExpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9hY3BpY2EvYWNwaWNhL2Nv
bW1pdC8wZGQ2OGUxNg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTHYgWmhlbmcgPGx2LnpoZW5nQGlu
dGVsLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEJvYiBNb29yZSA8cm9iZXJ0Lm1vb3JlQGlu
dGVsLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggZG9lcyBub3QgYXBwbHkgZm9yIG1lIG9uIHRv
cCBvZiB0aGUgY3VycmVudCBtYWlubGluZS4NCj4gPg0KPiA+IFdoYXQgdHJlZSBpcyBpdCBhcHBs
aWNhYmxlIHRvPw0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IFJhZmFlbA0KPiANCj4gTu+/ve+/ve+/
ve+/ve+/vXLvv73vv71577+977+977+9Yu+/vVjvv73vv73Hp3bvv71e77+9Kd66ey5u77+9K++/
ve+/ve+/ve+/vXvvv71p77+9Yu+/vXthee+/vR3Kh9qZ77+9LGoN77+977+9Zu+/ve+/ve+/vWjv
v73vv73vv71677+9Hu+/vXfvv73vv73vv70NCj4gDQo+IO+/ve+/ve+/vWo6K3bvv73vv73vv713
77+9au+/vW3vv73vv73vv73vv70N77+977+977+977+9elor77+977+977+977+977+93aJqIu+/
ve+/vSHvv71pDQo=
