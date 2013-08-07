From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: Backlight control only in the kernel?
Date: Wed, 7 Aug 2013 10:36:08 +0000
Message-ID: <1375871766.10292.7.camel@x230.lan>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
	 <20130807074405.GA18272@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn1lp0158.outbound.protection.outlook.com ([207.46.163.158]:43593
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932354Ab3HGKgL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Aug 2013 06:36:11 -0400
In-Reply-To: <20130807074405.GA18272@pd.tnic>
Content-Language: en-US
Content-ID: <A0611798DC053D4793AA03A221FE323F@namprd05.prod.outlook.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "seth.forshee@canonical.com" <seth.forshee@canonical.com>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, Aaron Lu <aaron.lu@intel.com>

T24gV2VkLCAyMDEzLTA4LTA3IGF0IDA5OjQ0ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQoNCj4gQmFja2dyb3VuZCBpcyB0aGF0IG9uIG15IHgyMzAsIEkgbmVlZGVkIHRvIGNvbm5lY3Qg
dGhlDQo+IEZuLUZ4IGJhY2tsaWdodCBob3RrZXkgcHJlc3NlcyB0byBhIHNjcmlwdCB0byB3cml0
ZSB0bw0KPiAvc3lzL2NsYXNzL2JhY2tsaWdodC9pbnRlbF9iYWNrbGlnaHQvYnJpZ2h0bmVzcyBi
ZWNhdXNlIEZsdXhib3ggZG9lc24ndA0KPiBkbyB0aGF0IChhbmQgbWF5YmUgZG9lc24ndCBoYXZl
IHRvKS4NCj4gDQo+IFNvLCB3aXRob3V0IHByZXN1bWluZyBhbnkgQUNQSSBvciBiYWNrbGlnaHQg
a25vd2xlZGdlLCBjYW4gd2UgbWFrZSB0aGUNCj4gYmFja2xpZ2h0IGNvbnRyb2wgd29yayBvbmx5
IGluIHRoZSBrZXJuZWwgYnkgY29ubmVjdGluZyB0aGUgaG90a2V5DQo+IHByZXNzZXMgdG8gc29t
ZSBiYWNrbGlnaHQgY29udHJvbGxpbmcgaW50ZXJmYWNlIHdoaWNoIGJhY2tsaWdodC1jYXBhYmxl
DQo+IGRldmljZXMgaW1wbGVtZW50IHNvIHRoYXQgaXQgd29ya3MgcmVnYXJkbGVzcyBvZiB1c2Vy
c3BhY2UgZW52aXJvbm1lbnQ/DQo+IEV2ZW4gaWYgdGhlIG1hY2hpbmUgaXMgbm90IHJ1bm5pbmcg
WD8NCg0KTm90IHJlYWxseS4gVGhlIEFDUEkgZHJpdmVyIGlzIGFibGUgdG8gZG8gdGhpcyBiZWNh
dXNlIHRoZSBldmVudHMgYW5kDQp0aGUgYmFja2xpZ2h0IGFyZSBhc3NvY2lhdGVkIHdpdGggdGhl
IHNhbWUgZGV2aWNlLiBXZSBjb3VsZCBwb3RlbnRpYWxseQ0KbWFrZSBzb21ldGhpbmcgd29yayB3
aXRoIEdQVSBiYWNrbGlnaHQgZHJpdmVycyBzaW5jZSB0aGVpciBQQ0kgZGV2aWNlDQpzaG91bGQg
YWxzbyBiZSBhc3NvY2lhdGVkIHdpdGggdGhlIGJhY2tsaWdodCBkZXZpY2UsIGJ1dCB0aGluZ3Mg
Z2V0DQpjb21wbGljYXRlZCBxdWlja2x5IC0gb25jZSBkZGNjaSBzdXBwb3J0IGlzIGhvb2tlZCB1
cCB5b3UnbGwgYWxzbyBoYXZlDQprZXJuZWwgYmFja2xpZ2h0IGRldmljZXMgZm9yIHNvbWUgZXh0
ZXJuYWwgbW9uaXRvcnMsIGFuZCBub3cgeW91IG5lZWQgdG8NCm1ha2UgYSBwb2xpY3kgZGVjaXNp
b24gYWJvdXQgd2hpY2ggZGlzcGxheSBzaG91bGQgYmUgY29udHJvbGxlZCBpbg0KcmVzcG9uc2Ug
dG8gdGhlIGtleXByZXNzLiBPbmUgcmVhc29uYWJsZSBjaG9pY2Ugd291bGQgYmUgd2hpY2hldmVy
DQpkaXNwbGF5IGNvbnRhaW5zIHRoZSBjdXJyZW50bHkgZm9jdXNlZCB3aW5kb3csIHdoaWNoIGlz
IG9idmlvdXNseSBvdXQgb2YNCnNjb3BlIGZvciB0aGUga2VybmVsLg0KDQpTbyBpZiB3ZSdyZSBn
b2luZyB0byBkbyB0aGlzIHRoZW4gd2UgbmVlZCBhIGdlbmVyYWxpc2VkIG1lY2hhbmlzbQ0KaW4t
a2VybmVsIGZvciBjb25uZWN0aW5nIGlucHV0IGRldmljZXMgdG8gYmFja2xpZ2h0IGRldmljZXMs
IGFuZCB3ZSBuZWVkDQphIG1lY2hhbmlzbSBmb3IgZGlzYWJsaW5nIGl0IHdoZW4gdXNlcnNwYWNl
IGtub3dzIGJldHRlci4gVGhpcyBzb3VuZHMNCmxpa2UgYSBsb3Qgb2Ygd29yayBmb3Igc29tZXRo
aW5nIHRoYXQgc2hvdWxkIHJlYWxseSBqdXN0IGJlIGhhbmRsZWQgYnkNCnVzZXJzcGFjZSBhbHJl
YWR5Lg0KDQotLSANCk1hdHRoZXcgR2FycmV0dCB8IG1qZzU5QHNyY2YudWNhbS5vcmcNCg==
