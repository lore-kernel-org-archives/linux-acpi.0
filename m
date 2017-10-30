From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: RE: [PATCH v10 6/9] LPC: Support the LPC host on Hip06/Hip07 with
 DT bindings
Date: Mon, 30 Oct 2017 15:55:15 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40CAEE3A@FRAEML521-MBX.china.huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <1509120687-7352-7-git-send-email-gabriele.paoloni@huawei.com>
 <de9f0362-6f2d-2f73-a23a-af248a9b1963@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <de9f0362-6f2d-2f73-a23a-af248a9b1963@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "rafael@kernel.org" <rafael@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "brian.starkey@arm.com" <brian.starkey@arm.com>, "olof@lixom.net" <olof@lixom.net>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>, John Garry <john.garry@huawei.com>, "xuwei (O)" <xuwei5@hisilicon.com>, "zhichang.yuan" <yuanzhichang@hisilicon.com>
List-Id: linux-acpi@vger.kernel.org

SGkgUmFuZHkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYW5keSBE
dW5sYXAgW21haWx0bzpyZHVubGFwQGluZnJhZGVhZC5vcmddDQo+IFNlbnQ6IDI3IE9jdG9iZXIg
MjAxNyAxNzo0NA0KPiBUbzogR2FicmllbGUgUGFvbG9uaTsgY2F0YWxpbi5tYXJpbmFzQGFybS5j
b207IHdpbGwuZGVhY29uQGFybS5jb207DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgZnJvd2FuZC5s
aXN0QGdtYWlsLmNvbTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gcmFmYWVsQGtlcm5lbC5vcmc7
IGFybmRAYXJuZGIuZGU7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4g
bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbQ0KPiBDYzogbWFyay5ydXRsYW5kQGFybS5jb207IGJy
aWFuLnN0YXJrZXlAYXJtLmNvbTsgb2xvZkBsaXhvbS5uZXQ7DQo+IGJlbmhAa2VybmVsLmNyYXNo
aW5nLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGFjcGlAdmdl
ci5rZXJuZWwub3JnOyBMaW51eGFybTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbWlu
eWFyZEBhY20ub3JnOyBKb2huIEdhcnJ5OyB4dXdlaSAoTyk7IHpoaWNoYW5nLnl1YW4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MTAgNi85XSBMUEM6IFN1cHBvcnQgdGhlIExQQyBob3N0IG9uIEhp
cDA2L0hpcDA3DQo+IHdpdGggRFQgYmluZGluZ3MNCj4gDQo+IE9uIDEwLzI3LzE3IDA5OjExLCBH
YWJyaWVsZSBQYW9sb25pIHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2J1cy9LY29u
ZmlnIGIvZHJpdmVycy9idXMvS2NvbmZpZw0KPiA+IGluZGV4IDI0MDhlYTMuLjM1OGVlZDMgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9idXMvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvYnVz
L0tjb25maWcNCj4gPiBAQCAtNjQsNiArNjQsMTUgQEAgY29uZmlnIEJSQ01TVEJfR0lTQl9BUkIN
Cj4gPiAgCSAgYXJiaXRlci4gVGhpcyBkcml2ZXIgcHJvdmlkZXMgdGltZW91dCBhbmQgdGFyZ2V0
IGFib3J0IGVycm9yDQo+IGhhbmRsaW5nDQo+ID4gIAkgIGFuZCBpbnRlcm5hbCBidXMgbWFzdGVy
IGRlY29kaW5nLg0KPiA+DQo+ID4gK2NvbmZpZyBISVNJTElDT05fTFBDDQo+ID4gKwlib29sICJT
dXBwb3J0IGZvciBJU0EgSS9PIHNwYWNlIG9uIEhpc2lsaWNvbiBIaXAwWCINCj4gPiArCWRlcGVu
ZHMgb24gKEFSTTY0ICYmIChBUkNIX0hJU0kgfHwgQ09NUElMRV9URVNUKSkNCj4gPiArCXNlbGVj
dCBMT0dJQ19QSU8NCj4gPiArCXNlbGVjdCBJTkRJUkVDVF9QSU8NCj4gPiArCWhlbHANCj4gPiAr
CSAgRHJpdmVyIG5lZWRlZCBmb3Igc29tZSBsZWdhY3kgSVNBIGRldmljZXMgYXR0YWNoZWQgdG8g
TG93LVBpbi0NCj4gQ291bnQNCj4gPiArCSAgb24gSGlzaWxpY29uIEhpcDBYIFNvQy4NCj4gPiAr
DQo+ID4gIGNvbmZpZyBJTVhfV0VJTQ0KPiA+ICAJYm9vbCAiRnJlZXNjYWxlIEVJTSBEUklWRVIi
DQo+ID4gIAlkZXBlbmRzIG9uIEFSQ0hfTVhDDQo+IA0KPiBIaSwNCj4gDQo+IFdoeSBib29sPyB3
aHkgbm90IHRyaXN0YXRlPw0KDQpXZWxsIGZvciB0aGUgbmF0dXJlIG9mIG91ciBIVyBpdCB3b3Vs
ZCBub3QgbWFrZSBtdWNoIHNlbnNlIHRvIGhhdmUgdGhlDQpMUEMgbW9kdWxhci4gQWxzbyB5b3Ug
Y2FuIHNlZSBpbiBwYXRjaCA4IHRoZSBMUEMgaG9zdCBpcyAidHJhbnNsYXRpbmciDQp0aGUgcmVz
b3VyY2VzIG9mIGl0cyBjaGlsZHJlbiBiZWZvcmUgdGhlc2UgYXJlIGFjdHVhbGx5IHByb2JlZCBh
bmQgdGhpcw0KaXMgZG9uZSBieSBhY3BpX2luZGlyZWN0aW9fc2Nhbl9pbml0KCkgYXMgcGFydCBv
ZiB0aGUgQUNQSSBpbml0IHByb2Nlc3MuDQoNClRoYW5rcw0KR2FiDQoNCj4gDQo+IC0tDQo+IH5S
YW5keQ0K
