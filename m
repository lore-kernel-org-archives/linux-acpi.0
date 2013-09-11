From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH 2/2] ACPI / video / i915: Remove ACPI backlight if
 firmware expects Windows 8
Date: Wed, 11 Sep 2013 08:45:41 +0000
Message-ID: <1378889140.945.0.camel@x230.lan>
References: <522D88C3.7000808@intel.com> <5155010.Y1gov7SKhP@vostro.rjw.lan>
	 <87eh8wail7.fsf@intel.com> <1889567.vxI8heiC3B@vostro.rjw.lan>
	 <20130911013206.GA556@mint-spring.sh.intel.com> <87hadrycf4.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn1lp0156.outbound.protection.outlook.com ([207.46.163.156]:33307
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752494Ab3IKIpr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Sep 2013 04:45:47 -0400
In-Reply-To: <87hadrycf4.fsf@intel.com>
Content-Language: en-US
Content-ID: <6AA43F885902D84CAE761135FBF3867B@namprd05.prod.outlook.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Vetter <daniel@ffwll.ch>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Yves-Alexis Perez <corsac@debian.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Seth Forshee <seth.forshee@canonical.com>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Lee Chun-Yi <jlee@novell.com>, Len Brown <lenb@kernel.org>

T24gV2VkLCAyMDEzLTA5LTExIGF0IDExOjQ1ICswMzAwLCBKYW5pIE5pa3VsYSB3cm90ZToNCg0K
PiBCZWZvcmUgcGx1bmdpbmcgZm9yd2FyZCwgaGF2ZSB5b3Ugb2JzZXJ2ZWQgYW55IGRpZmZlcmVu
Y2UgYmV0d2VlbiB0aGUNCj4gYm9vdCBtb2Rlcz8gV2UgaGF2ZSByZXBvcnRzIFsxXSB0aGF0IHRo
ZSBiYWNrbGlnaHQgYmVoYXZpb3VyIGlzDQo+IGRpZmZlcmVudCB3aXRoIFVFRkkgdnMuIFVFRkkr
Q1NNIG9yIGxlZ2FjeSBib290LiBTbyBJJ20gd29uZGVyaW5nIGlmIHRoZQ0KPiBhY3BpX2dibF9v
c2lfZGF0YSA+PSBBQ1BJX09TSV9XSU5fOCBjaGVjayBpbiBwYXRjaCAyLzIgaXMgdGhlIHdob2xl
DQo+IHN0b3J5Lg0KPiANCj4gRnVydGhlciwgaWYgd2UgdGVsbCB0aGUgQklPUyB3ZSdyZSBXaW5k
b3dzIDggdG8gdXNlIHRoZSB0ZXN0ZWQgQklPUyBjb2RlDQo+IHBhdGhzLCB3aGF0IGd1YXJhbnRl
ZXMgZG8gd2UgaGF2ZSBvZiBVRUZJK0NTTSBvciBsZWdhY3kgYm9vdHMgd29ya2luZz8NCg0KV2Ug
aGF2ZSBubyBldmlkZW5jZSBvZiBXaW5kb3dzIGJlaGF2aW5nIGRpZmZlcmVudGx5IGJhc2VkIG9u
IHRoZSBleHBvc2VkDQpmaXJtd2FyZSB0eXBlLg0KDQotLSANCk1hdHRoZXcgR2FycmV0dCA8bWF0
dGhldy5nYXJyZXR0QG5lYnVsYS5jb20+DQo=
