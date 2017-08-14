From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Mon, 14 Aug 2017 17:52:25 +0000
Message-ID: <1502732561.2042.141.camel@hpe.com>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
         <20170803215753.30553-5-toshi.kani@hpe.com>
         <20170804040525.GE12082@nazgul.tnic> <1501879964.2042.117.camel@hpe.com>
         <20170805051615.GC23214@nazgul.tnic> <1502128177.2042.131.camel@hpe.com>
         <20170811090414.GB9432@nazgul.tnic> <1502725671.2042.137.camel@hpe.com>
         <20170814162436.lta5xm742hh6g7yk@pd.tnic>
         <1502728754.2042.139.camel@hpe.com>
         <20170814170552.j3lhzvnwlpz75y4g@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:37144 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdHNRw2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Aug 2017 13:52:28 -0400
In-Reply-To: <20170814170552.j3lhzvnwlpz75y4g@pd.tnic>
Content-Language: en-US
Content-ID: <DEE80C43CBD58847B50BDBD2FA232B80@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>

T24gTW9uLCAyMDE3LTA4LTE0IGF0IDE5OjA1ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDE0LCAyMDE3IGF0IDA0OjQ4OjU3UE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gUmlnaHQsIGJ1dCB0aGUgaXNzdWUgaXMgaG93IFtnaGVzX2VkYWNf
XXJlcG9ydF9tZW1fZXJyb3IoKSBwcm90ZWN0cw0KPiA+IGZyb20gcG9zc2libGUgY29uY3VycmVu
dCBjYWxscyBmcm9tIG11bHRpcGxlIEdIRVMgc291cmNlcyB3aGVuDQo+ID4gdGhlcmUgaXMgb25s
eSBhIHNpbmdsZSBtY2kuDQo+IA0KPiBEbyB5b3Uga25vdyBvZiBhbiBhY3R1YWwgZmlybXdhcmUg
cmVwb3J0aW5nIG11bHRpcGxlIGVycm9ycw0KPiBjb25jdXJyZW50bHk/DQoNCkkgZG8gbm90IGtu
b3cuICBXZSBoYXZlIG11bHRpcGxlIEdIRVMgZW50cmllcywgYnV0IHRoZXkgYWxsIHVzZSBTQ0ku
IA0KU2luY2UgQUNQSUNBIHVzZXMgYSBzaW5nbGUgdGhyZWFkZWQgd29ya3F1ZXVlIGZvciBub3Rp
ZnkgaGFuZGxlcnMsIHRoZXkNCmFyZSBzZXJpYWxpemVkIGFtb25nIFNDSXMuDQoNCkFDUEkgNi4y
IGRlZmluZXMgbXVsdGlwbGUgbm90aWZpY2F0aW9uIHR5cGVzIGluIFRhYmxlIDE4LTM4MywgYW5k
DQpnaGVzX3Byb2MoKSBjYW4gYmUgY2FsbGVkIGZyb20gZ2hlc19wb2xsX2Z1bmMoKSwgZ2hlc19p
cnFfZnVuYygpLCBhbmQNCmdoZXNfbm90aWZ5X3NjaSgpLiAgU28sIEkgdGhpbmsgaXQgaXMgc2Fm
ZSB0byBvcGVyYXRlIHBlciBhbiBlbnRyeQ0KYmFzaXMuDQoNCj4gR0hFUyB2MiBldmVuIG5lZWRz
IHRvIEFDSyB0aGUgY3VycmVudCBlcnJvciBmaXJzdCBiZWZvcmUgaXQgY2FuIHJlYWQNCj4gdGhl
IG5leHQgb25lLg0KDQpZZXMsIGJ1dCB0aGlzIEFDSyBpcyBkb25lIHBlciBhIEdIRVMgZW50cnkg
YXMgd2VsbC4NCg0KVGhhbmtzLA0KLVRvc2hpDQoNCg==
