From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Tue, 15 Aug 2017 15:53:09 +0000
Message-ID: <1502811804.2042.151.camel@hpe.com>
References: <20170814170552.j3lhzvnwlpz75y4g@pd.tnic>
         <1502732561.2042.141.camel@hpe.com>
         <20170814180526.wtfjzgc6uye2qtx6@pd.tnic>
         <1502734083.2042.143.camel@hpe.com>
         <20170814183551.sgk2i7lxpmpyodhv@pd.tnic>
         <1502736750.2042.145.camel@hpe.com>
         <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
         <1502741290.2042.147.camel@hpe.com>
         <20170814203942.6t3mrq3hc324blab@pd.tnic>
         <1502810766.2042.149.camel@hpe.com>
         <20170815154815.wy3dqwb4yi3feahg@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:39142 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752696AbdHOPxS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Aug 2017 11:53:18 -0400
In-Reply-To: <20170815154815.wy3dqwb4yi3feahg@intel.com>
Content-Language: en-US
Content-ID: <B9E2CC133A185F4696592FE5FF9C3182@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "tony.luck@intel.com" <tony.luck@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>

T24gVHVlLCAyMDE3LTA4LTE1IGF0IDA4OjQ4IC0wNzAwLCBMdWNrLCBUb255IHdyb3RlOg0KPiBP
biBUdWUsIEF1ZyAxNSwgMjAxNyBhdCAwODozNTo1MUFNIC0wNzAwLCBLYW5pLCBUb3NoaW1pdHN1
IHdyb3RlOg0KPiA+IFVzZXIgYXBwcyBsaWtlIHJhcy1tYy1jdGwgd29ya3MgYXMgZXhwZWN0ZWQg
Zm9yIGEgZ2l2ZW4gKG5vdC1zby0NCj4gPiBncmVhdCkgRElNTSBpbmZvIGZyb20gU01CSU9TIGFz
IHdlbGwuwqDCoEkgZG8gbm90IHNlZSBhIHByb2JlbG0gZnJvbQ0KPiA+IHVzZXIgcGVyc3BlY3Rp
dmUsIGVpdGhlci4NCj4gDQo+IFdvbid0IHRoZSB1c2VyIHNlZSBhbGwgdGhlaXIgRElNTXMgcmVw
b3J0ZWQgZm9yIGVhY2ggbWVtb3J5DQo+IGNvbnRyb2xsZXIgdW5kZXIgL3N5cy9kZXZpY2VzL3N5
c3RlbS9lZGFjL21jL21jKi9kaW1tKiA/DQo+IA0KPiBUaGF0IHNvdW5kcyBjb25mdXNpbmcuDQoN
CmdoZXNfZWRhYyBvbmx5IGZpbGxzIGRpbW1faW5mbyB0byB0aGUgZmlyc3QgbWNpLiAgU28sIHVz
ZXJzIGRvIG5vdCBzZWUNCmR1cGxpY2F0ZWQgaW5mby4NCg0KVGhhbmtzLA0KLVRvc2hpDQo=
