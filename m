From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH 3/3] i915: Don't provide ACPI backlight interface if
 firmware expects Windows 8
Date: Fri, 14 Jun 2013 17:29:48 +0000
Message-ID: <1371230988.2490.2.camel@x230>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
	 <1370818899-8595-4-git-send-email-matthew.garrett@nebula.com>
	 <51BABC6F.3050201@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn1lp0152.outbound.protection.outlook.com ([207.46.163.152]:47647
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752615Ab3FNR3w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Jun 2013 13:29:52 -0400
In-Reply-To: <51BABC6F.3050201@intel.com>
Content-Language: en-US
Content-ID: <89367251F921144BA1652F68756238DC@namprd05.prod.outlook.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Seth Forshee <seth.forshee@canonical.com>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Aaron Lu <aaron.lwe@gmail.com>, Alex Deucher <alexdeucher@gmail.com>

T24gRnJpLCAyMDEzLTA2LTE0IGF0IDE0OjQ3ICswODAwLCBBYXJvbiBMdSB3cm90ZToNCg0KPiBX
aGF0IGFib3V0IGEgcHJpb3JpdHkgYmFzZWQgc29sdXRpb24/IFdlIGNhbiBpbnRyb2R1Y2UgYSBu
ZXcgZmllbGQgbmFtZWQNCj4gcHJpb3JpdHkgdG8gYmFja2xpZ2h0X2RldmljZSBhbmQgaW5zdGVh
ZCBvZiBjYWxsaW5nIGFub3RoZXIgbW9kdWxlJ3MNCj4gZnVuY3Rpb24gbGlrZSB0aGUgdW5yZWdp
c3RlciBvbmUgaGVyZSh3aGljaCBjYXVzZSB1bm5lY2Vzc2FyeSBtb2R1bGUNCj4gZGVwZW5kZW5j
eSksIHdlIG9ubHkgbmVlZCB0byBib29zdCBwcmlvcml0eSBmb3IgaXRzIG93biBpbnRlcmZhY2Uu
IFRoaXMNCj4gZmllbGQgd2lsbCBiZSBleHBvcnRlZCB0byBzeXNmcywgc28gdXNlciBjYW4gY2hh
bmdlIGl0IGR1cmluZyBydW50aW1lDQo+IHRvby4gQW5kIHdlIGNhbiBhbHNvIGludHJvZHVjZSBh
IG5ldyBrZXJuZWwgY29tbWFuZCBsaW5lIGFzDQo+IGJhY2tsaWdodC5mb3JjZV9pbnRlcmZhY2U9
cmF3L2Zpcm13YXJlL3BsYXRmb3JtLCB0byBvdmVyY29tZSB0aGUgbGltaXRlZA0KPiBmdW5jdGlv
bmFsaXR5IHByb3ZpZGVkIGJ5IGFjcGlfYmFja2xpZ2h0PXZpZGVvL3ZlbmRvciwgd2hpY2ggZG9l
cyBub3QNCj4gaW52b2x2ZSBHUFUncyBpbnRlcmZhY2UuDQoNCkhvdyB3b3VsZCB0aGF0IHdvcmsg
d2l0aCBleGlzdGluZyB1c2Vyc3BhY2U/DQoNCj4gQW5kIHdlIGNhbiBwbGFjZSB0aGUgcXVpcmsg
Y29kZSBpbiBiYWNrbGlnaHQgbGF5ZXIgaW5zdGVhZCBvZiBpbmRpdmlkdWFsDQo+IGJhY2tsaWdo
dCBmdW5jdGlvbmFsaXR5IHByb3ZpZGVyIG1vZHVsZS4gU3VwcG9zZSB3ZSBoYXZlIGEgYmFja2xp
Z2h0DQo+IG1hbmFnZXIgdGhlcmUsIGZvciBhbGwgd2luOCBzeXN0ZW1zLCB3ZSBjYW4gYm9vc3Qg
dGhlIHJhdyB0eXBlJ3MNCj4gcHJpb3JpdHkgb24gaXRzIHJlZ2lzdHJhdGlvbiwgc28gbm8gbmVl
ZCB0byBhZGQgY29kZSBpbg0KPiBpbnRlbC9hbWQvZXRjLi8ncyBHUFUgZHJpdmVyIGNvZGUuDQoN
CkJ1dCB3ZSdkIG5lZWQgdG8gYWRkIGNvZGUgdG8gZXZlcnkgcGllY2Ugb2YgdXNlcnNwYWNlIHRo
YXQgY3VycmVudGx5DQp1c2VzIHRoZSBiYWNrbGlnaHQsIHJpZ2h0Pw0KDQo+IFdpdGggcHJpb3Jp
dHkgYmFzZWQgc29sdXRpb24sIGFsbCBiYWNrbGlnaHQgY29udHJvbCBpbnRlcmZhY2VzIHN0YXks
DQo+IHRoZSBwcmlvcml0eSBmaWVsZCBpcyBhbiBpbmRpY2F0aW9uIGdpdmVuIGJ5IGtlcm5lbCB0
byB1c2VyIHNwYWNlLg0KDQpXZSBzaG91bGRuJ3QgZXhwb3J0IGludGVyZmFjZXMgaWYgd2UgZG9u
J3QgZXhwZWN0IHRoZW0gdG8gd29yay4NCg0KLS0gDQpNYXR0aGV3IEdhcnJldHQgfCBtamc1OUBz
cmNmLnVjYW0ub3JnDQo=
