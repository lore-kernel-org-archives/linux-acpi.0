From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 0/5] ACPI / sysfs: Cleanup sysfs table handling code
Date: Wed, 17 Aug 2016 01:46:24 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC0EAC6@SHSMSX101.ccr.corp.intel.com>
References: <cover.1471337441.git.lv.zheng@intel.com>
 <CAJZ5v0j6eg9YvBrdqn-z0u8Rz1VtTdVcqxHJK+jsGC8DLc2Q_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:54961 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753409AbcHQBrF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Aug 2016 21:47:05 -0400
In-Reply-To: <CAJZ5v0j6eg9YvBrdqn-z0u8Rz1VtTdVcqxHJK+jsGC8DLc2Q_g@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

SGksDQoNCj4gRnJvbTogcmp3eXNvY2tpQGdtYWlsLmNvbSBbbWFpbHRvOnJqd3lzb2NraUBnbWFp
bC5jb21dIE9uIEJlaGFsZiBPZiBSYWZhZWwgSi4gV3lzb2NraQ0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIDAvNV0gQUNQSSAvIHN5c2ZzOiBDbGVhbnVwIHN5c2ZzIHRhYmxlIGhhbmRsaW5nIGNvZGUN
Cj4gDQo+IE9uIFR1ZSwgQXVnIDE2LCAyMDE2IGF0IDEwOjUyIEFNLCBMdiBaaGVuZyA8bHYuemhl
bmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPiBUaGVyZSBhcmUgaXNzdWVzIGluIHN5c2ZzIHRhYmxl
IGhhbmRsaW5nIGNvZGU6DQo+ID4gMS4gSXQgY2Fubm90IGhhbmRsZSB0YWJsZSBsb2FkZWQgYnkg
TG9hZFRhYmxlIG9wY29kZSBleGVjdXRlZCBhZnRlcg0KPiA+ICAgIGFjcGlfc3lzZnNfaW5pdCgp
Ow0KPiA+IDIuIEl0J3Mgc2lnbmF0dXJlIGhhbmRsaW5nIGNvZGUgaXMgbm90IGNvcnJlY3QuDQo+
ID4NCj4gPiBUaGlzIHBhdGNoc2V0IGZpeGVzIHRoZXNlIGlzc3Vlcy4NCj4gPg0KPiA+IEx2IFpo
ZW5nICg1KToNCj4gPiAgIEFDUElDQTogVGFibGVzOiBSZW1vdmUgYWNwaV90Yl9pbnN0YWxsX2Zp
eGVkX3RhYmxlKCkNCj4gPiAgIEFDUElDQTogVGFibGVzOiBSZW1vdmUgd3JvbmcgdGFibGUgZXZl
bnQgbWFjcm9zDQo+ID4gICBBQ1BJQ0E6IFRhYmxlczogQWRkIG5ldyB0YWJsZSBldmVudHMgaW5k
aWNhdGluZyB0YWJsZQ0KPiA+ICAgICBpbnN0YWxsYXRpb24vdW5pbnN0YWxsYXRpb24NCj4gPiAg
IEFDUEkgLyBzeXNmczogRml4IGFuIGlzc3VlIGZvciBMb2FkVGFibGUgb3Bjb2RlDQo+ID4gICBB
Q1BJIC8gc3lzZnM6IFVwZGF0ZSBzeXNmcyBzaWduYXR1cmUgaGFuZGxpbmcgY29kZQ0KPiA+DQo+
ID4gIGRyaXZlcnMvYWNwaS9hY3BpY2EvYWN0YWJsZXMuaCB8ICAgIDcgKy0tLQ0KPiA+ICBkcml2
ZXJzL2FjcGkvYWNwaWNhL3RiZmFkdC5jICAgfCAgIDI0ICsrKysrKystLS0tLS0NCj4gPiAgZHJp
dmVycy9hY3BpL2FjcGljYS90Ymluc3RhbC5jIHwgICA3MyArKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIGRyaXZlcnMvYWNwaS9zeXNmcy5jICAgICAgICAgICB8
ICAgMzkgKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ID4gIGluY2x1ZGUvYWNwaS9hY3R5cGVzLmgg
ICAgICAgICB8ICAgMTYgKysrKy0tLS0tDQo+ID4gIDUgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0
aW9ucygrKSwgMTA4IGRlbGV0aW9ucygtKQ0KPiANCj4gUGF0Y2hlcyBbMS0zLzVdIGNsZWFybHkg
bW9kaWZ5IEFDUElDQS4gIEhhdmUgdGhleSBnb25lIGludG8gdGhlDQo+IHVwc3RyZWFtIGFscmVh
ZHk/DQoNCk5vLCB0aGV5IGFyZSBmaXhpbmcgYW4gdXJnZW50IHVzZXIgcmVwb3J0ZWQgYnVnLg0K
U28gSSBwb3N0ZWQgdGhlbSBmb3IgdGhlIHJlcG9ydGVycy4NCldlIGNhbiB3YWl0IHVudGlsIFBB
VENIIDEtMyBtZXJnZWQgaW4gdGhlIEFDUElDQSB1cHN0cmVhbS4NCg0KVGhhbmtzDQpMdg0K
