From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 13/16] ACPICA: Move _PRT repair into the standard
 complex repair module
Date: Thu, 20 Jun 2013 05:01:11 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88DBE@ORSMSX103.amr.corp.intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88551@ORSMSX103.amr.corp.intel.com>
 <32658874.38eDoNxZF3@vostro.rjw.lan> <6076307.SjBblEYW5y@vostro.rjw.lan>
 <1AE640813FDE7649BE1B193DEA596E8802418933@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63163 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab3FTFBM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Jun 2013 01:01:12 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802418933@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

WWVzLCB3ZSBoYXZlIGFuIGlzc3VlIHdoZXJlIHRoZSBsaW51eCBwYXRjaCBtZXNzYWdlIHNvbWV0
aW1lcyBuZWVkcyAibGludXgtc3BlY2lmaWMiIGluZm9ybWF0aW9uLiBGb3IgdGhlIHJhdyBBQ1BJ
Q0EgY29tbWl0cywgd2UgZG8gbm90IGhhdmUgYW55IG9zLXNwZWNpZmljIGRldGFpbHMgb3IgcmVm
ZXJlbmNlcywgZm9yIG9idmlvdXMgcmVhc29ucy4NCg0KTm90IHN1cmUgaG93IHRvIGhhbmRsZSB0
aGlzLiBMdiBjYW4gcHJvYmFibHkgdGFrZSBhIGZpcnN0IHBhc3MgYXQgaXQsIHRoZW4gSSBjYW4g
cmV2aWV3LCBiZWZvcmUgZmlyc3QgcmVsZWFzZSBhbmQgZ2VuZXJhbCByZXZpZXcuDQoNCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBaaGVuZywgTHYNCj4gU2VudDogV2Vk
bmVzZGF5LCBKdW5lIDE5LCAyMDEzIDU6NDIgUE0NCj4gVG86IFJhZmFlbCBKLiBXeXNvY2tpOyBN
b29yZSwgUm9iZXJ0DQo+IENjOiBMZW4gQnJvd247IFd5c29ja2ksIFJhZmFlbCBKOyBCcm93biwg
TGVuOyBsaW51eCBhY3BpDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMTMvMTZdIEFDUElDQTogTW92
ZSBfUFJUIHJlcGFpciBpbnRvIHRoZSBzdGFuZGFyZA0KPiBjb21wbGV4IHJlcGFpciBtb2R1bGUN
Cj4gDQo+ID4gPiA+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlLiBUaGlzIGNoYW5nZSBzaW1wbHkgbW92
ZXMgdGhlIHJlcGFpciBjb2RlDQo+ID4gPiA+IGZyb20gd2hlcmUgaXQgd2FzIG9yaWdpbmFsbHkg
aW1wbGVtZW50ZWQgdG8gdGhlIChtb3JlIHJlY2VudCkNCj4gPiA+ID4gcmVwYWlyIG1vZHVsZQ0K
PiA+IHdoZXJlIGl0IG5vdyBiZWxvbmdzLg0KPiA+ID4NCj4gPiA+IE9LLCBJJ2xsIGFwcGx5IHRo
aXMgb25lIHdpdGggYSBmaXhlZC11cCBjaGFuZ2Vsb2cuDQo+ID4NCj4gPiBBcHBsaWVkIG5vdy4N
Cj4gDQo+IEhpLCBCb2IgYW5kIFJhZmFlbCwNCj4gDQo+IEknbSBvdXQgb2YgdGhlIGRpYWxvZ3Vl
LiBJIHdhcyB3b3JraW5nIG9uIG90aGVyIHRoaW5ncy4NCj4gDQo+IFRoYW5rcyBmb3IgZG9pbmcg
c28gb24gUEFUQ0ggMTMtMTUgZm9yIG1lLg0KPiBJIGZvdW5kIHRoZW0gaW4gdGhlIGJsZWVkaW5n
LWVkZ2UgYnJhbmNoIG9mIGxpbnV4LXBtIHJlcG8uDQo+IA0KPiBNYW55IG9mIHRoZSBjb21taXQg
bG9nIGlzc3VlcyBhcmUgaXNzdWVzIGhhcHBlbmVkIGFsb25nIHdpdGggdGhlIHJlbGVhc2UNCj4g
YXV0b21hdGlvbi4NCj4gSSBqdXN0IHBsYXllZCBhIG1vbmtleSByb2xlIGluIHRoZSByZWxlYXNl
IHByb2Nlc3Mgd2l0aCBzb21lIGNvbW1pdHRlZA0KPiB0ZXN0cyBwZXJmb3JtZWQuDQo+IEkgYWdy
ZWUgaXQncyBhIGtpbmQgb2YgcG9saWN5IGlzc3Vlcy4gSSB3aWxsIGltcHJvdmUgdGhlIHJlbGVh
c2UgcHJvY2Vzcw0KPiBjb250aW51b3VzbHkuDQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4gLUx2DQo=
