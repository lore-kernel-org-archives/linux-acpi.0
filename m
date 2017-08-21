From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v3 1/5] ACPI / blacklist: add acpi_match_platform_list()
Date: Mon, 21 Aug 2017 21:06:42 +0000
Message-ID: <1503349011.2042.168.camel@hpe.com>
References: <20170818194644.14538-1-toshi.kani@hpe.com>
         <20170818194644.14538-2-toshi.kani@hpe.com>
         <20170821112657.hrtjoeagxhc67rrr@pd.tnic>
         <1503333107.2042.163.camel@hpe.com>
         <20170821170415.kttnqiwj2fkntsc7@pd.tnic>
         <1503335626.2042.165.camel@hpe.com>
         <20170821173612.i3zxlmxklmvv5kzd@pd.tnic>
         <CAJZ5v0iMR-m6JRDJBeYLDH3uz4_gGAoxQY6Yk3-vf9L=x6G-_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:56526 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753695AbdHUVGp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Aug 2017 17:06:45 -0400
In-Reply-To: <CAJZ5v0iMR-m6JRDJBeYLDH3uz4_gGAoxQY6Yk3-vf9L=x6G-_A@mail.gmail.com>
Content-Language: en-US
Content-ID: <B04CB836DC41FB4780F65A3950A646C4@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>, "rafael@kernel.org" <rafael@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>

T24gTW9uLCAyMDE3LTA4LTIxIGF0IDIyOjMxICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gTW9uLCBBdWcgMjEsIDIwMTcgYXQgNzozNiBQTSwgQm9yaXNsYXYgUGV0a292IDxi
cEBhbGllbjguZGU+DQo+IHdyb3RlOg0KPiA+IE9uIE1vbiwgQXVnIDIxLCAyMDE3IGF0IDA1OjIz
OjM3UE0gKzAwMDAsIEthbmksIFRvc2hpbWl0c3Ugd3JvdGU6DQo+ID4gPiA+ID4gJ2RhdGEnIGhl
cmUgaXMgcHJpdmF0ZSB0byB0aGUgY2FsbGVyLsKgwqBTbywgSSBkbyBub3QgdGhpbmsgd2UNCj4g
PiA+ID4gPiBuZWVkIHRvIGRlZmluZSB0aGUgYml0cy7CoMKgU2hhbGwgSSBjaGFuZ2UgdGhlIG5h
bWUgdG8NCj4gPiA+ID4gPiAnZHJpdmVyX2RhdGEnIHRvIG1ha2UgaXQgbW9yZSBleHBsaWNpdD8N
Cj4gPiA+ID4gDQo+ID4gPiA+IFlvdSBjaGFuZ2VkIGl0IHRvICdkYXRhJy4gSXQgd2FzIGEgdTMy
LXVzZWQtYXMtYm9vbGVhbg0KPiA+ID4gPiBpc19jcml0aWNhbF9lcnJvciBiZWZvcmUuDQo+ID4g
PiA+IA0KPiA+ID4gPiBTbyB5b3UgY2FuIGp1c3QgYXMgd2VsbCBtYWtlIGl0IGludG8gZmxhZ3Mg
YW5kIHBlb3BsZSBjYW4NCj4gPiA+ID4gZXh0ZW5kIHRob3NlIGZsYWdzIGlmIG5lZWRlZC4gQSBm
bGFnIGJpdCBzaG91bGQgYmUgZW5vdWdoIGluDQo+ID4gPiA+IG1vc3QgY2FzZXMgYW55d2F5LiBJ
ZiB0aGV5IHJlYWxseSBuZWVkIGRyaXZlcl9kYXRhLCB0aGVuIHRoZXkNCj4gPiA+ID4gY2FuIGFk
ZCBhIHZvaWQgKm1lbWJlci4NCj4gPiA+IA0KPiA+ID4gSG1tLi4gSW4gcGF0Y2ggMiwgaW50ZWxf
cHN0YXRlX3BsYXRmb3JtX3B3cl9tZ210X2V4aXN0cygpIHVzZXMNCj4gPiA+IHRoaXMgZmllbGQg
Zm9yIFBTUyBhbmQgUENDLCB3aGljaCBhcmUgZW51bSB2YWx1ZXMuwqDCoEkgdGhpbmsgd2UNCj4g
PiA+IHNob3VsZCBhbGxvdyBkcml2ZXJzIHRvIHNldCBhbnkgdmFsdWVzIGhlcmUuwqDCoEkgYWdy
ZWUgdGhhdCBpdCBtYXkNCj4gPiA+IG5lZWQgdG8gYmUgdm9pZCAqIGlmIHdlIGFsc28gYWxsb3cg
ZHJpdmVycyB0byBzZXQgYSBwb2ludGVyIGhlcmUuDQo+ID4gDQo+ID4gTGV0J3Mgc2VlIHdoYXQg
UmFmYWVsIHByZWZlcnMuDQo+IA0KPiBJIHdvdWxkIHJldGFpbiB0aGUgaXNfY3JpdGljYWxfZXJy
b3IgZmllbGQgYW5kIHVzZSB0aGF0IGZvciBwcmludGluZw0KPiB0aGUgcmVjb3ZlcmFibGUgLyBu
b24tcmVjb3ZlcmFibGUgbWVzc2FnZS7CoMKgVGhpcyBpcyBraW5kIG9mDQo+IG9ydGhvZ29uYWwg
dG8gd2hldGhlciBvciBub3QgYW55IGV4dHJhIGRhdGEgaXMgbmVlZGVkIGFuZCB0aGF0IGNhbiBi
ZQ0KPiBhbiBhZGRpdGlvbmFsIGZpZWxkLsKgwqBJbiB0aGF0IGNhc2UgdW5zaWduZWQgbG9uZyBz
aG91bGQgYmUgc3VmZmljaWVudA0KPiB0byBhY2NvbW1vZGF0ZSBhIHBvaW50ZXIgaWYgbmVlZCBi
ZS4NCg0KWWVzLCB3ZSB3aWxsIHJldGFpbiB0aGUgZmllbGQuICBUaGUgcXVlc3Rpb24gaXMgd2hl
dGhlciB0aGlzIGZpZWxkDQpzaG91bGQgYmUgcmV0YWluZWQgYXMgYSBkcml2ZXIncyBwcml2YXRl
IGRhdGEgb3IgQUNQSS1tYW5hZ2VkIGZsYWdzLiDCoA0KDQpNeSBwYXRjaCBpbXBsZW1lbnRzIHRo
ZSBmb3JtZXIsIHdoaWNoIGxldHMgdGhlIGNhbGxlcnMgdG8gZGVmaW5lIHRoZQ0KZGF0YSB2YWx1
ZXMuICBGb3IgaW5zdGFuY2UsIGFjcGlfYmxhY2tsaXN0ZWQoKSB1c2VzIHRoaXMgZmllbGQgYXMN
CmlzX2NyaXRpY2FsX2Vycm9yIHZhbHVlLCBhbmQgaW50ZWxfcHN0YXRlX3BsYXRmb3JtX3B3cl9t
Z210X2V4aXN0cygpDQp1c2VzIGl0IGFzIG9lbV9wd3JfdGFibGUgdmFsdWUuDQoNCkJvcmlzIHN1
Z2dlc3RlZCB0aGUgbGF0dGVyLCB3aGljaCBsZXRzIEFDUEkgdG8gZGVmaW5lIHRoZSBmbGFncywg
d2hpY2gNCmFyZSB0aGVuIHVzZWQgYnkgdGhlIGNhbGxlcnMuICBGb3IgaW5zdGFuY2UsIGhlIHN1
Z2dlc3RlZCBBQ1BJIHRvDQpkZWZpbmUgYml0MCBhcyBpc19jcml0aWNhbF9lcnJvci4NCg0KI2Rl
ZmluZSBBQ1BJX1BMQVRfSVNfQ1JJVElDQUxfRVJST1LCoMKgwqDCoMKgQklUKDApDQoNClRoYW5r
cywNCi1Ub3NoaQ0KDQo=
