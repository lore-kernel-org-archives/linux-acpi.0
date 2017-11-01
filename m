From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use
 fixmap
Date: Wed, 1 Nov 2017 18:20:46 +0000
Message-ID: <1509559730.30483.19.camel@hpe.com>
References: <20171031153832.17746-1-james.morse@arm.com>
         <59F9E119.6040700@arm.com> <20171101153043.xgzepqbxsblmppp5@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:22303 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754586AbdKASUv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Nov 2017 14:20:51 -0400
In-Reply-To: <20171101153043.xgzepqbxsblmppp5@pd.tnic>
Content-Language: en-US
Content-ID: <3703B2A66E3A354FAF9CE8681661F842@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "james.morse@arm.com" <james.morse@arm.com>, "bp@suse.de" <bp@suse.de>
Cc: "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "mingo@redhat.com" <mingo@redhat.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "tbaicar@codeaurora.org" <tbaicar@codeaurora.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "xiexiuqi@huawei.com" <xiexiuqi@huaw>

T24gV2VkLCAyMDE3LTExLTAxIGF0IDE2OjMwICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFdlZCwgTm92IDAxLCAyMDE3IGF0IDAyOjU4OjMzUE0gKzAwMDAsIEphbWVzIE1vcnNl
IHdyb3RlOg0KPiA+IERvZXMgYW55b25lIGhhdmUgYW4geDg2IG1hY2hpbmUgdGhhdCBkb2VzIGZp
cm13YXJlLWZpcnN0IHVzaW5nIE5PVElGWV9OTUk/DQo+IA0KPiBBRkFJSywgdGhlIG9ubHkgb25l
IHdobyBoYXMgYWNjZXNzIHRvIGEgcmVwb3J0ZWRseSBzb21ld2hhdCB3b3JraW5nIEdIRVMNCj4g
aW1wbGVtZW50YXRpb24gaXMgVG9zaGkuIENDZWQuDQoNClRoYW5rcyBmb3IgdGhlIGhlYWRzLXVw
LiAgTXkgeDg2IHN5c3RlbSBvbmx5IHN1cHBvcnRzIEdIRVMgd2l0aCBTQ0kNCmVycm9yIHNvdXJj
ZXMuICBJdCB1c2VzIE1DRSBmb3Igc3luY2hyb25vdXMgZXJyb3IgZXZlbnRzLg0KDQpTbywgZm9y
IHg4NiBTQ0kgZXJyb3Igc291cmNlczoNCg0KVGVzdGVkLWJ5OiBUb3NoaSBLYW5pIDx0b3NoaS5r
YW5pQGhwZS5jb20+DQoNCm5pdDogSSB0aGluayBnaGVzX2lvcmVtYXBfcGZuX1tubWl8aXJxXSBz
aG91bGQgYmUgcmVuYW1lZCBzaW5jZSB0aGV5IG5vDQpsb25nZXIgdXNlIGlvcmVtYXAuIA0KDQot
VG9zaGkNCg==
