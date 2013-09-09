From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH 2/2] ACPI / video / i915: Remove ACPI backlight if
 firmware expects Windows 8
Date: Mon, 9 Sep 2013 15:38:46 +0000
Message-ID: <1378741125.17982.1.camel@x230.lan>
References: <522D88C3.7000808@intel.com> <522D89EC.6050103@intel.com>
	 <20130909093209.GF27291@phenom.ffwll.local>
	 <1793135.3qk7NfcINN@vostro.rjw.lan>
	 <20130909152118.GG27291@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bl2lp0205.outbound.protection.outlook.com ([207.46.163.205]:31286
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751761Ab3IIPiv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Sep 2013 11:38:51 -0400
In-Reply-To: <20130909152118.GG27291@phenom.ffwll.local>
Content-Language: en-US
Content-ID: <23D000ECEB941D4EA80ED8426F386A9F@namprd05.prod.outlook.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Aaron Lu <aaron.lu@intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Seth Forshee <seth.forshee@canonical.com>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, Yves-Alexis Perez <corsac@debian.org>, Felipe Contreras <felipe.contreras@gmail.com>, Lee Chun-Yi <jlee@novell.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

T24gTW9uLCAyMDEzLTA5LTA5IGF0IDE3OjIxICswMjAwLCBEYW5pZWwgVmV0dGVyIHdyb3RlOg0K
DQo+IElmIFdpbjggaXMgYXMgYnJva2VuIGFzIHdlIGFyZSBJJ20gb2sgd2l0aCB0aGUgbW9kdWxl
IG9wdGlvbi4gSXQganVzdA0KPiBzb3VuZGVkIHRvIG1lIGxpa2UgcmlnaHQgbm93IHdlIGRvbid0
IGtub3cgb2YgYSB3YXkgdG8gbWFrZSBhbGwgbWFjaGluZXMNCj4gc29tZXdoYXQgaGFwcHksIGNv
bWJpbmVkIHdpdGggdGhlIG90aGVyIHBpbGUgb2YgcmFuZG9tIGJhY2tsaWdodCBpc3N1ZXMNCj4g
dGhlIGFzc3VtcHRpb24gdGhhdCB3ZSBkbyBzb21ldGhpbmcgKG1heWJlIHNvbWV0aGluZyBhIGJp
dCByYWN5KSB0aGF0DQo+IHdpbmRvd3MgZG9lc24ndCBkbyBpc24ndCB0b28gZmFyLWZldGNoZWQu
IFNvIEknbSBub3Qgd2FyeSBvZiB0aGUgbWFjaGluZXMNCj4gd2hlcmUgdGhlIGFtbCBpcyBidXN0
ZWQgZm9yIGFjcGlfb3M9d2luOCwgYnV0IGZvciB0aGUgb3RoZXJzIHdoZXJlIHRoaXMNCj4gYnJv
a2Ugc3R1ZmYuDQoNCldpbmRvd3MgOCBpc24ndCBicm9rZW4gYmVjYXVzZSAoYXMgZmFyIGFzIHdl
IGNhbiB0ZWxsKSB0aGUgSW50ZWwgZHJpdmVycw0KdW5kZXIgV2luZG93cyA4IG5ldmVyIHVzZSB0
aGUgQUNQSSBiYWNrbGlnaHQgc2V0IGZ1bmN0aW9uLiBPZiBjb3Vyc2UsIGl0DQp3b3VsZCBiZSBu
aWNlIHRvIGhhdmUgdGhhdCBjb25maXJtZWQgYnkgSW50ZWwuDQoNCi0tIA0KTWF0dGhldyBHYXJy
ZXR0IDxtYXR0aGV3LmdhcnJldHRAbmVidWxhLmNvbT4NCg==
