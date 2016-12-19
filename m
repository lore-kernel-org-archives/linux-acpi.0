From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] acpi: Fix format string type mistakes
Date: Mon, 19 Dec 2016 21:45:44 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E547D9A@ORSMSX110.amr.corp.intel.com>
References: <20161216215137.GA96800@beast>
 <CAJZ5v0h-xUXNHgr5x4ZYRAvsUZDip65aYCPVPeZ3E9=djcpQnA@mail.gmail.com>
 <CAGXu5jKc35OzaPCR-f34THEkmE4ZbPP-cW2BVFzTgPYVmT_5dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:41149 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753160AbcLSVpq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Dec 2016 16:45:46 -0500
In-Reply-To: <CAGXu5jKc35OzaPCR-f34THEkmE4ZbPP-cW2BVFzTgPYVmT_5dw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Emese Revfy <re.emese@gmail.com>, "devel@acpica.org" <devel@acpica.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbToga2Vlc2Nvb2tAZ29vZ2xl
LmNvbSBbbWFpbHRvOmtlZXNjb29rQGdvb2dsZS5jb21dIE9uIEJlaGFsZiBPZiBLZWVzDQo+IENv
b2sNCj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAxNiwgMjAxNiAzOjA0IFBNDQo+IFRvOiBSYWZh
ZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IENjOiBNb29yZSwgUm9iZXJ0IDxy
b2JlcnQubW9vcmVAaW50ZWwuY29tPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdA0KPiA8bGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFpoZW5nLCBMdiA8bHYuemhlbmdAaW50ZWwuY29t
PjsgV3lzb2NraSwNCj4gUmFmYWVsIEogPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPjsgTGVu
IEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+OyBBQ1BJDQo+IERldmVsIE1hbGluZyBMaXN0IDxsaW51
eC1hY3BpQHZnZXIua2VybmVsLm9yZz47IEVtZXNlIFJldmZ5DQo+IDxyZS5lbWVzZUBnbWFpbC5j
b20+OyBkZXZlbEBhY3BpY2Eub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFjcGk6IEZpeCBm
b3JtYXQgc3RyaW5nIHR5cGUgbWlzdGFrZXMNCj4gDQo+IE9uIEZyaSwgRGVjIDE2LCAyMDE2IGF0
IDI6MzYgUE0sIFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4NCj4gd3JvdGU6
DQo+ID4gT24gRnJpLCBEZWMgMTYsIDIwMTYgYXQgMTA6NTEgUE0sIEtlZXMgQ29vayA8a2Vlc2Nv
b2tAY2hyb21pdW0ub3JnPg0KPiB3cm90ZToNCj4gPj4gRnJvbTogRW1lc2UgUmV2ZnkgPHJlLmVt
ZXNlQGdtYWlsLmNvbT4NCj4gPj4NCj4gPj4gVGhpcyBhZGRzIHRoZSBtaXNzaW5nIF9fcHJpbnRm
IGF0dHJpYnV0ZSB3aGljaCBhbGxvd3MgY29tcGlsZSB0aW1lDQo+ID4+IGZvcm1hdCBzdHJpbmcg
Y2hlY2tpbmcgKGFuZCB3aWxsIGJlIHVzZWQgYnkgdGhlIGNvbWluZyBpbml0aWZ5IGdjYw0KPiA+
PiBwbHVnaW4pLiBBZGRpdGlvbmFsbHksIHRoaXMgZml4ZXMgdGhlIHdhcm5pbmdzIGV4cG9zZWQg
YnkgdGhlDQo+IGF0dHJpYnV0ZS4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogRW1lc2UgUmV2
ZnkgPHJlLmVtZXNlQGdtYWlsLmNvbT4NCj4gPj4gW2tlZXM6IHNwbGl0IHNjc2kvYWNwaSwgbWVy
Z2VkIGF0dHIgYW5kIGZpeCwgbmV3IGNvbW1pdCBtZXNzYWdlc10NCj4gPj4gU2lnbmVkLW9mZi1i
eTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+DQo+ID4NCj4gPiBUaGlzIG1vZGlm
aWVzIGNvZGUgdGhhdCB3ZSBnZXQgZnJvbSBhbiBleHRlcm5hbCBwcm9qaWVjdCAoQUNQSUNBKSBh
bmQNCj4gPiB0aGUgYnVncyBzaG91bGQgYmUgZml4ZWQgaW4gdGhlcmUgaW4gdGhlIGZpcnN0IHBs
YWNlLg0KPiANCj4gV2hvIHNob3VsZCBnZXQgQ0NlZD8NCj4gDQo+ID4gTW9yZW92ZXIsIEknbSBu
b3Qgc3VyZSBpZiBhZGRpbmcgX19wcmludGYgaW4gYWNwaW9zeGYuaCBpcyBhIGdvb2QNCj4gaWRl
YS4NCj4gDQo+IFdoeSBub3Q/IFRoaXMgaXMgZ29pbmcgdG8gYmUgbmVlZGVkIGJ5IHRoZSBpbml0
aWZ5IHBsdWdpbiB0byBkbyBjb3JyZWN0DQo+IGRldGVjdGlvbiBvZiB3aGF0J3MgYmVpbmcgcGFz
c2VkIGFyb3VuZCB0byBmdW5jdGlvbnMuLi4NCj4gDQoNCltNb29yZSwgUm9iZXJ0XSBJdCdzIGNv
bXBpbGVyLWRlcGVuZGVudC4NCg0KPiAtS2Vlcw0KPiANCj4gLS0NCj4gS2VlcyBDb29rDQo+IE5l
eHVzIFNlY3VyaXR5DQo=
