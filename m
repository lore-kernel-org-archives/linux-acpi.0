From: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH 1/3] nfit: in acpi_nfit_init, break on a 0-length table
Date: Fri, 9 Oct 2015 17:51:14 +0000
Message-ID: <1444413074.9638.4.camel@intel.com>
References: <1444254577-23744-1-git-send-email-vishal.l.verma@intel.com>
	 <1444254577-23744-2-git-send-email-vishal.l.verma@intel.com>
	 <x49bnc8j6ro.fsf@segfault.boston.devel.redhat.com>
	 <CAPcyv4hnFY7xCZ9e6kZrruj48Z9WfY3V5RU00Nxxb3sfbTV_JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35282 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbbJIRwJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Oct 2015 13:52:09 -0400
In-Reply-To: <CAPcyv4hnFY7xCZ9e6kZrruj48Z9WfY3V5RU00Nxxb3sfbTV_JQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <8F84B61DB31967428A49CE415A515F15@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Williams, Dan J" <dan.j.williams@intel.com>, "jmoyer@redhat.com" <jmoyer@redhat.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

T24gRnJpLCAyMDE1LTEwLTA5IGF0IDEwOjI3IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIEZyaSwgT2N0IDksIDIwMTUgYXQgMTA6MjMgQU0sIEplZmYgTW95ZXIgPGptb3llckByZWRo
YXQuY29tPg0KPiB3cm90ZToNCj4gPiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVs
LmNvbT4gd3JpdGVzOg0KPiA+IA0KPiA+ID4gSWYgYWNwaV9uZml0X2luaXQgaXMgY2FsbGVkIChz
dWNoIGFzIGZyb20gbmZpdF90ZXN0KSwgd2l0aCBhbg0KPiA+ID4gbmZpdCB0YWJsZQ0KPiA+ID4g
dGhhdCBoYXMgbW9yZSBtZW1vcnkgYWxsb2NhdGVkIHRoYW4gaXQgbmVlZHMgKGFuZCBhIHNpbWls
YXJseQ0KPiA+ID4gbGFyZ2UNCj4gPiA+ICdzaXplJyBmaWVsZCwgYWRkX3RhYmxlcyB3b3VsZCBo
YXBwaWx5IGtlZXAgYWRkaW5nIG51bGwgU1BBIFJhbmdlDQo+ID4gPiB0YWJsZXMNCj4gPiA+IGZp
bGxpbmcgdXAgYWxsIGF2YWlsYWJsZSBtZW1vcnkuDQo+ID4gPiANCj4gPiA+IE1ha2UgaXQgZnJp
ZW5kbGllciBieSBicmVha2luZyBvdXQgaWYgYSAwLWxlbmd0aCBoZWFkZXIgaXMgZm91bmQNCj4g
PiA+IGluIGFueQ0KPiA+ID4gb2YgdGhlIHRhYmxlcy4NCj4gPiANCj4gPiBTaG91bGRuJ3QgdGhh
dCBhdCBsZWFzdCBzcGV3IGEgd2FybmluZz8gIE9yIGRvZXMgdGhlIHNwZWMgYWxsb3cgZm9yDQo+
ID4gemVyby1sZW5ndGggdGFibGVzPw0KPiA+IA0KPiANCj4gVGhlIHNwZWMgYWxsb3dzIGZvciB6
ZXJvIGxlbmd0aCB0YWJsZXMgYnV0IHRoZSBmaXJtd2FyZQ0KPiBpbXBsZW1lbnRhdGlvbg0KPiBz
aG91bGQgYmUgc2VsZiBjb25zaXN0ZW50IGFuZCBub3QgcmVwb3J0IGEgdG90YWwgTkZJVCBzaXpl
IHRoYXQgaXMNCj4gZ3JlYXRlciB0aGFuIHRoZSBzdW0gb2YgdGhlIHNpemUgb2YgdGhlIHN1Yi1z
dHJ1Y3R1cmVzLiAgQSB3YXJuaW5nIC8NCj4gbnVkZ2UgdG8gZmlybXdhcmUgZGV2ZWxvcGVycyB0
byBmaXggdGhlaXIgc3R1ZmYgc2VlbXMgYXBwcm9wcmlhdGUuDQoNCkFncmVlZCwgSSdsbCBhZGQg
YSB3YXJuaW5nLiBUaGUgY2F2ZWF0IGlzLCB0aGUgZm9sbG93aW5nICgzLzMpIHBhdGNoIHRvDQpu
Zml0IHRlc3Qgd2lsbCB0cmlnZ2VyIHRoZSB3YXJuaW5nIGZvciB0aGUgZmlyc3QsIG5vbi1ob3Rw
bHVnIHBhc3MsIGFzDQpJIGp1c3QgY2FsY3VsYXRlIHRoZSBzaXplIGFuZCBhbGxvY2F0ZSB0aGUg
YnVmZmVyIG9uY2UsIGFuZCB0aGUgZmlyc3QNCnBhc3Mgd2lsbCBoYXZlIHRoZSByZWd1bGFyIG5m
aXQsIGFuZCB0aGUgc2Vjb25kIHBhc3Mgd2lsbCBoYXZlIG5ldw0KaG90cGx1ZyBlbnRyaWVzLi4g
SXMgdGhhdCBPSyBvciBzaG91bGQgSSBsb29rIGF0IHJld29ya2luZyB0aGF0Pw==
