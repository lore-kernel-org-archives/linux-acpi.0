From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Thu, 20 Jul 2017 14:42:25 +0000
Message-ID: <1500561189.2042.35.camel@hpe.com>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
         <20170717215912.26070-4-toshi.kani@hpe.com>
         <20170718060007.GB8736@nazgul.tnic> <20170718080836.GB8372@nazgul.tnic>
         <1500412288.2042.25.camel@hpe.com> <20170719055235.GD26030@nazgul.tnic>
         <1500480051.2042.27.camel@hpe.com> <20170719162204.GE16124@nazgul.tnic>
         <1500482822.2042.31.camel@hpe.com> <20170720041645.GA14367@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:53842 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932138AbdGTOm4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jul 2017 10:42:56 -0400
In-Reply-To: <20170720041645.GA14367@nazgul.tnic>
Content-Language: en-US
Content-ID: <6A26A1E2E0106F4FADEAA3FF152FD921@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

T24gVGh1LCAyMDE3LTA3LTIwIGF0IDA2OjE2ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFdlZCwgSnVsIDE5LCAyMDE3IGF0IDA0OjU2OjE3UE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gU2luY2UgZ2hlc19lZGFjIGhhcyBub3QgYmVlbiB1c2VkIGZvciBh
IGxvbmcgdGltZSwgSSBoYXZlIGEgZmVlbGluZw0KPiA+IHRoYXQgbm90IHNvIG1hbnkgdmVuZG9y
cyB3YW50IHRvIHVzZSBpdC7CoMKgSW4gdGhlIGNhc2Ugb2YgSFBFLCB3ZSBkbw0KPiA+IG5vdCBu
ZWVkIHRvIHVwZGF0ZSB3aXRoIGVhY2ggcGxhdGZvcm0gc2luY2UgIkhQRSIgIlNlcnZlciIgd2ls
bA0KPiA+IGNvdmVyIGFsbCBwbGF0Zm9ybXMgd2UgbmVlZC4NCj4gDQo+IERvZXMgdGhlIGFwZWlf
b3NjX3NldHVwKCkgZGV0ZWN0aW9uIHdpdGggdGhlIHV1aWQgd29yayBvbiBIUCBzeXN0ZW1zPw0K
DQpZZXMsIHRoZSBmb2xsb3dpbmcgbWVzc2FnZSBpcyBzaG93biBvbiBIUCBzeXN0ZW1zLiAgUGxl
YXNlIG5vdGUgdGhhdA0KV0hFQSBpcyBhIFdpbmRvd3MtZGVmaW5lZCBpbnRlcmZhY2UuDQoNCiJH
SEVTOiBBUEVJIGZpcm13YXJlIGZpcnN0IG1vZGUgaXMgZW5hYmxlZCBieSBBUEVJIGJpdCBhbmQg
V0hFQSBfT1NDLiINCg0KVGhhbmtzLA0KLVRvc2hpDQo=
