From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH 2/2] ACPI / video / i915: Remove ACPI backlight if
 firmware expects Windows 8
Date: Tue, 10 Sep 2013 14:21:26 +0000
Message-ID: <1378822886.17982.58.camel@x230.lan>
References: <522D88C3.7000808@intel.com> <1793135.3qk7NfcINN@vostro.rjw.lan>
	 <20130909152118.GG27291@phenom.ffwll.local>
	 <5155010.Y1gov7SKhP@vostro.rjw.lan> <87eh8wail7.fsf@intel.com>
	 <1378821416.17982.56.camel@x230.lan> <87bo40ahai.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn1lp0153.outbound.protection.outlook.com ([207.46.163.153]:11242
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785Ab3IJOVb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Sep 2013 10:21:31 -0400
In-Reply-To: <87bo40ahai.fsf@intel.com>
Content-Language: en-US
Content-ID: <62D4E6A79A5F774797259796F61596A6@namprd05.prod.outlook.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Vetter <daniel@ffwll.ch>, Aaron Lu <aaron.lu@intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Yves-Alexis Perez <corsac@debian.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Seth Forshee <seth.forshee@canonical.com>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Lee Chun-Yi <jlee@novell.com>, Len Brown <lenb@kernel.org>

T24gVHVlLCAyMDEzLTA5LTEwIGF0IDE3OjIxICswMzAwLCBKYW5pIE5pa3VsYSB3cm90ZToNCj4g
T24gVHVlLCAxMCBTZXAgMjAxMywgTWF0dGhldyBHYXJyZXR0IDxtYXR0aGV3LmdhcnJldHRAbmVi
dWxhLmNvbT4gd3JvdGU6DQo+ID4gT24gVHVlLCAyMDEzLTA5LTEwIGF0IDE2OjUzICswMzAwLCBK
YW5pIE5pa3VsYSB3cm90ZToNCj4gPg0KPiA+PiBJIHRoaW5rIHRoZSBwYXJhbWV0ZXIgIkRvZXMg
dGhlIEFDUEkgYmFja2xpZ2h0IGludGVyZmFjZSB3b3JrIG9yIG5vdCINCj4gPj4gYmVsb25ncyB0
byB0aGUgQUNQSSB2aWRlbyBkcml2ZXIuDQo+ID4NCj4gPiBUaGF0IGRlcGVuZHMgb24gaG93IFdp
bmRvd3MgOCB3b3Jrcy4gSWYgV2luZG93cyA4IHBvbGljeSBpcyBoYW5kbGVkIGJ5DQo+ID4gdGhl
IEdQVSBkcml2ZXJzIHRoZW4gaXQgYmVsb25ncyBpbiBpOTE1LiBJZiBpdCdzIGhhbmRsZWQgYnkg
dGhlIEFDUEkNCj4gPiBjb2RlIHRoZW4gaXQgYmVsb25ncyBpbiB0aGUgQUNQSSBjb2RlLg0KPiAN
Cj4gSSBmYWlsIHRvIHNlZSB0aGUgbG9naWMuIFdpbmRvd3MgOCBwb2xpY3kgZGljdGF0ZXMgd2hl
dGhlciB3ZSBjYW4gdXNlDQo+IHRoZSBBTUwgY29kZSBvciBub3QuIElNSE8sIEFDUEkgY29kZSBp
cyBpbiB0aGUgYmVzdCBwb3NpdGlvbiB0byBmaWd1cmUNCj4gdGhpcyBvdXQgYW5kIHF1aXJrIGFz
IG5lY2Vzc2FyeS4gSXQncyB0aGUgcGFydCB0aGF0IGtub3dzIGFib3V0IFdpbmRvd3MNCj4gOCwg
bm90IGk5MTUuDQoNClNvIGlmIG52aWRpYSBoYXJkd2FyZSB1c2VzIHRoZSBBQ1BJIGludGVyZmFj
ZSBhbmQgSW50ZWwgZG9lc24ndCwgd2UNCnNob3VsZCBzdGlsbCBxdWlyayBpdCBpbiB0aGUgQUNQ
SSBkcml2ZXI/DQoNCi0tIA0KTWF0dGhldyBHYXJyZXR0IDxtYXR0aGV3LmdhcnJldHRAbmVidWxh
LmNvbT4NCg==
