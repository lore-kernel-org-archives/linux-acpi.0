From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v4 0/6] BTT error clearing rework
Date: Tue, 1 Aug 2017 19:11:53 +0000
Message-ID: <1501614143.2042.101.camel@hpe.com>
References: <20170726233546.29052-1-vishal.l.verma@intel.com>
         <1501542358.2042.97.camel@hpe.com> <1501544000.4405.5.camel@intel.com>
         <1501600767.2042.99.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:34177 "EHLO
        g2t2354.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752262AbdHATL6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2017 15:11:58 -0400
In-Reply-To: <1501600767.2042.99.camel@hpe.com>
Content-Language: en-US
Content-ID: <661714EF8CE9E04998910473712B9FC4@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>

T24gVHVlLCAyMDE3LTA4LTAxIGF0IDA5OjE5IC0wNjAwLCBUb3NoaSBLYW5pIHdyb3RlOg0KPiBP
biBNb24sIDIwMTctMDctMzEgYXQgMjM6MzUgKzAwMDAsIFZlcm1hLCBWaXNoYWwgTCB3cm90ZToN
Cj4gPiBPbiBNb24sIDIwMTctMDctMzEgYXQgMjM6MTUgKzAwMDAsIEthbmksIFRvc2hpbWl0c3Ug
d3JvdGU6DQo+ID4gPiBPbiBXZWQsIDIwMTctMDctMjYgYXQgMTc6MzUgLTA2MDAsIFZpc2hhbCBW
ZXJtYSB3cm90ZToNCiA6DQo+ID4gVGhhbmtzIGZvciB0aGUgdGVzdCBUb3NoaSwgSSB3aWxsIHRy
eSBhbmQgcmVwcm9kdWNlIGl0Lg0KPiA+IE15IGZpcnN0IGd1ZXNzIGlzIC0gYXJlIHRoZSBpbmpl
Y3RlZCBlcnJvcnMgcG90ZW50aWFsbHkgaW4gdGhlIEJUVA0KPiA+IG1ldGFkYXRhIGFyZWEgdG93
YXJkcyB0aGUgZW5kPw0KPiA+IA0KPiA+IC0+cndfYnl0ZXMgY2FuIG9ubHkgY2xlYXIgZXJyb3Jz
IG9uIHByb3Blcmx5IGFsaWduZWQgd3JpdGVzLCBhbmQNCj4gPiB0aGUgYnR0IG1ldGFkYXRhIHdy
aXRlcyB3aWxsIGJlIHRvbyBzbWFsbCB0byBjbGVhciBtZXRhZGF0YQ0KPiA+IGVycm9ycy4uDQo+
IA0KPiBJIHBpY2tlZCBhbiBpbmplY3RlZCBvZmZzZXQgd2l0aG91dCBjYXJlZnVsIHRob3VnaHRz
LCBzbyBpdCBpcw0KPiBwb3NzaWJsZSB0aGF0IEkgbWlnaHQgaGF2ZSBzdGVwcGVkIGludG8gc3Vj
aCBhcmVhLsKgwqBJIGp1c3QgdGVzdGVkDQo+IHdpdGggYSBibG9jayBkZXZpY2UgaW50ZXJmYWNl
IHdpdGggbXVsdGlwbGUgZGlmZmVyZW50IG9mZnNldHMsIGFuZA0KPiB0aGV5IGZhaWxlZCBpbiBj
bGVhcmluZyBhcyB3ZWxsLi4uwqDCoEkgd2lsbCBsb29rIGludG8gZnVydGhlciBhcyB3ZWxsDQo+
IGFzIG15IHRlc3Qgc2V0dXAuDQoNClRoZSBjaGFuZ2UvaGFjayBiZWxvdyB0YWtlcyBjYXJlIG9m
IHRoZSBpc3N1ZSBpbiBteSBzZXR1cC4gIFRoZXJlIGlzIGENCmRpc2NyZXBhbmN5IGluIG9mZnNl
dCBiZXR3ZWVuIHRoZSBwcmUtY2hlY2sgaW4gYnR0X3dyaXRlX3BnKCkgYW5kIHRoZQ0KYWN0dWFs
IGNoZWNrIGluIG5zaW9fcndfYnl0ZXMoKS4NCg0KVGhhbmtzLA0KLVRvc2hpDQoNCi0tLQ0KwqBk
cml2ZXJzL252ZGltbS9idHQuYyB8wqDCoMKgwqAyICstDQrCoDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udmRpbW0v
YnR0LmMgYi9kcml2ZXJzL252ZGltbS9idHQuYw0KaW5kZXggOGE5NTlmOC4uODNhZDRjNiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvbnZkaW1tL2J0dC5jDQorKysgYi9kcml2ZXJzL252ZGltbS9idHQu
Yw0KQEAgLTExMzcsNyArMTEzNyw3IEBAIHN0YXRpYyBib29sIGJ0dF9pc19iYWRibG9jayhzdHJ1
Y3QgYnR0ICpidHQsDQpzdHJ1Y3QgYXJlbmFfaW5mbyAqYXJlbmEsDQrCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHUzMiBwb3N0bWFwKQ0KwqB7DQrCoMKgwqDCoMKgwqDCoMKgdTY0IG5z
b2ZmID0gdG9fbmFtZXNwYWNlX29mZnNldChhcmVuYSwgcG9zdG1hcCk7DQotwqDCoMKgwqDCoMKg
wqBzZWN0b3JfdCBwaHlzX3NlY3RvciA9IG5zb2ZmID4+IDk7DQorwqDCoMKgwqDCoMKgwqBzZWN0
b3JfdCBwaHlzX3NlY3RvciA9IChuc29mZiArIGFyZW5hLT5uZF9idHQtPmluaXRpYWxfb2Zmc2V0
KQ0KPj4gOTsNCg0KwqDCoMKgwqDCoMKgwqDCoHJldHVybiBpc19iYWRfcG1lbShidHQtPnBoeXNf
YmIsIHBoeXNfc2VjdG9yLCBhcmVuYS0NCj5pbnRlcm5hbF9sYmFzaXplKTsNCsKgfQ==
