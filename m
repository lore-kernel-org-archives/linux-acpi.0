From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 4/6] ACPI / osi: Fix default _OSI(Darwin) support
Date: Fri, 29 Apr 2016 02:07:53 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB82EF4@SHSMSX101.ccr.corp.intel.com>
References: <cover.1461656216.git.lv.zheng@intel.com>
 <e8ea6e8841adce9e10e5bd0b278b47a7c799c276.1461736123.git.lv.zheng@intel.com>
 <36DF59CE26D8EE47B0655C516E9CE64028748233@shsmsx102.ccr.corp.intel.com>
 <2223787.tzTyTqLAjo@vostro.rjw.lan>
 <1AE640813FDE7649BE1B193DEA596E883BB82C18@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9459 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244AbcD2CH7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Apr 2016 22:07:59 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB82C18@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>

SGksIFJhZmFlbA0KDQo+IEZyb206IGxpbnV4LWFjcGktb3duZXJAdmdlci5rZXJuZWwub3JnIFtt
YWlsdG86bGludXgtYWNwaS0NCj4gb3duZXJAdmdlci5rZXJuZWwub3JnXSBPbiBCZWhhbGYgT2Yg
WmhlbmcsIEx2DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjIgNC82XSBBQ1BJIC8gb3NpOiBGaXgg
ZGVmYXVsdCBfT1NJKERhcndpbikgc3VwcG9ydA0KPiANCg0KW0x2IFpoZW5nXSANClNraXAuDQoN
Cj4gPiA+ID4gQEAgLTMzMSw2ICszMzYsMjQgQEAgc3RhdGljIHN0cnVjdCBkbWlfc3lzdGVtX2lk
IGFjcGlfb3NpX2RtaV90YWJsZVtdDQo+ID4gPiA+IF9faW5pdGRhdGEgPSB7DQo+ID4gPiA+ICAJ
CX0sDQo+ID4gPiA+ICAJfSwNCj4gPiA+ID4NCj4gPiA+ID4gKwkvKg0KPiA+ID4gPiArCSAqIEVu
YWJsZSBfT1NJKCJEYXJ3aW4iKSBmb3IgYWxsIGFwcGxlIHBsYXRmb3Jtcy4NCj4gPiA+ID4gKwkg
Ki8NCj4gPiA+ID4gKwl7DQo+ID4gPiA+ICsJLmNhbGxiYWNrID0gZG1pX2VuYWJsZV9vc2lfZGFy
d2luLA0KPiA+ID4gPiArCS5pZGVudCA9ICJBcHBsZSBoYXJkd2FyZSIsDQo+ID4gPiA+ICsJLm1h
dGNoZXMgPSB7DQo+ID4gPiA+ICsJCSAgICAgRE1JX01BVENIKERNSV9TWVNfVkVORE9SLCAiQXBw
bGUgSU5DLiIpLA0KPiA+ID4gPiArCQl9LA0KPiA+ID4gPiArCX0sDQo+ID4gPiA+ICsJew0KPiA+
ID4gPiArCS5jYWxsYmFjayA9IGRtaV9lbmFibGVfb3NpX2RhcndpbiwNCj4gPiA+ID4gKwkuaWRl
bnQgPSAiQXBwbGUgaGFyZHdhcmUiLA0KPiA+ID4gPiArCS5tYXRjaGVzID0gew0KPiA+ID4gPiAr
CQkgICAgIERNSV9NQVRDSChETUlfU1lTX1ZFTkRPUiwgIkFwcGxlIENvbXB1dGVyLCBJTkMuIiks
DQo+ID4gPiA+ICsJCX0sDQo+ID4gPiA+ICsJfSwNCj4gPiA+ID4gKw0KPiA+ID4gVGhlICB2ZW5k
b3IgaWQgc2hvdWxkIGJlICdBcHBsZSBJbmMuJyBhbmQgJ0FwcGxlIENvbXB1dGVyLCBJbmMuJyBp
bnN0ZWFkLg0KPiA+DQo+ID4gSWYgdGhpcyBpcyB0aGUgb25seSBwcm9ibGVtIHdpdGggdGhpcyBw
YXRjaCwgSSBjYW4gZml4IGl0IHVwLiAgTm8gbmVlZCB0byByZXNlbmQuDQo+IFtMdiBaaGVuZ10N
Cj4gVGhpcyBpcyB0aGUgb25seSBwcm9ibGVtLg0KPiBUaGFua3MgZm9yIHRoZSBoZWxwLg0KPiAN
Cg0KW0x2IFpoZW5nXSANCkkganVzdCBzZW50IFVQREFURSBvZiBQQVRDSCA0LzYgYW5kIFBBVENI
IDYvNiB0byB0aGUgbWFpbGluZyBsaXN0IHdpdGggdGhpcyBjb3JyZWN0ZWQuDQpJIHdhcyBob3Bp
bmcgdGhleSBjb3VsZCB1cGRhdGUgcGF0Y2h3b3JrIGNvbnRlbnQgc28gdGhhdCB0aGUgQnVnemls
bGEgcmVwb3J0ZXJzIG1pZ2h0IHVzZSB0aGUgdXBkYXRlZCBwYXRjaGVzIGZvciBjb25maXJtYXRp
b24uDQpUaGUgTWVzc2FnZS1JZChzKSBvZiB0aGUgMiBwYXRjaGVzIHdlcmUga2VwdCBhcyBzYW1l
IGFzIHRoZSBvbGQgb25lcy4NCg0KVGhhbmtzIGFuZCBiZXN0IHJlZ2FyZHMNCi1Mdg0K
