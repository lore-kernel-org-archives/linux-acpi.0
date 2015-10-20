From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 09/14] ACPICA: Debugger: Fix "quit/exit" command by
 cleaning up user commands termination logic
Date: Tue, 20 Oct 2015 02:03:35 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BAC93DE@SHSMSX101.ccr.corp.intel.com>
References: <98d60fa60319a9f62938628f78531f59d2fc9d2a.1445221165.git.lv.zheng@intel.com>
 <3263599.JhYyYcsC47@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:45400 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbbJTCDi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Oct 2015 22:03:38 -0400
In-Reply-To: <3263599.JhYyYcsC47@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

SSB3YXMgdXNpbmcgbGludXgtcG0uZ2l0L2xpbnV4LW5leHQgYmFzZSB3aGljaCBJIGRvd25sb2Fk
ZWQgYSB3ZWVrIGFnby4NCk1heWJlIHRoZSBjb25mbGljdCB3YXMgY2F1c2VkIGJ5IHRoZSBmYXN0
LXBhdGggQUNQSUNBIHRhYmxlIGZpeCBtZXJnZWQgYWZ0ZXIgbXkgZG93bmxvYWRpbmcuDQpMZXQg
bWUgY2hlY2sgYWdhaW4uDQoNClRoYW5rcyBhbmQgYmVzdCByZWdhcmRzDQotTHYNCg0KPiBGcm9t
OiBSYWZhZWwgSi4gV3lzb2NraSBbbWFpbHRvOnJqd0Byand5c29ja2kubmV0XQ0KPiBTZW50OiBU
dWVzZGF5LCBPY3RvYmVyIDIwLCAyMDE1IDU6MDQgQU0NCj4gDQo+IE9uIE1vbmRheSwgT2N0b2Jl
ciAxOSwgMjAxNSAxMDoyNTozMiBBTSBMdiBaaGVuZyB3cm90ZToNCj4gPiBBQ1BJQ0EgY29tbWl0
IDBkZDY4ZTE2Mjc0Y2QzODIyNGFhNDc4MWVkZGM1N2RjMmNiYWExMDgNCj4gPg0KPiA+IFRoZSBx
dWl0L2V4aXQgY29tbWFuZHMgc2hvdWxkbid0IGludm9rZSBhY3BpX3Rlcm1pbmF0ZV9kZWJ1Z2dl
cigpIGFuZA0KPiA+IGFjcGlfdGVybWluYXRlKCkgcmlnaHQgaW4gdGhlIHVzZXIgY29tbWFuZCBs
b29wLCBiZWNhdXNlIHdoZW4gdGhlIGRlYnVnZ2VyDQo+ID4gZXhpdHMsIHRoZSBrZXJuZWwgQUNQ
SSBzdWJzeXN0ZW0gc2hvdWxkbid0IGJlIHRlcm1pbmF0ZWQgKGFjcGlfdGVybWluYXRlKCkpDQo+
ID4gYW5kIHRoZSBkZWJ1Z2dlciBzaG91bGQgb25seSBiZSB0ZXJtaW5hdGVkIGJ5IGl0cyB1c2Vy
cw0KPiA+IChhY3BpX3Rlcm1pbmF0ZV9kZWJ1Z2dlcigpKSByYXRoZXIgdGhhbiBiZWluZyB0ZXJt
aW5hdGVkIGl0c2VsZi4gTGVhdmluZyBzdWNoDQo+ID4gaW52b2NhdGlvbnMgY2F1c2VzIGtlcm5l
bCBwYW5pYyB3aGVuIHRoZSBkZWJ1Z2dlciBpcyBzaGlwcGVkIGluIHRoZSBMaW51eA0KPiA+IGtl
cm5lbC4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggZml4ZXMgdGhpcyBpc3N1ZS4gTHYgWmhlbmcuDQo+
ID4NCj4gPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vYWNwaWNhL2FjcGljYS9jb21taXQvMGRk
NjhlMTYNCj4gPiBTaWduZWQtb2ZmLWJ5OiBMdiBaaGVuZyA8bHYuemhlbmdAaW50ZWwuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEJvYiBNb29yZSA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT4NCj4g
DQo+IFRoaXMgcGF0Y2ggZG9lcyBub3QgYXBwbHkgZm9yIG1lIG9uIHRvcCBvZiB0aGUgY3VycmVu
dCBtYWlubGluZS4NCj4gDQo+IFdoYXQgdHJlZSBpcyBpdCBhcHBsaWNhYmxlIHRvPw0KPiANCj4g
VGhhbmtzLA0KPiBSYWZhZWwNCg0K
