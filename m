From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Wed, 19 Jul 2017 18:06:25 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F6130D7B8@ORSMSX114.amr.corp.intel.com>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <20170718060007.GB8736@nazgul.tnic> <1500407379.2042.21.camel@hpe.com>
 <20170718181545.32bd9181@vento.lan> <20170719055838.GF26030@nazgul.tnic>
 <3908561D78D1C84285E8C5FCA982C28F6130D126@ORSMSX114.amr.corp.intel.com>
 <20170719155718.GD16124@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3757 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753502AbdGSSGl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Jul 2017 14:06:41 -0400
In-Reply-To: <20170719155718.GD16124@nazgul.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, "Kani, Toshimitsu" <toshi.kani@hpe.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

Pj4gTGF0ZXIgd2hlbiBHSEVTIGdpdmVzIHlvdSBhIE5PREUvQ0FSRC9NT0RVTEUpIGluIGFuIGVy
cm9yIHJlY29yZC4gIFlvdSBuZWVkDQo+PiB0byBtYXRjaCB0aGVzZSB1cC4gQnV0IFNNQklPUyBv
bmx5IGdhdmUgeW91IHR3byBzdHJpbmdzICJMb2NhdG9yIiBhbmQgIkJhbmsNCj4+IExvY2F0b3Ii
IHdoaWNoIGhhdmUgbm8gZGVmaW5lZCBzeW50YXguIFlvdSBhcmUgYXQgdGhlIG1lcmN5IG9mIHRo
ZSBCSU9TIHdyaXRlcg0KPj4gdG8gcHV0IGluIHNvbWV0aGluZyBwYXJzZWFibGUuDQo+DQo+IFdl
bGwsIGF0IHNvbWUgcG9pbnQgaXQgaXMgb25seSBzbyBtdWNoIHdlIGNhbiBkbywgcmlnaHQ/DQo+
DQo+IEkgbWVhbiwgaWYgRlcgc2F5cyBpdCB3YW50cyB0byBkbyBmaXJtd2FyZS1maXJzdCBhbmQg
d2UgZ28gYW5kIGFkaGVyZQ0KPiB0byB0aGF0LCBpdCBzaG91bGQgYmUgZXhwZWN0ZWQgdGhhdCBz
YWlkIEZXIHZlbmRvciBtYXJrcyB0aGUgc2lsa3NjcmVlbg0KPiBsYWJlbHMgYW5kIERNSSBkYXRh
IGFjY29yZGluZ2x5Lg0KPg0KPiBJIG1lYW4sIGl0IGlzIHRpbWUgZm9yIEZXIHRvIHB1dCBpdHMg
bW9uZXkgd2hlcmUgaXRzIG1vdXRoIGlzLCBubz8NCj4NCj4gSG93IGVsc2Ugd291bGQgeW91IGRv
IHRoaXM/DQoNCkJ5IHRoaW5raW5nIGEgYml0IG1vcmUgYW5kIHJlYWxpemluZyB0aGF0IHdoYXQg
SSB3cm90ZSB1cCBhYm92ZSBtaXNzZXMgdGhhdA0KYXQgYnl0ZSBvZmZzZXQgNzggaW4gdGhlIFVF
RkkgbWVtb3J5IGVycm9yIHNlY3Rpb24gdGhlcmUgaXMgIk1vZHVsZSBIYW5kbGUiDQp3aGljaCB0
ZWxscyB5b3Ugd2hpY2ggU01CSU9TIGVudHJ5IHRvIHVzZS4NCg0KU28gdGhpcyBzaG91bGQgd29y
ayBqdXN0IGZpbmUgKGFzIGxvbmcgYXMgQklPUyBmaWxscyBvdXQgYWxsIHRoZXNlIGZpZWxkcyAu
Li4NCnRoZXJlJ3MgYSAiVmFsaWRhdGlvbiBCaXRzIiBtYXNrIGF0IHRoZSBzdGFydCBvZiB0aGUg
ZXJyb3Igc3RydWN0dXJlIHRoYXQgc2F5cw0Kd2hpY2ggZmllbGRzIGhhdmUgYmVlbiBwb3B1bGF0
ZWQpLg0KDQotVG9ueQ0K
