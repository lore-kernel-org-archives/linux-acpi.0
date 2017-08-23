From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v3 2/5] intel_pstate: convert to use
 acpi_match_platform_list()
Date: Wed, 23 Aug 2017 15:56:05 +0000
Message-ID: <1503503170.2042.172.camel@hpe.com>
References: <20170818194644.14538-1-toshi.kani@hpe.com>
         <20170818194644.14538-3-toshi.kani@hpe.com>
         <20170823154615.bqbz2cpywlie2zh7@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:51210 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754139AbdHWP4J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Aug 2017 11:56:09 -0400
In-Reply-To: <20170823154615.bqbz2cpywlie2zh7@pd.tnic>
Content-Language: en-US
Content-ID: <1D53BB29ED027749909F1B937E7E455C@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

T24gV2VkLCAyMDE3LTA4LTIzIGF0IDE3OjQ2ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgQXVnIDE4LCAyMDE3IGF0IDAxOjQ2OjQxUE0gLTA2MDAsIFRvc2hpIEthbmkg
d3JvdGU6DQo+ID4gQ29udmVydCB0byB1c2UgYWNwaV9tYXRjaF9wbGF0Zm9ybV9saXN0KCkgZm9y
IHRoZSBwbGF0Zm9ybSBjaGVjay4NCj4gPiBUaGVyZSBpcyBubyBjaGFuZ2UgaW4gZnVuY3Rpb25h
bGl0eS4NCj4gPiANCiA6DQo+IA0KPiBCdHcsIHdoeSBpcyB0aGF0IEFDUElfU0lHX0ZBRFQncyBk
ZXNjcmlwdGlvbiBub3QgIkZBRFQiID8NCj4gDQo+ICNkZWZpbmUgQUNQSV9TSUdfRkFEVMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAiRkFDUCLCoMKgLyogRml4ZWQgQUNQSSBEZXNjcmlwdGlvbg0KPiBU
YWJsZSAqLw0KPiANCj4gTW9yZSBBQ1BJIGZ1bj8gSSBkb24ndCB0aGluayBJIGNhbiB0YWtlIGFu
eSBtb3JlIGZ1bi4NCg0KWWVzLCBtb3JlIEFDUEkgZnVuLiA6LSkgIEFjY29yZGluZyB0byB0aGUg
c3BlYzoNCg0K4oCYRkFDUOKAmS4gU2lnbmF0dXJlIGZvciB0aGUgRml4ZWQgQUNQSSBEZXNjcmlw
dGlvbiBUYWJsZS4gKFRoaXMgc2lnbmF0dXJlDQpwcmVkYXRlcyBBQ1BJIDEuMCwgZXhwbGFpbmlu
ZyB0aGUgbWlzbWF0Y2ggd2l0aCB0aGlzIHRhYmxlJ3MgbmFtZS4pDQoNCj4gT2ggd2VsbCwNCj4g
DQo+IFJldmlld2VkLWJ5OiBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+DQoNClRoYW5rcyEN
Ci1Ub3NoaQ0K
