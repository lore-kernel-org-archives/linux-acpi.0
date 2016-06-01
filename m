From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 3/3] ACPI / button: Send "open" state after
 boot/resume
Date: Wed, 1 Jun 2016 07:51:05 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BBB71A8@SHSMSX101.ccr.corp.intel.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
	<cover.1464332745.git.lv.zheng@intel.com>
	<4472be3d63af1b56c2f0f7cfbccd73538dc36252.1464332745.git.lv.zheng@intel.com>
	<CAN+gG=EaTOSbkx82HCYwLOtR9b_6291obNnpokJ2PhOXD8bWHw@mail.gmail.com>
	<1AE640813FDE7649BE1B193DEA596E883BBB5C64@SHSMSX101.ccr.corp.intel.com>
 <CAN+gG=Fzx0K6O4K9GRAjCe9Bg8-iGQhsYAiOdBZRpwoGeafRuw@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E883BBB6FAA@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBB6FAA@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Bastien Nocera:" <hadess@hadess.net>, "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
List-Id: linux-acpi@vger.kernel.org

SGksDQoNCltjdXRdDQo+ID4gV2UgY291bGQgaGF2ZSBhIHBhcmFtZXRlciAoc2F5ICJzZW5kX2xp
ZF9vcGVuX29uX3Jlc3VtZSIgb3INCj4gPiAidXNlX2Jpb3NfbGlkX3ZhbHVlIikgaW4gYWNwaS9i
dXR0b24uYyB3aGljaCB3b3VsZCBhbGxvdyBwZW9wbGUgdG8NCj4gPiBjaG9vc2UgaWYgdGhleSB3
YW50IHRoZSAibmV3IiBiZWhhdmlvciBvciB0aGUgb2xkIG9uZS4gQW5kIHdlIGNvdWxkDQo+ID4g
YWxzbyBhZGQgc29tZSBETUkgbWF0Y2hpbmcgZm9yIHRoZSBtZXNzZWQgdXAgbGFwdG9wcy90YWJs
ZXRzIHdoZXJlDQo+IHdlDQo+ID4gZm9yY2Ugb25lIG9yIHRoZSBvdGhlciBxdWlyay4gV2hlbiB3
ZSBhZ3JlZSB0aGF0IHVzZXIgc3BhY2Ugbm93DQo+ID4gYmVoYXZlcyBnZW50bHkgd2l0aCB1cywg
d2UgY291bGQgdGhlbiByZW1vdmUgZW50aXJlbHkgdGhlIHF1aXJrIGFuZA0KPiA+IHRoZSBkbWkg
bWF0Y2hpbmcuDQo+ID4NCj4gPiBIb3cgZG9lcyB0aGF0IHNvdW5kPw0KPiBbTHYgWmhlbmddDQo+
IFRoZSBjaG9pY2VzIGFyZSBpbiBteSBmaXJzdCByZXZpc2lvbi4NCj4gSSBjb3VsZCByZXN0b3Jl
IGl0IGJhY2sgYW5kIHJlLXNlbmQgdGhpcyBzZXJpZXMuDQo+IEFsc28gSSBuZWVkIHRvIHVwZGF0
ZSBQQVRDSCAwMiB0byBlbGltaW5hdGUgd3JvbmcgSVNfRVJSX1ZBTFVFKCkuDQpbTHYgWmhlbmdd
IA0KSSBmb3Jnb3QgdG8gbWVudGlvbi4NCklNTywgaWYgdGhlIGlzc3VlIGlzIGJlY2F1c2Ugb2Yg
dW5jZXJ0YWluIGdhcHMsIG5vdCBhIGNvbmZpcm1lZCBCSU9TIGJ1Zywgb3IgYSBjb25maXJtZWQg
Z2FwIHRoYXQgaGFzIHRvIGJlIHNvbHZlZCBpbiBhIHNwaXJpdCBvZiBjb21wcm9taXNlLCB3ZSBz
aG91bGQgbm90IGFkZCBxdWlya3MuDQpXZSBjb3VsZCBqdXN0IHByb3ZpZGUgYm9vdCBwYXJhbWV0
ZXJzIGZvciB1c2VycyB0byBjaG9vc2UuDQpCZWNhdXNlIHRoZSBxdWlyayB0YWJsZSBjb3VsZCBn
cm93IGJpZ2dlciBhbmQgYmlnZ2VyLCBleGNlZWRpbmcgb3VyIGNvbnRyb2wuDQoNClNvIEkgcHJv
YmFibHkgd291bGQganVzdCBpbXBsZW1lbnQgdGhlIHBhcmFtZXRlciBwYXJ0LCB3aXRob3V0IGFk
ZGluZyB0aGUgRE1JIGVudHJpZXMuDQoNClRoYW5rcyBhbmQgYmVzdCByZWdhcmRzDQotTHYNCg0K
