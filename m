From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Mon, 24 Jul 2017 15:25:34 +0000
Message-ID: <1500909372.2042.58.camel@hpe.com>
References: <1500649162.2042.43.camel@hpe.com>
         <20170721151317.GA13424@nazgul.tnic> <1500650732.2042.45.camel@hpe.com>
         <20170721124401.5f94aba9@vento.lan> <1500654661.2042.49.camel@hpe.com>
         <20170721140131.40079805@vento.lan> <20170721172344.GA11316@nazgul.tnic>
         <1500661773.2042.53.camel@hpe.com> <20170722062853.GA2050@nazgul.tnic>
         <1500907209.2042.55.camel@hpe.com> <20170724150432.GA31295@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:39312 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbdGXPZh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jul 2017 11:25:37 -0400
In-Reply-To: <20170724150432.GA31295@nazgul.tnic>
Content-Language: en-US
Content-ID: <D98591A4A8BCB14B8915E897A27270E8@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mchehab@s-opensource.com" <mchehab@s-opensource.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

T24gTW9uLCAyMDE3LTA3LTI0IGF0IDE3OjA0ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgSnVsIDI0LCAyMDE3IGF0IDAyOjQ5OjMwUE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gV2UgZG8gbm90IHRlbGwgdGhlIGVycm9yIGNvdW50cyB0byBjdXN0
b21lcnMuDQo+IA0KPiBQbGVhc2UgcmVhZCB3aGF0IEkgc2FpZDogZG8geW91IHRlbGwgeW91ciBj
dXN0b21lcnMgdGhhdCB0aGUgZXJyb3INCj4gY291bnRzIHRoZXkncmUgc2VlaW5nIChvciBhcmUg
Km5vdCogc2VlaW5nKSBpcyBib2d1cyBiZWNhdXNlIHRoZSBCSU9TDQo+IGlzIGhpZGluZyB0aGVt
PyBOb3QgdGhlICphY3R1YWwqIG51bWJlcnMhDQoNCkN1c3RvbWVycyBkbyBub3Qgc2VlIGVycm9y
IGNvdW50cy7CoMKgSSBkbyBub3QgdGhpbmsgaXQncyBib2d1cy4NCg0KVGhpcyBtb2RlbCBpcyBi
YXNpY2FsbHkgdGhlIHNhbWUgYXMgeW91ciBjYXIuwqDCoFlvdSBkbyBub3Qgc2VlIGVycm9yDQpj
b3VudHMgb3IgcGVyaW9kaWNhbCBub3JtYWwgZXJyb3JzIGZyb20gYWxsIGtpbmRzIG9mIGNvbnRy
b2xsZXJzIGluIHRoZQ0KY2FyIHdoaWxlIHlvdSBhcmUgZHJpdmluZy7CoMKgWW91IGdldCBhbiBh
dHRlbnRpb24gbGFtcCBsaXQgd2hlbiB5b3UgbmVlZA0KdG8gYnJpbmcgaXQgdG8gYSBjYXIgZGVh
bGVyLg0KDQo+ID4gV2UgdGVsbCBjdXN0b21lcnMgd2hlbiB0aGV5IG5lZWQgYXR0ZW50aW9uIGFu
ZCBoYXZlIGFjdGlvbmFibGUNCj4gPiBpdGVtcywgYW5kIHdlIHByb3ZpZGUgc3VwcG9ydCBmb3Ig
dGhhdC4gU3VwcG9ydCBnZXRzIGFsbCBpbmZvDQo+ID4gbmVjZXNzYXJ5Lg0KPiANCj4gT2ssIGdv
b2QgdG8ga25vdy4gSSdsbCBtYWtlIHN1cmUgdG8gYm91bmNlIHN1Y2ggaXNzdWVzIHRvIHlvdSBn
dXlzIGluDQo+IHRoZSBmdXR1cmUuDQoNCldlJ3ZlIGJlZW4gcHJvdmlkaW5nIHRoaXMgbW9kZWwg
Zm9yIG1hbnkgeWVhcnMgbm93LiAgSSBhbSBqdXN0IHRyeWluZw0KdG8gZW5hYmxlIE9TIGVycm9y
IHJlcG9ydGluZyB3aXRoIGdoZXNfZWRhYy4NCg0KVGhhbmtzLA0KLVRvc2hpDQo=
