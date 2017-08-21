From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v3 1/5] ACPI / blacklist: add acpi_match_platform_list()
Date: Mon, 21 Aug 2017 22:21:40 +0000
Message-ID: <1503353508.2042.170.camel@hpe.com>
References: <20170818194644.14538-1-toshi.kani@hpe.com>
         <20170818194644.14538-2-toshi.kani@hpe.com>
         <20170821112657.hrtjoeagxhc67rrr@pd.tnic>
         <1503333107.2042.163.camel@hpe.com>
         <20170821170415.kttnqiwj2fkntsc7@pd.tnic>
         <1503335626.2042.165.camel@hpe.com>
         <20170821173612.i3zxlmxklmvv5kzd@pd.tnic>
         <CAJZ5v0iMR-m6JRDJBeYLDH3uz4_gGAoxQY6Yk3-vf9L=x6G-_A@mail.gmail.com>
         <1503349011.2042.168.camel@hpe.com>
         <CAJZ5v0jvPEDuezyjzuj0nYiiu6ZT-GxLb+28orvrwMCm2=UWqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:35590 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753648AbdHUWVn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Aug 2017 18:21:43 -0400
In-Reply-To: <CAJZ5v0jvPEDuezyjzuj0nYiiu6ZT-GxLb+28orvrwMCm2=UWqA@mail.gmail.com>
Content-Language: en-US
Content-ID: <1C78E19349540A47A832F5E24727D7D6@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "rafael@kernel.org" <rafael@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

T24gTW9uLCAyMDE3LTA4LTIxIGF0IDIzOjQ5ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gTW9uLCBBdWcgMjEsIDIwMTcgYXQgMTE6MDYgUE0sIEthbmksIFRvc2hpbWl0c3Ug
PHRvc2hpLmthbmlAaHBlLmNvDQo+IG0+IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAxNy0wOC0yMSBh
dCAyMjozMSArMDIwMCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gPiBPbiBNb24sIEF1
ZyAyMSwgMjAxNyBhdCA3OjM2IFBNLCBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4g
PiA+IHdyb3RlOg0KPiA+ID4gPiBPbiBNb24sIEF1ZyAyMSwgMjAxNyBhdCAwNToyMzozN1BNICsw
MDAwLCBLYW5pLCBUb3NoaW1pdHN1DQo+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiAnZGF0
YScgaGVyZSBpcyBwcml2YXRlIHRvIHRoZSBjYWxsZXIuwqDCoFNvLCBJIGRvIG5vdCB0aGluaw0K
PiA+ID4gPiA+ID4gPiB3ZSBuZWVkIHRvIGRlZmluZSB0aGUgYml0cy7CoMKgU2hhbGwgSSBjaGFu
Z2UgdGhlIG5hbWUgdG8NCj4gPiA+ID4gPiA+ID4gJ2RyaXZlcl9kYXRhJyB0byBtYWtlIGl0IG1v
cmUgZXhwbGljaXQ/DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFlvdSBjaGFuZ2VkIGl0IHRv
ICdkYXRhJy4gSXQgd2FzIGEgdTMyLXVzZWQtYXMtYm9vbGVhbg0KPiA+ID4gPiA+ID4gaXNfY3Jp
dGljYWxfZXJyb3IgYmVmb3JlLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBTbyB5b3UgY2Fu
IGp1c3QgYXMgd2VsbCBtYWtlIGl0IGludG8gZmxhZ3MgYW5kIHBlb3BsZSBjYW4NCj4gPiA+ID4g
PiA+IGV4dGVuZCB0aG9zZSBmbGFncyBpZiBuZWVkZWQuIEEgZmxhZyBiaXQgc2hvdWxkIGJlIGVu
b3VnaA0KPiA+ID4gPiA+ID4gaW4gbW9zdCBjYXNlcyBhbnl3YXkuIElmIHRoZXkgcmVhbGx5IG5l
ZWQgZHJpdmVyX2RhdGEsIHRoZW4NCj4gPiA+ID4gPiA+IHRoZXkgY2FuIGFkZCBhIHZvaWQgKm1l
bWJlci4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBIbW0uLiBJbiBwYXRjaCAyLCBpbnRlbF9wc3Rh
dGVfcGxhdGZvcm1fcHdyX21nbXRfZXhpc3RzKCkNCj4gPiA+ID4gPiB1c2VzIHRoaXMgZmllbGQg
Zm9yIFBTUyBhbmQgUENDLCB3aGljaCBhcmUgZW51bSB2YWx1ZXMuwqDCoEkNCj4gPiA+ID4gPiB0
aGluayB3ZSBzaG91bGQgYWxsb3cgZHJpdmVycyB0byBzZXQgYW55IHZhbHVlcyBoZXJlLsKgwqBJ
DQo+ID4gPiA+ID4gYWdyZWUgdGhhdCBpdCBtYXkgbmVlZCB0byBiZSB2b2lkICogaWYgd2UgYWxz
byBhbGxvdyBkcml2ZXJzDQo+ID4gPiA+ID4gdG8gc2V0IGEgcG9pbnRlciBoZXJlLg0KPiA+ID4g
PiANCj4gPiA+ID4gTGV0J3Mgc2VlIHdoYXQgUmFmYWVsIHByZWZlcnMuDQo+ID4gPiANCj4gPiA+
IEkgd291bGQgcmV0YWluIHRoZSBpc19jcml0aWNhbF9lcnJvciBmaWVsZCBhbmQgdXNlIHRoYXQg
Zm9yDQo+ID4gPiBwcmludGluZyB0aGUgcmVjb3ZlcmFibGUgLyBub24tcmVjb3ZlcmFibGUgbWVz
c2FnZS7CoMKgVGhpcyBpcyBraW5kDQo+ID4gPiBvZiBvcnRob2dvbmFsIHRvIHdoZXRoZXIgb3Ig
bm90IGFueSBleHRyYSBkYXRhIGlzIG5lZWRlZCBhbmQgdGhhdA0KPiA+ID4gY2FuIGJlIGFuIGFk
ZGl0aW9uYWwgZmllbGQuwqDCoEluIHRoYXQgY2FzZSB1bnNpZ25lZCBsb25nIHNob3VsZCBiZQ0K
PiA+ID4gc3VmZmljaWVudCB0byBhY2NvbW1vZGF0ZSBhIHBvaW50ZXIgaWYgbmVlZCBiZS4NCj4g
PiANCj4gPiBZZXMsIHdlIHdpbGwgcmV0YWluIHRoZSBmaWVsZC7CoMKgVGhlIHF1ZXN0aW9uIGlz
IHdoZXRoZXIgdGhpcyBmaWVsZA0KPiA+IHNob3VsZCBiZSByZXRhaW5lZCBhcyBhIGRyaXZlcidz
IHByaXZhdGUgZGF0YSBvciBBQ1BJLW1hbmFnZWQNCj4gPiBmbGFncy4NCj4gDQo+IFRoYW5rcyBm
b3IgdGhlIGNsYXJpZmljYXRpb24uDQo+IA0KPiA+IE15IHBhdGNoIGltcGxlbWVudHMgdGhlIGZv
cm1lciwgd2hpY2ggbGV0cyB0aGUgY2FsbGVycyB0byBkZWZpbmUNCj4gPiB0aGUgZGF0YSB2YWx1
ZXMuwqDCoEZvciBpbnN0YW5jZSwgYWNwaV9ibGFja2xpc3RlZCgpIHVzZXMgdGhpcyBmaWVsZA0K
PiA+IGFzIGlzX2NyaXRpY2FsX2Vycm9yIHZhbHVlLCBhbmQNCj4gPiBpbnRlbF9wc3RhdGVfcGxh
dGZvcm1fcHdyX21nbXRfZXhpc3RzKCkgdXNlcyBpdCBhcyBvZW1fcHdyX3RhYmxlDQo+ID4gdmFs
dWUuDQo+ID4gDQo+ID4gQm9yaXMgc3VnZ2VzdGVkIHRoZSBsYXR0ZXIsIHdoaWNoIGxldHMgQUNQ
SSB0byBkZWZpbmUgdGhlIGZsYWdzLA0KPiA+IHdoaWNoIGFyZSB0aGVuIHVzZWQgYnkgdGhlIGNh
bGxlcnMuwqDCoEZvciBpbnN0YW5jZSwgaGUgc3VnZ2VzdGVkDQo+ID4gQUNQSSB0byBkZWZpbmUg
Yml0MCBhcyBpc19jcml0aWNhbF9lcnJvci4NCj4gPiANCj4gPiAjZGVmaW5lIEFDUElfUExBVF9J
U19DUklUSUNBTF9FUlJPUsKgwqDCoMKgwqBCSVQoMCkNCj4gDQo+IFNvIG15IHBvaW50IGlzIHRo
YXQgd2UgY2FuIGhhdmUgYm90aCB0aGUgQUNQSS1tYW5hZ2VkIGZsYWdzIGFuZCB0aGUNCj4gdGhl
IGNhbGxlci1kZWZpbmVkIGRhdGEgYXQgdGhlIHNhbWUgdGltZSBhcyBzZXBhcmF0ZSBpdGVtcy4N
Cj4gDQo+IFRoYXQgd291bGQgYWxsb3cgb2YgbWF4aW11bSBmbGV4aWJpbGl0eSBJTU8uDQoNCkkg
YWdyZWUgaW4gZ2VuZXJhbC4gIERyaXZlciBwcml2YXRlIGRhdGEgYWxsb3dzIGZsZXhpYmlsaXR5
IHRvIGRyaXZlcnMNCndoZW4gdGhlIHZhbHVlcyBhcmUgZHJpdmVyLXByaXZhdGUuICBBQ1BJLW1h
bmFnZWQgZmxhZ3MgYWxsb3dzIEFDUEkgdG8NCmNvbnRyb2wgdGhlIGludGVyZmFjZXMgYmFzZWQg
b24gdGhlIGZsYWdzLg0KDQpTaW5jZSB3ZSBkbyBub3QgaGF2ZSB1c2UtY2FzZSBvZiB0aGUgbGF0
dGVyIGNhc2UgeWV0LCBpLmUuDQphY3BpX21hdGNoX3BsYXRmb3JtX2xpc3QoKSBkb2VzIG5vdCBu
ZWVkIHRvIGNoZWNrIHRoZSBmbGFncywgSSdkDQpzdWdnZXN0IHRoYXQgd2Uga2VlcCAnZGF0YScg
YXMgZHJpdmVyLXByaXZhdGUuICBXZSBjYW4gYWRkICdmbGFncycgYXMgYQ0Kc2VwYXJhdGUgbWVt
YmVyIHRvIHRoZSBzdHJ1Y3R1cmUgd2hlbiB3ZSBmaW5kIHRoZSBsYXR0ZXIgdXNlLWNhc2UuDQoN
ClRoYW5rcywNCi1Ub3NoaQ0KDQo=
