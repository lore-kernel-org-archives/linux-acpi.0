From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: 4.9-rc1: [TMP_] ACPI namespace lookup failure, AE_ALREADY_EXISTS
Date: Mon, 24 Oct 2016 06:10:43 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A257836@SHSMSX101.ccr.corp.intel.com>
References: <1476913001.7633.13.camel@intel.com>
         <1AE640813FDE7649BE1B193DEA596E886A256F5B@SHSMSX101.ccr.corp.intel.com>
 <1477216090.7258.9.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:58921 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752429AbcJXGKr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Oct 2016 02:10:47 -0400
In-Reply-To: <1477216090.7258.9.camel@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Deak, Imre" <imre.deak@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

SGksIEltcmUNCg0KPiBGcm9tOiBEZWFrLCBJbXJlDQo+IFN1YmplY3Q6IFJlOiA0LjktcmMxOiBb
VE1QX10gQUNQSSBuYW1lc3BhY2UgbG9va3VwIGZhaWx1cmUsIEFFX0FMUkVBRFlfRVhJU1RTDQo+
IA0KPiBPbiBGcmksIDIwMTYtMTAtMjEgYXQgMjI6NDYgKzAzMDAsIFpoZW5nLCBMdiB3cm90ZToN
Cj4gPsKgWy4uLl0NCj4gPiBJIGNoZWNrZWQgdGhlIGNvZGUsIG9ubHkgZm91bmQgb25lIGlzc3Vl
Lg0KPiA+IEFuZCBJJ20gbm90IHN1cmUgaWYgaXQgaXMgcmVsYXRlZC4NCj4gPiBQbGVhc2Ugc2Vu
ZCBtZSB0aGUgZnVsbCBkbWVzZyBjb250YWluaW5nIHRoZSBlcnJvcnMgYW5kIHRoZSBhY3BpZHVt
cA0KPiA+IG91dHB1dC4NCj4gDQo+IEkgYXR0YWNoZWQgdGhlIGRtZXNnIGNvbnRhaW5pbmcgdGhl
IGVycm9yIGR1cmluZyBib290IChoYXBwZW5lZCAxIG91dA0KPiBvZiAyMDAgYm9vdHMpLCBkdXJp
bmcgcmVib290ICgyMCBvdXQgb2YgMjAwIHJlYm9vdHMpLCBkdXJpbmcgc3VzcGVuZA0KPiAoaGFw
cGVuZWQgYWxsIHRoZSB0aW1lKS4NCj4gDQo+IEkgYXR0YWNoZWQgdGhlIGFjcGlkdW1wIG91dHB1
dC4NCg0KVGhhbmtzIGZvciB0aGUgaW5mb3JtYXRpb24uDQoNCj4gDQo+ID4gUGxlYXNlIGdpdmUg
dGhlIGZpeCBhIHRyeSAoc2VlIGF0dGFjaG1lbnQpLg0KPiANCj4gVGhlIHBhdGNoIGRpZG4ndCBh
cHBseSBvbiA0LjktcmMxIG9yIExpbnVzJyBtYXN0ZXIsIHBsZWFzZSBzZWUgdGhlDQo+IGF0dGFj
aGVkIHBhdGNoIGZvciBteSBhdHRlbXB0IHRvIHJlc29sdmUgdGhlIGNvbmZsaWN0cy4gV2l0aCB0
aGUgcGF0Y2gNCj4gYXBwbGllZCBJIGNvdWxkIHN0aWxsIHRyaWdnZXIgdGhlIHNhbWUgcHJvYmxl
bSBkdXJpbmcgc3VzcGVuZC4NCg0KQ291bGQgeW91IHB1bGwgdGhpcyBicmFuY2ggZGlyZWN0bHkg
YW5kIHRyeSBhZ2FpbjoNCmh0dHBzOi8vZ2l0aHViLmNvbS96ZXRhbG9nL2xpbnV4DQpCcmFuY2g6
IGFjcGljYS1sb2NrDQoNCkkndmUgcHVzaGVkIHRoZSBmaXggY29tbWl0IHRoZXJlLg0KDQpUaGFu
a3MgaW4gYWR2YW5jZS4NCg0KQmVzdCByZWdhcmRzDQpMdg0KDQo+IA0KPiAtLUltcmUNCj4gDQo+
ID4gSSdtIHNvcnJ5IGZvciBzZW5kaW5nIGZpeCBwYXRjaCB1c2luZyBhdHRhY2htZW50Lg0KPiA+
IEl0J3Mgbm90IGNvbnZlbmllbnQgZm9yIG1lIGR1ZSB0byBteSBjdXJyZW50IHdvcmtpbmcgZW52
aXJvbm1lbnQuDQo+ID4NCj4gPiBUaGFua3MgYW5kIGJlc3QgcmVnYXJkcw0KPiA+IEx2DQo=
