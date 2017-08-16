From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Wed, 16 Aug 2017 18:01:30 +0000
Message-ID: <1502905904.2042.159.camel@hpe.com>
References: <1502736750.2042.145.camel@hpe.com>
         <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
         <1502741290.2042.147.camel@hpe.com>
         <20170814203942.6t3mrq3hc324blab@pd.tnic>
         <1502810766.2042.149.camel@hpe.com>
         <20170815154815.wy3dqwb4yi3feahg@intel.com>
         <20170816082931.p6rpvtlxwt5nccxr@pd.tnic>
         <1502896578.2042.155.camel@hpe.com>
         <20170816164234.mgwapenb7fpym6nk@pd.tnic>
         <1502903940.2042.157.camel@hpe.com>
         <20170816174028.dqfvubjigvwtcbcy@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:38182 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbdHPSBd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Aug 2017 14:01:33 -0400
In-Reply-To: <20170816174028.dqfvubjigvwtcbcy@pd.tnic>
Content-Language: en-US
Content-ID: <CC25ED8827829F4B8B6F113BB1C1AD97@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

T24gV2VkLCAyMDE3LTA4LTE2IGF0IDE5OjQwICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFdlZCwgQXVnIDE2LCAyMDE3IGF0IDA1OjI4OjUwUE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gQXNzdW1pbmcgdGhpcyBiaWcgc3BpbmxvY2sgd29ya3MsIHllcywg
dGhpcyBhZGRyZXNzZXMgbXkgY29uY2Vybg0KPiA+IHRoYXQNCj4gDQo+IFlvdSBtZWFuLCBsZW5n
dGh5IGxvY2tlZCBzZWN0aW9uLiBXZSBjYW4gYWx3YXlzIHN3aXRjaCB0byBvbi1zdGFjaw0KPiBi
dWZmZXJzIGlmIHRoZXJlIGFyZSBpc3N1ZXMgb3IgZXZlbiB0byBzb21ldGhpbmcgbW9yZSBmYW5j
eSBsaWtlDQo+IGdlbnBvb2wuDQoNClllcywgSSBtZWFudCB0aGUgbGVuZ3RoeSBsb2NrZWQgc2Vj
dGlvbi4gIEkgc3RpbGwgdGhpbmsgdGhhdCBtdWx0aXBsZQ0KbWNpcyBpcyBhIGJldHRlciBhcHBy
b2FjaCBmb3IgY29uY3VycmVuY3kgYXMgaXQgbmF0dXJhbGx5IGFkZHJlc3NlcyBpdC4NCkJ1dCBh
cyBsb25nIGFzIGVkYWMgZnVuYyBhbmQgZXJyb3IgaGFuZGxlcnMgYXJlIHRvbGVyYW50IHdpdGgg
dGhpcw0Kc3BpbmxvY2sgYW5kIHNlcmlhbGl6YXRpb24sIEkgYW0gT0sgd2l0aCB0aGF0Lg0KDQo+
ID4gSSB3aWxsIHRlc3QgdGhlIHBhdGNoIHdpdGggYW4gU0NJIHdoZW4gSSBnb3QgYSBjaGFuY2Uu
wqDCoEkgd29uJ3QgYmUNCj4gPiBhYmxlIHRvIHRlc3Qgb3RoZXIgbm90aWZpY2F0aW9uIHR5cGVz
IG9yIHJhY2UgY29uZGl0aW9ucywgdGhvdWdoLg0KPiANCj4gVGhhbmtzLCBoZXJlJ3MgdGhlIGxh
dGVzdCB2ZXJzaW9uIHdpdGggdGhlIGF0b21pYyByZWdpc3RyYXRpb24gdG9vLg0KDQpTdXJlLCBJ
IHdpbGwgdGVzdCB3aXRoIHRoaXMgdmVyc2lvbi4NCg0KVGhhbmtzLA0KLVRvc2hpDQo=
