From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPI / EC: handle ECDT EC and DSDT EC simultaneously
Date: Fri, 28 Apr 2017 06:33:25 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE9A1C9@SHSMSX101.ccr.corp.intel.com>
References: <20170420201219.21568-1-drake@endlessm.com>
 <CAD8Lp44nXRv0rpZgPw1f0LZ_bcn74fQFzG6HBxRcL1QAWxBHTQ@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886CE9973E@SHSMSX101.ccr.corp.intel.com>
 <2213549.Q4Z823dSPo@aspire.rjw.lan>
 <CAD8Lp46+BQxcB9hgp0wXvWkA32XksYdG1h-vZOzQ5pT0P-0Ydg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:44791 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424023AbdD1Gda (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Apr 2017 02:33:30 -0400
In-Reply-To: <CAD8Lp46+BQxcB9hgp0wXvWkA32XksYdG1h-vZOzQ5pT0P-0Ydg@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "chiu@endlessm.com" <chiu@endlessm.com>, "linux@endlessm.com" <linux@endlessm.com>

SGksIERhbmllbA0KDQo+IEZyb206IERhbmllbCBEcmFrZSBbbWFpbHRvOmRyYWtlQGVuZGxlc3Nt
LmNvbV0NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gQUNQSSAvIEVDOiBoYW5kbGUgRUNEVCBFQyBh
bmQgRFNEVCBFQyBzaW11bHRhbmVvdXNseQ0KPiANCj4gT24gVGh1LCBBcHIgMjcsIDIwMTcgYXQg
NjozMyBQTSwgUmFmYWVsIEouIFd5c29ja2kgPHJqd0Byand5c29ja2kubmV0PiB3cm90ZToNCj4g
PiBDYW4geW91IHN1Z2dlc3QgYSBwYXRjaCwgcGxlYXNlPw0KPiA+DQo+ID4gSWRlYWxseSwgc29t
ZXRoaW5nIHRoYXQgY2FuIGJlIHRlc3RlZD8NCj4gDQo+IEkgdGhpbmsgSSB1bmRlcnN0YW5kIEx2
J3Mgc3VnZ2VzdGlvbnMgc28gd2Ugd2lsbCBub3cgdGVzdCB0aGUNCj4gZm9sbG93aW5nIGNoYW5n
ZSBpbiBvcmRlciB0byBjaGVjayBpZiBlaXRoZXIgb3IgYm90aCBvZiB0aGUgYWRkZWQgRFNEVA0K
PiBFQyBjaGVja3MgY2FuIGhlbHAgdXMuDQo+IA0KPiBodHRwczovL2dpc3QuZ2l0aHViLmNvbS9k
c2QvZjUwYTYzYzlmMzE3Nzk0MzZiZDI4MGM3NjI1M2UzN2MNCg0KV2UgZGlkIGhhdmUgYSBnb29k
IHRhbGssIGFuZCBsZWZ0IGdvb2QgZW5naW5lZXJpbmcgbWF0ZXJpYWxzIGluIGNvbW11bml0eSBh
cm91bmQgdGhpcyBpc3N1ZS4NCg0KSG93ZXZlciBpbiB0aGUgYWJvdmUgZGVidWdnaW5nIGNvbW1p
dCwgSSdtIHN1cmUgd2Ugc2hvdWxkbid0IGludm9rZSBfU1RBIGluIGVjX3BhcnNlX2RldmljZSgp
Lg0KQXMgdGhlIHJlYXNvbnMgYmVsb3cuDQoNCkluIHRoZW9yeSwgdXNpbmcgRFNEVCBFQyBhcyBi
b290IEVDIGlzIG5vdCBzcGVjIGNvbXBsaWFudC4NCkl0J3MganVzdCBhIHdvcmthcm91bmQgaW4g
TGludXggZm9yIG5vdCBrbm93aW5nIHRoZSBXaW5kb3dzIGRldmljZSBlbnVtZXJhdGlvbiBvcmRl
cnMuDQpFc3BlY2lhbGx5LCB0aGUgb3JkZXIgb2YgZXhlY3V0aW5nIHRoZSBjb250cm9sIG1ldGhv
ZCBleGVjdXRpb24gdGhhdCBtYXkgY29udGFpbiBoYXJkd2FyZSBpbml0aWFsaXphdGlvbiBjb2Rl
Lg0KU3VjaCBjb250cm9sIG1ldGhvZHMgYXJlIG1vc3RseSBfU1RBL19JTkkuDQpXaGlsZSBmb3Ig
X0hJRC9fQ1JTL19HUEUvX0JCTiwgaXQgaXMgdW5saWtlbHkgdG8gdHJpZ2dlciBvcmRlciBpc3N1
ZXMgYW5kIGl0IG1pZ2h0IGJlIHNhZmUgdG8gaW52b2tlIHRoZW0gc3VjaCBlYXJseS4NCg0KSWYg
eW91IGV4ZWN1dGVzIF9TVEEgaGVyZSwgeW91IG1pZ2h0IGJyaW5nIEVDLl9TVEEgZXhlY3V0aW9u
IHByaW9yIHRoYW4gb3RoZXIgX0lOSS9fU1RBIGFuZCBtYXkgYnJlYWsgc29tZSBvdGhlciBwbGF0
Zm9ybXMuDQpTbyBmb3Igbm93LCBJIHRoaW5rIHlvdSBzaG91bGQgb25seSBhZGQgc2ltcGxlIHNh
bml0eSBjaGVja3MgZm9yIGlvcG9ydHMuDQpBbmQgc2luY2UgeW91IGhhdmUgdGhlIGRpcmVjdCBh
Y2Nlc3NlcyB0byB0aGVzZSBhZmZlY3RlZCBwbGF0Zm9ybXMsIHlvdSBjYW4gaGVscCB0byBwcm92
aWRlIHN1Y2ggd29ya2luZyBzYW5pdHkgY2hlY2sgaW1wcm92ZW1lbnRzIGZvciB1cy4NCg0KVGhh
bmtzIGFuZCBiZXN0IHJlZ2FyZHMNCkx2DQo=
