From: "Kani, Toshi" <toshi.kani@hpe.com>
Subject: Re: [PATCH] acpi, nfit: fix register dimm error handling
Date: Fri, 2 Feb 2018 20:38:41 +0000
Message-ID: <1517606653.16384.106.camel@hpe.com>
References: <20180202210036.3153-1-toshi.kani@hpe.com>
         <CAPcyv4jPNxSKxb-kzaw8njhDHGUs7DOPASS_GBXbPGOFP4RN=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:6123 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeBBUip (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Feb 2018 15:38:45 -0500
In-Reply-To: <CAPcyv4jPNxSKxb-kzaw8njhDHGUs7DOPASS_GBXbPGOFP4RN=g@mail.gmail.com>
Content-Language: en-US
Content-ID: <9BFE654EBAED554581D358397ED5DB90@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

T24gRnJpLCAyMDE4LTAyLTAyIGF0IDEyOjMxIC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIEZyaSwgRmViIDIsIDIwMTggYXQgMTowMCBQTSwgVG9zaGkgS2FuaSA8dG9zaGkua2FuaUBo
cGUuY29tPiB3cm90ZToNCj4gPiBBIE5VTEwgcG9pbnRlciByZWZlcmVuY2Uga2VybmVsIGJ1ZyB3
YXMgb2JzZXJ2ZWQgd2hlbg0KPiA+IGFjcGlfbmZpdF9hZGRfZGltbSgpIGNhbGxlZCBpbiBhY3Bp
X25maXRfcmVnaXN0ZXJfZGltbXMoKQ0KPiA+IGZhaWxlZC4gVGhpcyBlcnJvciBwYXRoIGRvZXMg
bm90IHNldCBuZml0X21lbS0+bnZkaW1tLCBidXQNCj4gPiB0aGUgMm5kIGxpc3RfZm9yX2VhY2hf
ZW50cnkoKSBsb29wIGluIHRoZSBmdW5jdGlvbiBhc3N1bWVzDQo+ID4gaXQncyBhbHdheXMgc2V0
LiBBZGQgYSBjaGVjayB0byBuZml0X21lbS0+bnZkaW1tLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFRvc2hpIEthbmkgPHRvc2hpLmthbmlAaHBlLmNvbT4NCj4gPiBDYzogRGFuIFdpbGxpYW1z
IDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+ID4gQ2M6ICJSYWZhZWwgSi4gV3lzb2NraSIg
PHJqd0Byand5c29ja2kubmV0Pg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2FjcGkvbmZpdC9jb3Jl
LmMgfCAgICAzICsrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUuYyBiL2RyaXZlcnMvYWNw
aS9uZml0L2NvcmUuYw0KPiA+IGluZGV4IGFiZWI0ZGY0ZjIyZS4uYjI4Y2U0NDBhMDZmIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
YWNwaS9uZml0L2NvcmUuYw0KPiA+IEBAIC0xODY3LDYgKzE4NjcsOSBAQCBzdGF0aWMgaW50IGFj
cGlfbmZpdF9yZWdpc3Rlcl9kaW1tcyhzdHJ1Y3QgYWNwaV9uZml0X2Rlc2MgKmFjcGlfZGVzYykN
Cj4gPiAgICAgICAgICAgICAgICAgc3RydWN0IGtlcm5mc19ub2RlICpuZml0X2tlcm5mczsNCj4g
PiANCj4gPiAgICAgICAgICAgICAgICAgbnZkaW1tID0gbmZpdF9tZW0tPm52ZGltbTsNCj4gPiAr
ICAgICAgICAgICAgICAgaWYgKCFudmRpbW0pDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
Y29udGludWU7DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAgICBuZml0X2tlcm5mcyA9IHN5c2Zz
X2dldF9kaXJlbnQobnZkaW1tX2tvYmoobnZkaW1tKS0+c2QsICJuZml0Iik7DQo+ID4gICAgICAg
ICAgICAgICAgIGlmIChuZml0X2tlcm5mcykNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBu
Zml0X21lbS0+ZmxhZ3NfYXR0ciA9IHN5c2ZzX2dldF9kaXJlbnQobmZpdF9rZXJuZnMsDQo+IA0K
PiBZZXMsIEkgYXNzdW1lIHRoaXMgYWxzbyBuZWVkczoNCj4gDQo+IENjOiA8c3RhYmxlQHZnZXIu
a2VybmVsLm9yZz4NCj4gRml4ZXM6IGJhOWM4ZGQzYzIyMiAoImFjcGksIG5maXQ6IGFkZCBkaW1t
IGRldmljZSBub3RpZmljYXRpb24gc3VwcG9ydCIpDQoNClJpZ2h0LiBUaGFua3MhDQotVG9zaGk=
