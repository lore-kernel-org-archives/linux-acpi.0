From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH V2] Change ACPI IPMI support to "default y"
Date: Fri, 21 Feb 2014 16:12:52 +0000
Message-ID: <1392999172.20109.47.camel@x230>
References: <20140220204028.GJ17949@sgi.com> <1392929163.20109.5.camel@x230>
	 <20140220205901.GM17949@sgi.com> <1392930047.20109.6.camel@x230>
	 <20140220212854.GO17949@sgi.com> <1392932363.20109.11.camel@x230>
	 <20140220220656.GT17949@sgi.com> <1392935204.20109.17.camel@x230>
	 <20140220224529.GV17949@sgi.com> <1392937781.20109.24.camel@x230>
	 <20140220235904.GZ17949@sgi.com>
	 <1AE640813FDE7649BE1B193DEA596E88024B228C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn1blp0187.outbound.protection.outlook.com ([207.46.163.187]:12759
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754370AbaBUQM6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Feb 2014 11:12:58 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88024B228C@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Content-ID: <09101956F3F9C84EABBADE2BBCAE1C2F@namprd05.prod.outlook.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "lv.zheng@intel.com" <lv.zheng@intel.com>
Cc: "rja@sgi.com" <rja@sgi.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

T24gRnJpLCAyMDE0LTAyLTIxIGF0IDAyOjE3ICswMDAwLCBaaGVuZywgTHYgd3JvdGU6DQoNCj4g
SW4gZmFjdCB0aGVyZSBpcyBhIHdvcmthcm91bmQgc29sdXRpb24gSSd2ZSBwb3N0ZWQgaGVyZToN
Cj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8yODMxODUxLw0KPiBUaGUgdXBk
YXRlZCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2ggY2FuIGJlIGZvdW5kIGF0Og0KPiBodHRwczovL2J1
Z3ppbGxhLmtlcm5lbC5vcmcvYXR0YWNobWVudC5jZ2k/aWQ9MTEyNjExDQo+IEl0IGlzIHRoZSBh
Y3BpLWlwbWkxMy5wYXRjaCBmaWxlLg0KDQpJIGRvbid0IHRoaW5rIHRoYXQgc29sdmVzIHRoZSB1
bmRlcmx5aW5nIHByb2JsZW0/IFdlJ3JlIHN0aWxsIGxlZnQgd2l0aA0Kbm8gZ3VhcmFudGVlIG9m
IG9yZGVyaW5nIGJldHdlZW4gQUNQSSBJUE1JIG9wZXJhdGlvbiByZWdpb24gc3VwcG9ydA0KYmVp
bmcgYXZhaWxhYmxlIGFuZCB0aGUgbG9hZGluZyBvZiBhIGRyaXZlciB0aGF0IG1heSByZWx5IG9u
IGl0Lg0KDQo+IEkgdGhpbmsgdGhlcmUgc2hvdWxkIGJlIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIEFD
UEkgcmVnaW9uIGFuZCBMaW51eCBrZXJuZWwgbW9kdWxlcy4NCj4gSW4gZmFjdCBvbiB0aGUgd2Vs
bC1rbm93biBvcGVyYXRpbmcgc3lzdGVtLCBfUkVHIGlzIGFsd2F5cyBpbnZva2VkIGF0IHRoZSBl
bmQgb2YgdGhlIElSUF9QTlBfU1RBUlRfREVWSUNFIGNvbXBsZXRpb25zLg0KPiBCdXQgd2UgbWF5
IHN0aWxsIGJlIGFibGUgdG8gcmV0dXJuIC1FUFJPQkVfREVGRVIgaW4gdGhlIHBvd2VyIG1ldGVy
IGRyaXZlciB3aGVuIGl0IGRldGVjdHMgZmFpbHVyZXMgY2F1c2VkIGJ5IHRoZSByZWFkaW5lc3Mg
c3RhdGUgb2YgdGhlIHJlZ2lvbiBoYW5kbGVycy4NCg0KV2UgZG9uJ3QgaGF2ZSBhIGd1YXJhbnRl
ZSB0aGF0IGl0J2xsIGhhcHBlbiBhdCBwcm9iZSB0aW1lLiBUaGUNCmNhcGFiaWxpdGllcyBsaXN0
IG1heSBiZSBzdGF0aWMsIGFuZCBzbyB3ZSdsbCBnZXQgb3VyIGZpcnN0IGZhaWx1cmUgb24NCmFu
IGF0dGVtcHRlZCB1c2Vyc3BhY2UgYWNjZXNzIGluc3RlYWQuDQoNCkl0IG1heSBiZSB0aGF0IENv
cmV5J3Mgc3VnZ2VzdGlvbiBzYXRpc2ZpZXMgdGhlIGNvbmNlcm5zIFJ1c3MgcmFpc2VkLg0KQnVp
bGRpbmcgSVBNSSBpbiBidXQgb25seSBwcm9iaW5nIGJ5IGRlZmF1bHQgb24gc3lzdGVtcyB0aGF0
IGRlY2xhcmUgYQ0KQk1DIGluIEFDUEkgb3IgRE1JIHNob3VsZCBhdm9pZCBib290LXRpbWUgZGVs
YXlzIHdoaWxlIHN0aWxsIGVuc3VyaW5nDQp0aGF0IHRoZSBmdW5jdGlvbmFsaXR5IGlzIGF2YWls
YWJsZSBvbiBzeXN0ZW1zIHdoZXJlIHRoZXJlJ3MgYSByZWFsDQpjaGFuY2UgdGhhdCB0aGUgZmly
bXdhcmUgZXhwZWN0cyB0aGUgT1MgdG8gcHJvdmlkZSBzdXBwb3J0Lg0KDQotLSANCk1hdHRoZXcg
R2FycmV0dCA8bWF0dGhldy5nYXJyZXR0QG5lYnVsYS5jb20+DQo=
