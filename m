From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 6/7] EDAC: add edac_check_mc_owner() to check MC owner
Date: Mon, 7 Aug 2017 14:55:48 +0000
Message-ID: <1502117172.2042.129.camel@hpe.com>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
         <20170803215753.30553-7-toshi.kani@hpe.com>
         <20170804083007.GA15617@nazgul.tnic> <1501881932.2042.121.camel@hpe.com>
         <20170805054451.GE23214@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:45210 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdHGOzv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2017 10:55:51 -0400
In-Reply-To: <20170805054451.GE23214@nazgul.tnic>
Content-Language: en-US
Content-ID: <E58A0E617550804BB844C348E5275F5F@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>

T24gU2F0LCAyMDE3LTA4LTA1IGF0IDA3OjQ0ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgQXVnIDA0LCAyMDE3IGF0IDA5OjM1OjA1UE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gMSBtZWFucyB0aGUgY2FsbGVyJ3MgaW5pdCBmdW5jdGlvbiBjYW4g
Y29udGludWUgaXRzIGluaXRpYWxpemF0aW9uDQo+ID4gLS0NCj4gPiBzdWNoIGNvbmRpdGlvbnMg
YXJlIGZyZWUgb3Igb3duZWQgYnkgaXRzZWxmLg0KPiANCj4gTWFrZSB0aGF0Og0KPiANCj4gCWVk
YWNfZ2V0X293bmVyKHZvaWQpDQo+IA0KPiB0byByZXR1cm4gdGhlIG93bmVyIHN0cmluZyBvciBO
VUxMIGlmIHRoZXJlJ3Mgbm8gb3duZXIuDQo+IA0KPiBUaGUgY2FsbGVyIGNhbiB0aGVuIGRvIHRo
ZSBzdHJpbmcgY2hlY2tpbmcgYW5kIGRvIHN0cm5jbXAoKSB0byBsaW1pdA0KPiB0aGUgc3RyaW5n
IGxlbmd0aCBiZWluZyBjaGVja2VkLg0KDQpHb29kIGlkZWEhICBXaWxsIGRvLg0KDQpUaGFua3Ms
DQotVG9zaGkNCg0K
