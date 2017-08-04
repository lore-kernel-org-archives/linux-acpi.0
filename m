From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 3/7] ACPI / APEI: add OSC APEI bit check for ghes_edac
Date: Fri, 4 Aug 2017 20:49:51 +0000
Message-ID: <1501879218.2042.115.camel@hpe.com>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
         <20170803215753.30553-4-toshi.kani@hpe.com>
         <20170804034417.GC12082@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3427.houston.hpe.com ([15.241.140.73]:35362 "EHLO
        g4t3427.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdHDUtz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Aug 2017 16:49:55 -0400
In-Reply-To: <20170804034417.GC12082@nazgul.tnic>
Content-Language: en-US
Content-ID: <CEA2C5C22BF6024DACEB341FAD8EEF70@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

T24gRnJpLCAyMDE3LTA4LTA0IGF0IDA1OjQ0ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgQXVnIDAzLCAyMDE3IGF0IDAzOjU3OjQ5UE0gLTA2MDAsIFRvc2hpIEthbmkg
d3JvdGU6DQo+ID4gV2hlbiAnb3NjX3NiX2FwZWlfc3VwcG9ydF9hY2tlZCcgaXMgc2V0LCBpdCBp
bmRpY2F0ZXMgdGhhdA0KPiA+IHRoZSBwbGF0Zm9ybSBzdXBwb3J0cyBBUEVJLCBmaXJtd2FyZS1m
aXJzdCBtb2RlLCBhcyBBQ1BJIF9PU0MNCj4gPiBjYXBhYmlsaXR5IGJpdCA0LCBBUEVJIFN1cHBv
cnQsIHdhcyBzZXQgaW4gcXVlcnkuwqDCoFdoaWxlIF9PU0MNCj4gPiBpcyBhbiBvcHRpb25hbCBt
ZXRob2QsIHBsYXRmb3JtcyB3aXRoIEFQRUkgc3VwcG9ydCBzaG91bGQNCj4gPiBpbXBsZW1lbnQg
aXQgdG8gaW5mb3JtIGl0cyBjYXBhYmlsaXR5IHRvIHRoZSBPUyBwcm9wZXJseS4NCj4gPiANCj4g
PiBBZGQgY2hlY2sgdG8gJ29zY19zYl9hcGVpX3N1cHBvcnRfYWNrZWQnIGJlZm9yZSBjYWxsaW5n
DQo+ID4gZ2hlc19lZGFjX3JlZ2lzdGVyKCkgdG8gcmVzdHJpY3QgdGhhdCBnaGVzX2VkYWMgaXMg
ZW5hYmxlZA0KPiA+IG9uIHBsYXRmb3JtcyB3aXRoIEFQRUkgc3VwcG9ydCBjYXBhYmlsaXR5IHNl
dCBpbiBfT1NDLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRvc2hpIEthbmkgPHRvc2hpLmth
bmlAaHBlLmNvbT4NCj4gPiBDYzogIlJhZmFlbCBKLiBXeXNvY2tpIiA8cmp3QHJqd3lzb2NraS5u
ZXQ+DQo+ID4gQ2M6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPiA+IENjOiBNYXVy
byBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz4NCj4gPiBDYzogVG9ueSBMdWNr
IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9hY3BpL2FwZWkv
Z2hlcy5jIHzCoMKgwqDCoDggKysrKystLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
YWNwaS9hcGVpL2doZXMuYyBiL2RyaXZlcnMvYWNwaS9hcGVpL2doZXMuYw0KPiA+IGluZGV4IGQ2
NjFkNDUuLjQ5ZDc1ZWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5j
DQo+ID4gKysrIGIvZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jDQo+ID4gQEAgLTExMzksOSArMTEz
OSwxMSBAQCBzdGF0aWMgaW50IGdoZXNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiA+
ICpnaGVzX2RldikNCj4gPiDCoAkJZ290byBlcnI7DQo+ID4gwqAJfQ0KPiA+IMKgDQo+ID4gLQly
YyA9IGdoZXNfZWRhY19yZWdpc3RlcihnaGVzLCAmZ2hlc19kZXYtPmRldik7DQo+ID4gLQlpZiAo
cmMgPCAwKQ0KPiA+IC0JCWdvdG8gZXJyOw0KPiA+ICsJaWYgKG9zY19zYl9hcGVpX3N1cHBvcnRf
YWNrZWQpIHsNCj4gDQo+IFdoYXQgZm9yIHdoZW4gd2UgaGF2ZSB0aGUgd2hpdGVsaXN0Pw0KDQpT
b21lIGZpcm13YXJlIGZlYXR1cmVzIGNhbiBiZSBlbmFibGVkIC8gZGlzYWJsZWQgaW4gQklPUy4g
IFdoaWxlIEhQRQ0KZmlybXdhcmUgZG9lcyBub3QgYWxsb3cgdG8gZGlzYWJsZSBGRiwgaXQncyBw
b3NzaWJsZSB0aGF0IG90aGVyIHZlbmRvcnMNCm1pZ2h0IGFsbG93IHN1Y2ggYW5kIHN0aWxsIGhh
dmUgdGhlIHNhbWUgT0VNIElEIGluZm8uICBTbywgdGhpcyBjaGVjaw0KbWFrZXMgc3VyZSB0aGF0
IEZGIGlzIGluIGZhY3QgZW5hYmxlZCBpbiBmaXJtd2FyZS4NCg0KVGhhbmtzLA0KLVRvc2hpDQo=
