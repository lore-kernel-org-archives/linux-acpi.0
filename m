From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Wed, 19 Jul 2017 15:14:32 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F6130D126@ORSMSX114.amr.corp.intel.com>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <20170718060007.GB8736@nazgul.tnic> <1500407379.2042.21.camel@hpe.com>
 <20170718181545.32bd9181@vento.lan> <20170719055838.GF26030@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:18905 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753969AbdGSPOe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Jul 2017 11:14:34 -0400
In-Reply-To: <20170719055838.GF26030@nazgul.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

PiAiVGhlIG1vZHVsZSBudW1iZXIgb2YgdGhlIG1lbW9yeSBlcnJvciBsb2NhdGlvbi4gKE5PREUs
IENBUkQsIGFuZCBNT0RVTEUNCj4gc2hvdWxkIHByb3ZpZGUgdGhlIGluZm9ybWF0aW9uIG5lY2Vz
c2FyeSB0byBpZGVudGlmeSB0aGUgZmFpbGluZyBGUlUpLiINCj4NCj4gU28gdGhpcyB0dXBsZSBp
cyBzdWZmaWNpZW50IHRvIHBpbnBvaW50IHRoZSBESU1NLCBJSVVDLg0KPg0KPiBXaGljaCBtZWFu
cywgZ2hlc19lZGFjIGNhbiBoYXZlIGEgc2luZ2xlIGxheWVyIG9mIERJTU1zIHdpdGhvdXQgY2hh
bm5lbHMuDQoNClRoZSB0cmlja3kgcGFydCBpcyB0aGF0IHlvdSBoYXZlIHRvIHJlbHkgb24gU01C
SU9TL0RNSSB0byBrbm93IHdoYXQgRElNTXMgYXJlDQpvbiB0aGUgc3lzdGVtIHdoZW4gdGhlIGRy
aXZlciBpbml0aWFsaXplcyBzbyB5b3UgY2FuIHBvcHVsYXRlIC9zeXMvLiovZWRhYw0KDQpMYXRl
ciB3aGVuIEdIRVMgZ2l2ZXMgeW91IGEgTk9ERS9DQVJEL01PRFVMRSkgaW4gYW4gZXJyb3IgcmVj
b3JkLiAgWW91IG5lZWQNCnRvIG1hdGNoIHRoZXNlIHVwLiBCdXQgU01CSU9TIG9ubHkgZ2F2ZSB5
b3UgdHdvIHN0cmluZ3MgIkxvY2F0b3IiIGFuZCAiQmFuaw0KTG9jYXRvciIgd2hpY2ggaGF2ZSBu
byBkZWZpbmVkIHN5bnRheC4gWW91IGFyZSBhdCB0aGUgbWVyY3kgb2YgdGhlIEJJT1Mgd3JpdGVy
DQp0byBwdXQgaW4gc29tZXRoaW5nIHBhcnNlYWJsZS4gU29tZSB3cml0ZXJzIHVzZWQgemVybyBi
YXNlZCBjb3VudHMsIG90aGVycyBhcmUNCkZvcnRyYW4gZmFucyBhbmQgdXNlIG9uZS1iYXNlZC4g
U3RpbGwgb3RoZXIgdXNlIGxldHRlcnMuICBBYm91dCB0aGUgb25lIGd1YXJhbnRlZQ0KaXMgdGhh
dCB0aGV5IHdpbGwgbWFrZSBhbG1vc3Qgbm8gZWZmb3J0IHRvIG1hdGNoIHRoZSBzaWxrc2NyZWVu
IGxhYmVscyBvbiB0aGUgbW90aGVyYm9hcmQNCml0c2VsZi4NCg0KRS5nLiBteSBCcm9hZHdlbGwt
RVggaGFzIHRoaW5ncyBsaWtlOg0KDQogICAgICAgIExvY2F0b3I6IENIQU5ORUwgRCBESU1NIDEN
CiAgICAgICAgQmFuayBMb2NhdG9yOiBNZW1yaXNlcjgNCg0KQ2hhbm5lbCBpcyBBLEIsQyxELiBE
SU1NIGlzIDAsIDEsIDIuIE1lbXJpc2VyIGlzIHsxLi44fSBzbyB0aGlzIG1hbmFnZXMgdG8gdXNl
IGFsbA0KdGhyZWUgY291bnRpbmcgb3B0aW9ucyENCg0KLVRvbnkNCg==
