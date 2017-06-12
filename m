From: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v1 1/3] mfd: Add new mfd device TPS68470
Date: Mon, 12 Jun 2017 09:20:06 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A59725BF469@FMSMSX114.amr.corp.intel.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-2-git-send-email-rajmohan.mani@intel.com>
 <CAHp75VfiTM2t=WxWpG4+kUfGA3DrfGfMOwxP6Cs42nGwHjAp7w@mail.gmail.com>
 <20170607115827.GY1019@valkosipuli.retiisi.org.uk>
 <6F87890CF0F5204F892DEA1EF0D77A59725BECB0@FMSMSX114.amr.corp.intel.com>
 <20170612082038.x6z3rx2bknxmfyfp@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170612082038.x6z3rx2bknxmfyfp@dell>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Sakari Ailus <sakari.ailus@iki.fi>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

SGkgTGVlLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8zXSBtZmQ6IEFkZCBuZXcgbWZk
IGRldmljZSBUUFM2ODQ3MA0KPiANCj4gT24gRnJpLCAwOSBKdW4gMjAxNywgTWFuaSwgUmFqbW9o
YW4gd3JvdGU6DQo+IA0KPiA+IEhpIEFuZHksDQo+ID4NCj4gPiA+IE9uIFR1ZSwgSnVuIDA2LCAy
MDE3IGF0IDAzOjU5OjQ5UE0gKzAzMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPiA+ID4g
T24gVHVlLCBKdW4gNiwgMjAxNyBhdCAyOjU1IFBNLCBSYWptb2hhbiBNYW5pDQo+ID4gPiA8cmFq
bW9oYW4ubWFuaUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+IFRoZSBUUFM2ODQ3MCBkZXZp
Y2UgaXMgYW4gYWR2YW5jZWQgcG93ZXIgbWFuYWdlbWVudCB1bml0IHRoYXQNCj4gPiA+ID4gPiBw
b3dlcnMgYSBDb21wYWN0IENhbWVyYSBNb2R1bGUgKENDTSksIGdlbmVyYXRlcyBjbG9ja3MgZm9y
IGltYWdlDQo+ID4gPiA+ID4gc2Vuc29ycywgZHJpdmVzIGEgZHVhbCBMRUQgZm9yIEZsYXNoIGFu
ZCBpbmNvcnBvcmF0ZXMgdHdvIExFRA0KPiA+ID4gPiA+IGRyaXZlcnMgZm9yIGdlbmVyYWwgcHVy
cG9zZSBpbmRpY2F0b3JzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhpcyBwYXRjaCBhZGRzIHN1
cHBvcnQgZm9yIFRQUzY4NDcwIG1mZCBkZXZpY2UuDQo+ID4gPiA+DQo+ID4gPiA+IEkgZHVubm8g
d2h5IHlvdSBkZWNpZGUgdG8gc2VuZCB0aGlzIG91dCBub3csIHNlZSBteSBjb21tZW50cyBiZWxv
dy4NCj4gPiA+ID4NCj4gPiA+ID4gPiArc3RhdGljIGludCB0cHM2ODQ3MF9jaGlwX2luaXQoc3Ry
dWN0IHRwczY4NDcwICp0cHMpIHsNCj4gPiA+ID4gPiArICAgICAgIHVuc2lnbmVkIGludCB2ZXJz
aW9uOw0KPiA+ID4gPiA+ICsgICAgICAgaW50IHJldDsNCj4gPiA+ID4NCj4gPiA+ID4gPiArICAg
ICAgIC8qIEZJWE1FOiBjb25maWd1cmUgdGhlc2UgZHluYW1pY2FsbHkgKi8NCj4gPiA+ID4NCj4g
PiA+ID4gU28sIHdoYXQgcHJldmVudHMgeW91IHRvIGZpeCB0aGlzPw0KPiA+ID4NCj4gPiA+IE5v
dGhpbmcgSSBzdXBwb3NlLiBUaGV5J3JlIGhvd2V2ZXIgbm90IG5lZWRlZCByaWdodCBub3cgYW5k
IGNhbiBiZQ0KPiA+ID4gaW1wbGVtZW50ZWQgbGF0ZXIgb24gaWYgdGhleSdyZSBldmVyIG5lZWRl
ZC4NCj4gPiA+DQo+ID4NCj4gPiBBY2sNCj4gDQo+IFdoYXQgZG9lcyB0aGlzIG1lYW4/ICBJcyB0
aGUgcGxhbiB0byBmaXggaXQgb3Igbm90PyAgSSBkb24ndCB3YW50IEZJWE1FcyBpbiB0aGUNCj4g
Y29kZSB0aGF0IGEpIGNhbiBiZSBmaXhlZCByaWdodCBhd2F5IG9yIGIpIG1pZ2h0IG5ldmVyIGJl
IGZpeGVkLg0KPiANCg0KSSBtZWFudCB0aGF0IHRoaXMgY2FuIGJlIGltcGxlbWVudGVkIGxhdGVy
IG9uLCBpZiB0aGVyZSdzIGEgbmVlZC4NCkkgd2lsbCBsb29rIGludG8gdGhpcyBhbmQgc2VlIGhv
dyB0aGlzIGNhbiBiZSBmaXhlZC4NCg0KVGhhbmtzDQpSYWoNCg==
