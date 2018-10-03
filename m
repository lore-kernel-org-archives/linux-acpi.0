From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
Date: Wed, 3 Oct 2018 11:28:19 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838794127@FRAEML521-MBX.china.huawei.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
 <2b4a53bc-7839-6826-44ed-6099c732a31a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2b4a53bc-7839-6826-44ed-6099c732a31a@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Cc: "will.deacon@arm.com" <will.deacon@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, John Garry <john.garry@huawei.com>, "pabba@codeaurora.org" <pabba@codeaurora.org>, "vkilari@codeaurora.org" <vkilari@codeaurora.org>, "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linuxarm <linuxarm@huawei.com>, "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>
List-Id: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDAzIE9jdG9iZXIgMjAxOCAxMToz
Nw0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPjsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbQ0KPiBDYzogd2ls
bC5kZWFjb25AYXJtLmNvbTsgbWFyay5ydXRsYW5kQGFybS5jb207IEd1b2hhbmp1biAoSGFuanVu
IEd1bykNCj4gPGd1b2hhbmp1bkBodWF3ZWkuY29tPjsgSm9obiBHYXJyeSA8am9obi5nYXJyeUBo
dWF3ZWkuY29tPjsNCj4gcGFiYmFAY29kZWF1cm9yYS5vcmc7IHZraWxhcmlAY29kZWF1cm9yYS5v
cmc7IHJydWlncm9rQGNvZGVhdXJvcmEub3JnOw0KPiBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+Ow0KPiBuZWls
Lm0ubGVlZGVyQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvM10gcGVyZjog
YWRkIGFybTY0IHNtbXV2MyBwbXUgZHJpdmVyDQo+IA0KPiBPbiAyMS8wOS8xOCAxNjowOCwgU2hh
bWVlciBLb2xvdGh1bSB3cm90ZToNCj4gWy4uLl0NCj4gPiArDQo+ID4gKwllcnIgPSBjcHVocF9z
dGF0ZV9hZGRfaW5zdGFuY2Vfbm9jYWxscyhjcHVocF9zdGF0ZV9udW0sDQo+ID4gKwkJCQkJICAg
ICAgICZzbW11X3BtdS0+bm9kZSk7DQo+IA0KPiBJbiB0aGVvcnkgYSBob3RwbHVnIGV2ZW50IGNv
dWxkIGhhcHBlbiBhcyBzb29uIGFzIHRoZSBpbnN0YW5jZSBpcw0KPiByZWdpc3RlcmVkLi4uDQo+
IA0KPiA+ICsJaWYgKGVycikgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiRXJyb3IgJWQgcmVnaXN0
ZXJpbmcgaG90cGx1ZywgUE1VIEAlcGFcbiIsDQo+ID4gKwkJCWVyciwgJnJlc18wLT5zdGFydCk7
DQo+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKiBQaWNrIG9uZSBD
UFUgdG8gYmUgdGhlIHByZWZlcnJlZCBvbmUgdG8gdXNlICovDQo+ID4gKwlzbW11X3BtdS0+b25f
Y3B1ID0gZ2V0X2NwdSgpOw0KPiANCj4gLi4uc28gdGhpcyBsb29rcyB0b28gbGF0ZSwgaS5lLiBh
IHJhY2UgaGVyZSBjYW4gcmVzdWx0IGluIGEgYm9ndXMgY2FsbA0KPiB0byBwZXJmX3BtdV9taWdy
YXRlX2NvbnRleHQoKSB3aXRoIGFuIHVuaW5pdGlhbGlzZWQgcG11Lg0KDQpUaGFua3MgUm9iaW4u
IEkgd2lsbCByZW9yZGVyIHRoZW0uDQoNClNoYW1lZXINCg0KPiBSb2Jpbi4gDQo+ID4gKwlXQVJO
X09OKGlycV9zZXRfYWZmaW5pdHkoc21tdV9wbXUtPmlycSwgY3B1bWFza19vZihzbW11X3BtdS0N
Cj4gPm9uX2NwdSkpKTsNCj4gPiArDQo+ID4gKwllcnIgPSBwZXJmX3BtdV9yZWdpc3Rlcigmc21t
dV9wbXUtPnBtdSwgbmFtZSwgLTEpOw0KPiA+ICsJaWYgKGVycikgew0KPiA+ICsJCWRldl9lcnIo
ZGV2LCAiRXJyb3IgJWQgcmVnaXN0ZXJpbmcgUE1VIEAlcGFcbiIsDQo+ID4gKwkJCWVyciwgJnJl
c18wLT5zdGFydCk7DQo+ID4gKwkJZ290byBvdXRfdW5yZWdpc3RlcjsNCj4gPiArCX0NCj4gPiAr
DQo+ID4gKwlwdXRfY3B1KCk7DQo=
