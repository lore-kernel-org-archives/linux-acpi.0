From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPI / OSL: Fix a regression by returning table size
 via acpi_get_table_with_size()
Date: Fri, 9 Dec 2016 06:09:16 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A2B44DD@SHSMSX101.ccr.corp.intel.com>
References: <cover.1480490191.git.lv.zheng@intel.com>
 <b8107fa792de9cb442c342433043604080699fc6.1481249993.git.lv.zheng@intel.com>
 <CAJZ5v0hqYRGU_Ok8ZGhv4OS=JYj7YY5hxhFnTqZSdw=cpV3-mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46086 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932528AbcLIGJW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Dec 2016 01:09:22 -0500
In-Reply-To: <CAJZ5v0hqYRGU_Ok8ZGhv4OS=JYj7YY5hxhFnTqZSdw=cpV3-mw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>

SGksIFJhZmFlbA0KDQo+IEZyb206IHJqd3lzb2NraUBnbWFpbC5jb20gW21haWx0bzpyand5c29j
a2lAZ21haWwuY29tXSBPbiBCZWhhbGYgT2YgUmFmYWVsIEouIFd5c29ja2kNCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gQUNQSSAvIE9TTDogRml4IGEgcmVncmVzc2lvbiBieSByZXR1cm5pbmcgdGFi
bGUgc2l6ZSB2aWENCj4gYWNwaV9nZXRfdGFibGVfd2l0aF9zaXplKCkNCj4gDQo+IE9uIEZyaSwg
RGVjIDksIDIwMTYgYXQgMzoyMSBBTSwgTHYgWmhlbmcgPGx2LnpoZW5nQGludGVsLmNvbT4gd3Jv
dGU6DQo+ID4gVGhlIHJldHVybmVkIHNpemUgaXMgc3RpbGwgdXNlZCBieSB0aGUgZHJpdmVycy4N
Cj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVs
LmNvbT4NCj4gPiBDYzogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogTHYgWmhlbmcgPGx2LnpoZW5nQGludGVsLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9hY3BpL29zbC5jIHwgICAgOCArKysrKystLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvYWNwaS9vc2wuYyBiL2RyaXZlcnMvYWNwaS9vc2wuYw0KPiA+IGluZGV4IDVi
ZWYwZjY1Li5hZGYxZWM0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9vc2wuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvYWNwaS9vc2wuYw0KPiA+IEBAIC00NDUsOCArNDQ1LDEyIEBAIHZvaWQg
X19yZWYgYWNwaV9vc191bm1hcF9tZW1vcnkodm9pZCAqdmlydCwgYWNwaV9zaXplIHNpemUpDQo+
ID4NCj4gPiAgICAgICAgIHN0YXR1cyA9IGFjcGlfZ2V0X3RhYmxlKHNpZ25hdHVyZSwgaW5zdGFu
Y2UsIG91dF90YWJsZSk7DQo+ID4gICAgICAgICBpZiAoQUNQSV9TVUNDRVNTKHN0YXR1cykpIHsN
Cj4gPiAtICAgICAgICAgICAgICAgLyogTm8gbG9uZ2VyIHVzZWQgYnkgZWFybHlfYWNwaV9vc191
bm1hcF9tZW1vcnkoKSAqLw0KPiA+IC0gICAgICAgICAgICAgICAqdGJsX3NpemUgPSAwOw0KPiA+
ICsgICAgICAgICAgICAgICAvKg0KPiA+ICsgICAgICAgICAgICAgICAgKiBObyBsb25nZXIgdXNl
ZCBieSBlYXJseV9hY3BpX29zX3VubWFwX21lbW9yeSgpLCBidXQgc3RpbGwNCj4gPiArICAgICAg
ICAgICAgICAgICogdXNlZCBieSB0aGUgQUNQSSB0YWJsZSBkcml2ZXJzLg0KPiA+ICsgICAgICAg
ICAgICAgICAgKi8NCj4gPiArICAgICAgICAgICAgICAgaWYgKCpvdXRfdGFibGUpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgKnRibF9zaXplID0gKCpvdXRfdGFibGUpLT5sZW5ndGg7DQo+
ID4gICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgIHJldHVybiAoc3RhdHVzKTsNCj4gPiAtLQ0K
PiANCj4gVGhlIGNoYW5nZWxvZyBkb2Vzbid0IGV4cGxhaW4gYW55dGhpbmcuICBQbGVhc2Ugc2F5
IChhKSB3aGF0IHRoZQ0KPiBwcm9ibGVtIGlzIGFuZCAoYikgaG93IGl0IGlzIGJlaW5nIGFkZHJl
c3NlZCBieSB5b3VyIHBhdGNoLg0KDQpPSywgSSdsbCBhbHNvIGFkZCBmaXhlcyB0YWcgdG8gaXQu
DQoNClRoYW5rcw0KTHYNCg==
