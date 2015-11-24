From: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH 1/3] nfit: Account for table size length variation
Date: Tue, 24 Nov 2015 17:47:00 +0000
Message-ID: <1448387220.27481.12.camel@intel.com>
References: <cover.1448045168.git.linda.knippers@hpe.com>
		 <e65332cc9dbb7eff02f739aa5ba357d4097b4e6a.1448045168.git.linda.knippers@hpe.com>
	 <1448320884.27481.2.camel@intel.com> <56548F20.7090407@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8478 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225AbbKXRrE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Nov 2015 12:47:04 -0500
In-Reply-To: <56548F20.7090407@hpe.com>
Content-Language: en-US
Content-ID: <49FFC937CA3721438A9AAC5DCE4CFB99@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linda.knippers@hpe.com" <linda.knippers@hpe.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "toshi.kani@hpe.com" <toshi.kani@hpe.com>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "elliott@hpe.com" <elliott@hpe.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

T24gVHVlLCAyMDE1LTExLTI0IGF0IDExOjI0IC0wNTAwLCBMaW5kYSBLbmlwcGVycyB3cm90ZToN
Cj7CoA0KPiBBY3R1YWxseSwgdGhlIHNwZWMgaXMgcHJldHR5IGNsZWFyIGluIHRoaXMgY2FzZS7C
oMKgSWYgeW91IGxvb2sgYXQgdGhlDQo+IGxlbmd0aCBkZWZpbml0aW9uIGZvciB0aGF0IHRhYmxl
ICg1LTEzMykgaXQgc2F5czoNCj4gDQo+IAlMZW5ndGggaW4gYnl0ZXMgZm9yIGVudGlyZSBzdHJ1
Y3R1cmUuDQo+IAlUaGUgbGVuZ3RoIG9mIHRoaXMgc3RydWN0dXJlIGlzIGVpdGhlciAzMiBieXRl
cyBvciA4MCBieXRlcy4gVGhlDQo+IAlsZW5ndGggb2YgdGhlIHN0cnVjdHVyZSBjYW4gYmUgMzIg
Ynl0ZXMgb25seSBpZiB0aGUgTnVtYmVyIG9mDQo+IAlCbG9jayBDb250cm9sIFdpbmRvd3MgZmll
bGQgaGFzIGEgdmFsdWUgb2YgMC4NCj4gDQo+IFRoZSBzdHJ1Y3R1cmUgaXMgODAgYnl0ZXMgYnV0
IGl0IGlzIGxlZ2FsIHRvIGhhdmUgYSAzMi1ieXRlIHRhYmxlLg0KPiBXZSBoaXQgYSBzaW1pbGFy
IHByb2JsZW0gd2l0aCB0aGUgb3JpZ2luYWwgTkZJVCBjb2RlLsKgwqBXZSBjb3VsZA0KPiBleHBs
aWNpdGx5IGNoZWNrIGZvciBhIHNpemUgb2YgMzIgYnV0IHdlIGRpZG4ndCBiZWZvcmUuDQoNClRo
YW5rcywgSSBtaXNzZWQgdGhhdC4gTm8gb2JqZWN0aW9ucyBmcm9tIG1lIGFueSBtb3JlIDopDQoN
Cj4gDQo+ID4gSWYgd2UgbWFrZSBhZGRfdGFibGVzIHByb2Nlc3Mgb25seSBoZWFkZXIubGVuZ3Ro
IGFuZCBhY2NlcHQgdGhlDQo+ID4gc2hvcnRlbmVkIHRhYmxlLCB0aGVyZSBpcyBub3RoaW5nIHRv
IHRlbGwgZnV0dXJlIGNvZGUgdGhhdCB0aGUNCj4gPiBzdHJ1Y3R1cmUNCj4gPiB0aGF0IHBpZWNl
IG9mIG1lbW9yeSBpcyBjYXN0ZWQgdG8gaXMgYSB0cnVuY2F0ZWQgb25lLg0KPiA+IA0KPiA+IFRo
b3VnaHRzPw0KPiANCj4gSWYgd2Ugd2FudCB0byBiZSBtb3JlIHBhcmFub2lkIGFib3V0IGJ1Z2d5
IEZXIHdoZW4gd2UncmUgY29tcGFyaW5nIG9sZA0KPiBhbmQgbmV3IHRhYmxlcywgd2UgY291bGQg
Y29tcGFyZSBiYXNlZCBvbiB0aGUgbGVuZ3RoIG9mIHRoZSBvbGQgYW5kDQo+IG5ldw0KPiB0YWJs
ZXMgc2luY2Ugd2UgaGF2ZSBib3RoIHBpZWNlcyBvZiBpbmZvcm1hdGlvbi7CoMKgVGhhdCB3b3Vs
ZCBsZXQgeW91DQo+IGNhdGNoDQo+IHRoZSBjYXNlIHdoZXJlIGEgdGFibGUgc2l6ZSBjaGFuZ2Vz
IGR1cmluZyBhIGhvdHBsdWcgZXZlbnQgb3Igd2hlbmV2ZXINCj4gdGhlDQo+IF9GSVQgaXMgcHJv
Y2Vzc2VkLsKgwqBTaW5jZSB5b3Ugd2VyZSBjb21wYXJpbmcgYmFzZWQgb24gc3RydWN0dXJlIHNp
emUNCj4gaW5zdGVhZA0KPiBvZiBoZWFkZXIgbGVuZ3RoLCBJIGRpZG4ndCBjaGFuZ2UgdGhhdC4N
Cg0KQWdyZWVkIHRoaXMgY2FuIGJlIGluY3JlbWVudGFsIHdvcmsuDQoNCj4gDQo+IC0tIGxqaw0K
PiA+IA0KPiA+IAktVmlzaGFsDQo+ID4gDQo+IA==
