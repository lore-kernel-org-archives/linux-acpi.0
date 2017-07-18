From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Tue, 18 Jul 2017 16:42:31 +0000
Message-ID: <1500395596.2042.15.camel@hpe.com>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
         <20170717215912.26070-4-toshi.kani@hpe.com>
         <c6b2f416-964f-2283-56b6-899485f39652@codeaurora.org>
         <1500391630.2042.11.camel@hpe.com>
         <591a9373-11d0-db6b-b345-87ad3c706ffb@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3427.houston.hpe.com ([15.241.140.73]:41380 "EHLO
        g4t3427.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdGRQn4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jul 2017 12:43:56 -0400
In-Reply-To: <591a9373-11d0-db6b-b345-87ad3c706ffb@codeaurora.org>
Content-Language: en-US
Content-ID: <647335B7F43D444CBA7B219BA49F4639@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "jhugo@codeaurora.org" <jhugo@codeaurora.org>, "bp@alien8.de" <bp@alien8.de>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "mchehab@kernel.org" <mchehab@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

T24gVHVlLCAyMDE3LTA3LTE4IGF0IDEwOjI0IC0wNjAwLCBKZWZmcmV5IEh1Z28gd3JvdGU6DQo+
IE9uIDcvMTgvMjAxNyA5OjM2IEFNLCBLYW5pLCBUb3NoaW1pdHN1IHdyb3RlOg0KPiA+IE9uIFR1
ZSwgMjAxNy0wNy0xOCBhdCAwODozOSAtMDYwMCwgSmVmZnJleSBIdWdvIHdyb3RlOg0KPiA+ID4g
T24gNy8xNy8yMDE3IDM6NTkgUE0sIFRvc2hpIEthbmkgd3JvdGU6DQo+ID4gPiA+IFRoZSBnaGVz
X2VkYWMgZHJpdmVyIHdhcyBpbnRyb2R1Y2VkIGluIDIwMTMgWzFdLCBidXQgaXQgaGFzIG5vdA0K
PiA+ID4gPiBiZWVuIGVuYWJsZWQgYnkgYW55IGRpc3RybyB5ZXQuDQo+ID4gPiANCj4gPiA+IFVi
dW50dSBpcyBleHBlY3RlZCB0byBlbmFibGUgdGhpcyBzb29uLg0KPiA+IA0KPiA+IEludGVyZXN0
aW5nLsKgwqBJIHdhcyB0b2xkIGZyb20gb3RoZXIgZGlzdHJvIHRoYXQgdGhlcmUgd2VyZSBtYW55
DQo+ID4gYnVnZ3kgZmlybXdhcmVzIG91dCB0aGVyZSB0aGF0IHByZXZlbnRlZCB0byBlbmFibGUg
Z2hlc19lZGFjLsKgwqBEbw0KPiA+IHlvdSBrbm93IGlmIFVidW50dSBoYXMgYW55IHBsYW4gdG8g
YWRkcmVzcyBzdWNoIGlzc3VlP8KgwqBPciBkbyB0aGV5DQo+ID4gbm90IHNlZSBzdWNoIGlzc3Vl
P8KgwqBJIGRvIG5vdCB0ZXN0IHdpdGggb3RoZXIgdmVuZG9ycycgcGxhdGZvcm1zLA0KPiA+IHNv
IEkgY2Fubm90IHRlbGwgZXhhY3RseSB3aGF0IHRob3NlIGJ1Z3MgYXJlLi4uDQo+ID4gDQo+IA0K
PiBJIGRvIG5vdCBrbm93IGlmIFVidW50dSBpbnRlbmRzIHRvIGFkZHJlc3MgYW55ICJrbm93biBp
c3N1ZXMiLsKgwqBJDQo+IGtub3cgYcKgcmVxdWVzdCB3YXMgbWFkZSB0byBDYW5vbmljYWwgdG8g
ZW5hYmxlIHRoZSBvcHRpb24sIGFuZCBpdA0KPiBhcHBlYXJzIHRoZSByZXF1ZXN0IGlzIGJlaW5n
IGNvbnNpZGVyZWQsIGFsdGhvdWdoIHRoZSBvcHRpb24gbWF5IGJlDQo+IGxpbWl0ZWQgdG/CoEFS
TTY0LCBkZXBlbmRpbmcgb24gaG93IENhbm9uaWNhbCdzIGV2YWx1YXRpb24gZ29lcy7CoMKgSSBh
bQ0KPiBub3QgYXdhcmUgb2YgYW55IHBhcnRpY3VsYXIgaXNzdWVzLCBzbyBJIGNhbm5vdCBzYXkg
d2hhdCB0aGUgc2lkZQ0KPiBlZmZlY3RzIGFyZSwgb3Igd2hhdCBwbGF0Zm9ybXMgYXJlIGNvbnNp
ZGVyZWQgdG8gZXhoaWJpdCBzdWNoIGlzc3Vlcy4NCg0KSSBzZWUuIFRoYW5rcyBmb3IgdGhlIGlu
Zm8hIEkgaG9wZSBzb21lb25lIGZyb20gQ2Fub25pY2FsIGlzIG9uIHRoZQ0KbGlzdC4NCi1Ub3No
aQ0K
