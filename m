From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 3/7] ACPI / APEI: add OSC APEI bit check for ghes_edac
Date: Mon, 7 Aug 2017 14:50:58 +0000
Message-ID: <1502116882.2042.126.camel@hpe.com>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
         <20170803215753.30553-4-toshi.kani@hpe.com>
         <20170804034417.GC12082@nazgul.tnic> <1501879218.2042.115.camel@hpe.com>
         <20170805051434.GB23214@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:36858 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdHGOvB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2017 10:51:01 -0400
In-Reply-To: <20170805051434.GB23214@nazgul.tnic>
Content-Language: en-US
Content-ID: <85FD59142186884BB4D43433EDEB93CC@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>

T24gU2F0LCAyMDE3LTA4LTA1IGF0IDA3OjE0ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgQXVnIDA0LCAyMDE3IGF0IDA4OjQ5OjUxUE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gU29tZSBmaXJtd2FyZSBmZWF0dXJlcyBjYW4gYmUgZW5hYmxlZCAv
IGRpc2FibGVkIGluIEJJT1MuwqDCoFdoaWxlDQo+ID4gSFBFIGZpcm13YXJlIGRvZXMgbm90IGFs
bG93IHRvIGRpc2FibGUgRkYsIGl0J3MgcG9zc2libGUgdGhhdCBvdGhlcg0KPiA+IHZlbmRvcnMg
bWlnaHQgYWxsb3cgc3VjaCBhbmQgc3RpbGwgaGF2ZSB0aGUgc2FtZSBPRU0gSUQgaW5mby4NCj4g
DQo+IFllYWgsIHdlIGRvbid0IHByb3RlY3Qgb3Vyc2VsdmVzIGFnYWluc3QgIm1pZ2h0IGFsbG93
Ii4gRWl0aGVyIHlvdQ0KPiBoYXZlIGFuICphY3R1YWwqIGV4YW1wbGUgZm9yIHN1Y2ggcGxhdGZv
cm0gb3IgeW91IGRvbid0IGFuZCB0aGVuIHlvdQ0KPiBkb24ndCBuZWVkIHRoaXMgY2hlY2suDQoN
Ck5vLCBJIGRvIG5vdCBhbnkgYWN0dWFsIGV4YW1wbGUuICBXaWxsIGRyb3AgdGhpcyBwYXRjaC4N
Cg0KVGhhbmtzLA0KLVRvc2hpDQo=
