From: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH 1/2] x86/MCE: Export memory_error()
Date: Wed, 10 May 2017 22:03:42 +0000
Message-ID: <1494453738.20330.8.camel@intel.com>
References: <CAPcyv4jAkCE2QBuxfxxmZfQZLCVOGLrLXqDu5TyGCVA+xJMEVg@mail.gmail.com>
         <20170421202741.GA16423@intel.com>
         <20170421210704.c5pvpn6zivvruzx3@pd.tnic>
         <20170424113620.6iq2466yhkhb33rp@pd.tnic>
         <20170425210740.GA15722@omniknight.lm.intel.com>
         <1494444606.20330.2.camel@intel.com>
         <20170510200406.mphusoidfuyq24ee@pd.tnic>
         <1494446729.20330.4.camel@intel.com>
         <20170510200851.mhz3434jauxdq2u5@pd.tnic>
         <1494450649.20330.6.camel@intel.com>
         <20170510215707.v7zywrslma4o7jao@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30658 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbdEJWDp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 May 2017 18:03:45 -0400
In-Reply-To: <20170510215707.v7zywrslma4o7jao@pd.tnic>
Content-Language: en-US
Content-ID: <254F45614209294FA4BB4CEE5A41DC2E@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

T24gV2VkLCAyMDE3LTA1LTEwIGF0IDIzOjU3ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFdlZCwgTWF5IDEwLCAyMDE3IGF0IDA5OjEyOjEyUE0gKzAwMDAsIFZlcm1hLCBWaXNo
YWwgTCB3cm90ZToNCj4gPiBUaGUgbWVtb3J5IGVycm9yIGNoZWNrIGluIHRoZSBuZml0IGhhbmRs
ZXIgaXMgYSB2YWxpZCwgYW5kIHNpbXBsZQ0KPiA+IGZpeC4NCj4gDQo+IEkgbmVlZCB0aGUgYmln
IHBpY3R1cmUgaGVyZTogIldpdGhvdXQgdGhpcyBmaXgsIHRoZSBuZml0IGhhbmRsZXIgLi4uIi4N
Cg0KLi53aWxsIHBvdGVudGlhbGx5IGFkZCBib2d1cyBhZGRyZXNzIHRvIGFuICdlcnJvciBsaXN0
JywgZXZlbiB3aGVuIHRoZXJlDQptYXkgbm90IGhhdmUgYmVlbiBhIG1lbW9yeSBlcnJvci4gKGNh
biBtY2UtPmFkZHIgaGF2ZSBhbiBhZGRyZXNzIHdoZW4NCnRoZSBtY2UgaXMgbm90IGR1ZSB0byBh
IG1lbW9yeSBlcnJvcj8pDQpUaGUgcmVzdWx0IG9mIGFkZGluZyBhbiBhZGRyZXNzIHRvIHRoaXMg
bGlzdCBpcyB0aGF0IGZ1dHVyZSBhY2Nlc3NlcyB0bw0KdGhpcyBsb2NhdGlvbiB3aWxsIHByZW1h
dHVyZWx5IGVycm9yIG91dC4gRGVwZW5kaW5nIG9uIGhvdyBmcmVxdWVudGx5DQptYWNoaW5lIGNo
ZWNrcyBoYXBwZW4gdGhhdCBhcmUgbm90IG1lbW9yeSBlcnJvcnMgYnV0IGhhdmUgdGhlIGFkZHIg
ZmllbGQNCnNldCAoaG9wZWZ1bGx5IHJhcmUgYW55d2F5KSwgd2UgY291bGQgYmUgaW5jb3JyZWN0
bHkgbWFya2luZyBhIGxvdCBvZg0KbG9jYXRpb25zIGFzIG1lZGlhIGVycm9ycy4NCg0KPiANCj4g
VGhlbiwgaWYgdGhlIHN0YWJsZSBydWxlcyBhcHBseSwgd2UgY2FuIGFsd2F5cyBleHBlZGl0ZSBp
dCB0aHJvdWdoDQo+IHVyZ2VudC9zdGFibGUuDQo+IA==
