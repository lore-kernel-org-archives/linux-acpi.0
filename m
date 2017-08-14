From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Mon, 14 Aug 2017 20:17:54 +0000
Message-ID: <1502741290.2042.147.camel@hpe.com>
References: <20170811090414.GB9432@nazgul.tnic>
         <1502725671.2042.137.camel@hpe.com>
         <20170814162436.lta5xm742hh6g7yk@pd.tnic>
         <1502728754.2042.139.camel@hpe.com>
         <20170814170552.j3lhzvnwlpz75y4g@pd.tnic>
         <1502732561.2042.141.camel@hpe.com>
         <20170814180526.wtfjzgc6uye2qtx6@pd.tnic>
         <1502734083.2042.143.camel@hpe.com>
         <20170814183551.sgk2i7lxpmpyodhv@pd.tnic>
         <1502736750.2042.145.camel@hpe.com>
         <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3427.houston.hpe.com ([15.241.140.73]:53426 "EHLO
        g4t3427.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdHNUTo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Aug 2017 16:19:44 -0400
In-Reply-To: <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
Content-Language: en-US
Content-ID: <BDC146F1A12C4649861610198201D2B9@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>

T24gTW9uLCAyMDE3LTA4LTE0IGF0IDIxOjM0ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDE0LCAyMDE3IGF0IDA3OjAyOjE1UE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gSSBkbyBub3Qga25vdyBob3cgbGlrZWx5IHdlIHNlZSBzdWNoIGNh
c2UsIGJ1dCB0aGUgY29kZSBzaG91bGQgYmUNCj4gPiB3cml0dGVuIGFjY29yZGluZyB0byB0aGUg
c3BlYy4NCj4gDQo+IFdlbGwsIHRoZW4geW91J2xsIGhhdmUgdG8gbWFrZSBnaGVzX2VkYWNfcmVw
b3J0X21lbV9lcnJvcigpDQo+IHJlZW50cmFudC4gV2hpY2ggZG9lc24ndCBsb29rIHRoYXQgaGFy
ZCBhcyB0aGUgb25seSB0aGluZyBpdCByZWFsbHkNCj4gbmVlZHMgZnJvbSBzdHJ1Y3QgZ2hlc19l
ZGFjX3B2dCBhcmUgdGhvc2Ugc3RyaW5nIGJ1ZmZlcnMuIEkgZ3Vlc3MgeW91DQo+IGNhbiB0cnkg
dG8gZG8gdGhlIHNpbXBsZXN0IHRoaW5nIGZpcnN0IGFuZCBhbGxvY2F0ZSB0aGVtIG9uIHRoZQ0K
PiBzdGFjay4NCg0KZ2hlc19lZGFjX3JlcG9ydF9tZW1fZXJyb3IoKSBpcyByZWVudHJhbnQgYXMg
aXQgaXMgbm93LiAgSSB0aGluayB0aGUNCmN1cnJlbnQgY29kZSBkZXNpZ24gb2YgYWxsb2NhdGlu
ZyBtY2kgJiBnaGVzX2VkYWNfcHZ0IGZvciBlYWNoIEdIRVMNCnNvdXJjZSBlbnRyeSBtYWtlcyBz
ZW5zZS4gIGVkYWNfcmF3X21jX2hhbmRsZV9lcnJvcigpIGFsc28gaGFzIHRoZSBzYW1lDQogIGV4
cGVjdGF0aW9uIHRoYXQgdGhlIGNhbGwgaXMgc2VyaWFsaXplZCBwZXIgbWNpLg0KDQpUaGFua3Ms
DQotVG9zaGkNCg==
