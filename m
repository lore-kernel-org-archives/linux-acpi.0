From: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v1 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation
 region driver
Date: Fri, 9 Jun 2017 23:47:25 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A59725BED29@FMSMSX114.amr.corp.intel.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-4-git-send-email-rajmohan.mani@intel.com>
 <CAHp75VcvV_AbLJCq9Rm_8yab3nViPm6ikxxme4oyw9vm4Kz7Gg@mail.gmail.com>
 <20170607121503.GA1019@valkosipuli.retiisi.org.uk>
 <CAHp75Vef=c54O8Xd+aM+eWWVt7nLsczT48WbgrdiOVyWv6xMcg@mail.gmail.com>
 <20170607201050.GE1019@valkosipuli.retiisi.org.uk>
 <00ae0f71-a83e-ff54-eaad-77e835e1dba7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:24831 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751578AbdFIXr2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Jun 2017 19:47:28 -0400
In-Reply-To: <00ae0f71-a83e-ff54-eaad-77e835e1dba7@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Sakari Ailus <sakari.ailus@iki.fi>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

SGkgSGFucywNCg0KPiA+DQo+ID4gQXMgUE1JQ3MgYXJlIHR5cGljYWxseSBsaW5rZWQgdG8gdGhl
IGtlcm5lbCAodnMuIGJlaW5nIG1vZHVsZXMpLA0KPiA+IHRoZXJlJ3Mgbm8gaXNzdWUgd2l0aCB0
aGUgbW9kdWxlIG5hbWUuIEkgd291bGQgc3VwcG9zZSBmZXcgaWYgYW55DQo+ID4gUE1JQ3Mgd2ls
bCBiZSBjb21waWxlZCBhcyBtb2R1bGVzIGluIGdlbmVyYWwuDQo+IA0KPiBHb29kIHBvaW50IGFi
b3V0IHRoZSBPcFJlZ2lvbiBkcml2ZXIgdXN1YWxseSBiZWluZyBidWlsdC1pbiwgaW4gbXkgZXhw
ZXJpZW5jZSBpdA0KPiBNVVNUIGFsd2F5cyBiZSBidWlsdC1pbiwgc28gdGhlIEtjb25maWcgb3B0
aW9uIHNob3VsZCBiZSBhIGJvb2wuIE5vdGUgdGhpcyBpcw0KPiB1c2VsZXNzIHVubGVzcyB0aGUg
bWZkIGRyaXZlciBpcyBhbHNvIGEgYm9vbCAoSSB3b3VsZCBhZHZpY2UgdG8gZ28gdGhhdA0KPiBy
b3V0ZSkgYW5kIHRoZSBtZmQgZHJpdmVyJ3MgS2NvbmZpZyBzaG91bGQgc2VsZWN0IHRoZSByaWdo
dCBpMmMgYnVzIGRyaXZlciB0bw0KPiBtYWtlIHN1cmUgdGhhdCBpcyBidWlsdC1pbiB0b28sIHNl
ZSBmb3IgZXhhbXBsZToNCj4gDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L2xlZS9tZmQuZ2l0L2NvbW1pdC8/aD1mb3ItDQo+IG1mZC1uZXh0JmlkPTJm
OTFkZWQ1ZjhmNGZkZDY3ZDhkYWFlNTE0YjBkNDM0Yzk4YWIxZTANCj4gaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbGVlL21mZC5naXQvY29tbWl0Lz9oPWZv
ci0NCj4gbWZkLW5leHQmaWQ9YzUwNjVkODYyNWViZGMxNjQxOTliOTlkODM4YWMwNjM2ZmFhN2Yw
Yg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9sZWUv
bWZkLmdpdC9jb21taXQvP2g9Zm9yLQ0KPiBtZmQtbmV4dCZpZD01ZjEyNWYxZjU3MDU2OGEyOWVk
Zjc4M2ZiYTFlYmI2MDZkNWM2YjI0DQo+IA0KPiBXaGljaCBhcmUgYWxsIHJlY2VudCBjb21taXRz
IGZyb20gbWUgZGVhbGluZyB3aXRoIG1ha2luZyB0aGUgbWZkIGRyaXZlciBidWlsdC0NCj4gaW4g
LyBzZWxlY3RpbmcgdGhlIGkyYyBidXMgZHJpdmVyLg0KPiANCg0KVGhhbmtzIGZvciB0aGVzZSBs
aW5rcy4NCkkgd2lsbCB1cGRhdGUgdGhlIEtjb25maWcgYW5kIGNvbW1pdCBtZXNzYWdlcyB3aXRo
IHJlbGV2YW50IGRlc2NyaXB0aW9uIGFyb3VuZCB0aGlzLg0K
