From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH] libnvdimm, pmem: fix badblocks notification crash
Date: Thu, 27 Apr 2017 22:28:08 +0000
Message-ID: <1493332056.30303.2.camel@hpe.com>
References: <149333101097.4714.1923436715100717938.stgit@dwillia2-desk3.amr.corp.intel.com>
         <1493331874.30303.1.camel@hpe.com>
         <CAPcyv4jFk2nAdhViv_3CWQ7UxE=OCYro-d2OW-yAFAsxVUQWZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:32950 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbdD0W2L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Apr 2017 18:28:11 -0400
In-Reply-To: <CAPcyv4jFk2nAdhViv_3CWQ7UxE=OCYro-d2OW-yAFAsxVUQWZw@mail.gmail.com>
Content-Language: en-US
Content-ID: <7EFCBCB0D51FFA4D99C2D8DB684A9BC8@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>

T24gVGh1LCAyMDE3LTA0LTI3IGF0IDE1OjI2IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIFRodSwgQXByIDI3LCAyMDE3IGF0IDM6MjUgUE0sIEthbmksIFRvc2hpbWl0c3UgPHRvc2hp
LmthbmlAaHBlLmNvbQ0KPiA+IHdyb3RlOg0KPiA+IE9uIFRodSwgMjAxNy0wNC0yNyBhdCAxNTox
MCAtMDcwMCwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiA+ID4gVGhlIG5kX3BtZW1fbm90aWZ5KCkg
cm91dGluZSBpcyBjYWxsZWQgd2hlbmV2ZXIgYW4gQVJTDQo+ID4gPiAoYWRkcmVzcy1yYW5nZS1z
Y3J1YikgY29tcGxldGVzIHRvIGNvbW11bmljYXRlIHJlc3VsdHMgdG8gdGhlDQo+ID4gPiBwZXIt
bmFtZXNwYWNlIGJhZGJsb2NrcyBpbnN0YW5jZXMuDQo+ID4gPiANCj4gPiA+IFdoZW4gdGhlIG5h
bWVzcGFjZSBpcyBpbiBidHQgbW9kZSB3ZSBjcmFzaCBiZWNhdXNlIHdlIGRvIG5vdA0KPiA+ID4g
YWxsb2NhdGUgYSBzdHJ1Y3QgcG1lbV9kZXZpY2UgaW5zdGFuY2UgaW4gdGhhdCBjYXNlLiBSZXN1
bHRpbmcgaW4NCj4gPiA+IHRoZSBmb2xsb3dpbmcgY3Jhc2ggc2lnbmF0dXJlOg0KPiA+ID4gDQo+
ID4gPiDCoEJVRzogdW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJl
bmNlIGF0DQo+ID4gPiAwMDAwMDAwMDAwMDAwMDMwDQo+ID4gPiDCoElQOiBuZF9wbWVtX25vdGlm
eSsweDMwLzB4ZjAgW25kX3BtZW1dDQo+ID4gPiDCoENhbGwgVHJhY2U6DQo+ID4gPiDCoCBuZF9k
ZXZpY2Vfbm90aWZ5KzB4NDAvMHg1MA0KPiA+ID4gwqAgY2hpbGRfbm90aWZ5KzB4MTAvMHgyMA0K
PiA+ID4gwqAgZGV2aWNlX2Zvcl9lYWNoX2NoaWxkKzB4NTAvMHg5MA0KPiA+ID4gwqAgbmRfcmVn
aW9uX25vdGlmeSsweDIwLzB4MzANCj4gPiA+IMKgIG5kX2RldmljZV9ub3RpZnkrMHg0MC8weDUw
DQo+ID4gPiDCoCBudmRpbW1fcmVnaW9uX25vdGlmeSsweDI3LzB4MzANCj4gPiA+IMKgIGFjcGlf
bmZpdF9zY3J1YisweDM0MS8weDU5MCBbbmZpdF0NCj4gPiA+IMKgIHByb2Nlc3Nfb25lX3dvcmsr
MHgxOTcvMHg0NTANCj4gPiA+IMKgIHdvcmtlcl90aHJlYWQrMHg0ZS8weDRhMA0KPiA+ID4gwqAg
a3RocmVhZCsweDEwOS8weDE0MA0KPiA+ID4gDQo+ID4gPiBHaXZlbiB0aGF0IHdlIGRvbid0IGV2
ZW4gcG9wdWxhdGUgdGhlIGJ0dCBiYWRibG9ja3MgaW5zdGFuY2UsDQo+ID4gPiBqdXN0IHJldHVy
biBlYXJseSBhbmQgc2tpcCB0aGUgZGV2aWNlIHRvIHJlZ2lvbiBsb29rdXAuDQo+ID4gDQo+ID4g
V2UgcG9wdWxhdGUgdGhlIGJ0dCBiYWRibG9ja3MgaW50byBuc2lvLT5iYiwgYW5kIGNoZWNrL2Ns
ZWFyIHRoZW0NCj4gPiBpbiBuc2lvX3J3X2J5dGVzKCkuDQo+IA0KPiBBcmdoLCB5ZXMsIHdlIGRv
bid0IHBvcHVsYXRlIHRoZW0gb3V0IHRvIHRoZSBkaXNrIGJhZGJsb2Nrcy4gSSdsbCBnbw0KPiB3
aXRoIHlvdXIgcGF0Y2guDQoNClRoYW5rcyENCi1Ub3NoaQ==
