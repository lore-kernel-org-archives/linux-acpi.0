From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH 1/3] ACPI / blacklist: add acpi_match_oemlist() interface
Date: Tue, 18 Jul 2017 20:17:53 +0000
Message-ID: <1500408519.2042.23.camel@hpe.com>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
         <20170717215912.26070-2-toshi.kani@hpe.com>
         <20170718053455.GA8736@nazgul.tnic> <1500392379.2042.13.camel@hpe.com>
         <20170718164350.GB22334@nazgul.tnic> <1500398136.2042.17.camel@hpe.com>
         <20170718174245.GA22817@nazgul.tnic> <1500403237.2042.19.camel@hpe.com>
         <20170718193208.GA23126@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:53358 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdGRUTP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jul 2017 16:19:15 -0400
In-Reply-To: <20170718193208.GA23126@nazgul.tnic>
Content-Language: en-US
Content-ID: <DEC2864285C55D4192170DC21296765E@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

T24gVHVlLCAyMDE3LTA3LTE4IGF0IDIxOjMyICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFR1ZSwgSnVsIDE4LCAyMDE3IGF0IDA2OjQ5OjUxUE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gZ2hlc19lZGFjIHVzZXMgdGhpcyBzdHJ1Y3R1cmUgYXMgYSB3aGls
ZS1saXN0LCBzbyB0aGUgdGVybSBiYWNrbGlzdA0KPiA+IGlzIG1pc2xlYWRpbmcuDQo+IA0KPiBT
byB0aGlzIG1hdGNoaW5nIGZ1bmN0aW9uIGdldHMgYm90aCBibGFja2xpc3RzIGFuZCB3aGl0ZWxp
c3RzLiBObw0KPiB3b25kZXIgaXQgaXMgY29uZnVzaW5nLiBOb3cgSSBmaW5hbGx5IHVuZGVyc3Rh
bmQgd2hhdCB5b3Ugd2FubmEgZG86DQo+IHlvdSB3YW50IHRvIGNhbGwgYWxsIHRob3NlIGxpc3Rz
IHNvbWV0aGluZyBhZ25vc3RpYyBhcyBwbGF0Zm9ybV9saXN0DQo+IG9yIHNvIGJlY2F1c2UgdGhl
eSBjb250YWluIGV4YWN0bHkgdGhhdDogcGxhdGZvcm1zIC0gbm90IE9FTXMuDQoNClJpZ2h0Lg0K
DQo+IEFuZCB0aGVuIHlvdSB3YW50IHRvIG1hdGNoICpwbGF0Zm9ybXMqLiAqTm90KiBPRU1zLg0K
DQpUcnVlLCB0aGVyZSBpcyBzb21lIHN0cmV0Y2ggdG8gdXNlIE9FTUlEcyBmb3IgZGV0ZWN0aW5n
IHBsYXRmb3Jtcy4gIEJ1dA0Kd2UgZG8gbm90IGhhdmUgb3RoZXIgc3RhbmRhcmQgaW50ZXJmYWNl
cyBiZXR0ZXIgdGhhbiB0aGlzIG9uZS4NCg0KPiAqTm93KiBJIHVuZGVyc3RhbmQgd2hhdCB5b3Un
cmUgdHJ5aW5nIHRvIHRlbGwgbWUuDQoNCjotKQ0KDQpUaGFua3MsDQotVG9zaGkNCg==
