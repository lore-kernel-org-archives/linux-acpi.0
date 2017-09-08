From: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v5 0/3] TPS68470 PMIC drivers
Date: Fri, 8 Sep 2017 00:45:59 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A5972FBDA4A@FMSMSX114.amr.corp.intel.com>
References: <1500648378-10294-1-git-send-email-rajmohan.mani@intel.com>
 <3425487.LgIRMVflim@aspire.rjw.lan>
 <CAHp75VdtEh8MAFjQN2LWVFbJj7_bPrhjo77SEsCYVmuOCWvOfQ@mail.gmail.com>
 <2076994.J7nKrPWSDx@aspire.rjw.lan>
 <6F87890CF0F5204F892DEA1EF0D77A5972FA69A3@FMSMSX114.amr.corp.intel.com>
 <CAJZ5v0hO3oSJWT_CxcP0ogO2yAU=YKYRwGokPqbQbAvWY7mzQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56712 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751774AbdIHAqC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Sep 2017 20:46:02 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Len Brown <lenb@kernel.org>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>

SGkgUmFmYWVsLA0KDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjUgMC8zXSBUUFM2ODQ3MCBQTUlD
IGRyaXZlcnMNCj4gDQo+IEhpIFJhZmFlbCwNCj4gDQo+ID4gPj4gPiA+PiA+IFRoaXMgaXMgdGhl
IHBhdGNoIHNlcmllcyBmb3IgVFBTNjg0NzAgUE1JQyB0aGF0IHdvcmtzIGFzIGENCj4gPiA+PiA+
ID4+ID4gY2FtZXJhDQo+ID4gUE1JQy4NCj4gPiA+PiA+ID4+ID4NCj4gPiA+PiA+ID4+ID4gVGhl
IHBhdGNoIHNlcmllcyBwcm92aWRlIHRoZSBmb2xsb3dpbmcgMyBkcml2ZXJzLCB0byBoZWxwDQo+
ID4gPj4gPiA+PiA+IGNvbmZpZ3VyZSB0aGUNCj4gPiA+PiB2b2x0YWdlIHJlZ3VsYXRvcnMsIGNs
b2NrcyBhbmQgR1BJT3MgcHJvdmlkZWQgYnkgdGhlIFRQUzY4NDcwIFBNSUMsDQo+ID4gPj4gdG8g
YmUgYWJsZSB0byB1c2UgdGhlIGNhbWVyYSBzZW5zb3JzIGNvbm5lY3RlZCB0byB0aGlzIFBNSUMu
DQo+ID4gPj4gPiA+PiA+DQo+ID4gPj4gPiA+PiA+IFRQUzY4NDcwIE1GRCBkcml2ZXI6DQo+ID4g
Pj4gPiA+PiA+IFRoaXMgaXMgdGhlIG11bHRpIGZ1bmN0aW9uIGRyaXZlciB0aGF0IGluaXRpYWxp
emVzIHRoZQ0KPiA+ID4+ID4gPj4gPiBUUFM2ODQ3MCBQTUlDIGFuZA0KPiA+ID4+IHN1cHBvcnRz
IHRoZSBHUElPIGFuZCBPcCBSZWdpb24gZnVuY3Rpb25zLg0KPiA+ID4+ID4gPj4gPg0KPiA+ID4+
ID4gPj4gPiBUUFM2ODQ3MCBHUElPIGRyaXZlcjoNCj4gPiA+PiA+ID4+ID4gVGhpcyBpcyB0aGUg
UE1JQyBHUElPIGRyaXZlciB0aGF0IHdpbGwgYmUgdXNlZCBieSB0aGUgT1MNCj4gPiA+PiA+ID4+
ID4gR1BJTyBsYXllciwNCj4gPiA+PiB3aGVuIHRoZSBCSU9TIC8gZmlybXdhcmUgdHJpZ2dlcmVk
IEdQSU8gYWNjZXNzIGlzIGRvbmUuDQo+ID4gPj4gPiA+PiA+DQo+ID4gPj4gPiA+PiA+IFRQUzY4
NDcwIE9wIFJlZ2lvbiBkcml2ZXI6DQo+ID4gPj4gPiA+PiA+IFRoaXMgaXMgdGhlIGRyaXZlciB0
aGF0IHdpbGwgYmUgaW52b2tlZCwgd2hlbiB0aGUgQklPUyAvDQo+ID4gPj4gPiA+PiA+IGZpcm13
YXJlDQo+ID4gPj4gY29uZmlndXJlcyB0aGUgdm9sdGFnZSAvIGNsb2NrIGZvciB0aGUgc2Vuc29y
cyAvIHZjbSBkZXZpY2VzDQo+ID4gPj4gY29ubmVjdGVkIHRvIHRoZSBQTUlDLg0KPiA+ID4+ID4g
Pj4gPg0KPiA+ID4+ID4gPj4NCj4gPiA+PiA+ID4+IEFsbCB0aHJlZSBwYXRjaGVzIGFyZSBnb29k
IHRvIG1lICh3ZSBkaWQgZmV3IHJvdW5kcyBvZg0KPiA+ID4+ID4gPj4gaW50ZXJuYWwgcmV2aWV3
IGJlZm9yZSBwb3N0aW5nIHY0KQ0KPiA+ID4+ID4gPj4NCj4gPiA+PiA+ID4+IFJldmlld2VkLWJ5
OiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+ID4gPj4gPiA+
DQo+ID4gPj4gPiA+IE9LLCBzbyBob3cgc2hvdWxkIHRoZXkgYmUgcm91dGVkPw0KPiA+ID4+ID4N
Cj4gPiA+PiA+IEdvb2QgcXVlc3Rpb24uIEkgZG9uJ3Qga25vdyBob3cgbGFzdCB0aW1lIFBNSUMg
ZHJpdmVycyB3ZXJlDQo+ID4gPj4gPiBtZXJnZWQsIGhlcmUgSSB0aGluayBpcyBqdXN0IHNhbmUg
dG8gcm91dGUgdmkgTUZEIHdpdGggaW1tdXRhYmxlDQo+ID4gPj4gPiBicmFuY2ggY3JlYXRlZC4N
Cj4gPiA+Pg0KPiA+ID4+IE9LDQo+ID4gPj4NCj4gPiA+PiBJIHdpbGwgYXNzdW1lIHRoYXQgdGhl
IHNlcmllcyB3aWxsIGdvIGluIHRocm91Z2ggTUZEIHRoZW4uDQo+ID4gPj4NCj4gPiA+DQo+ID4g
PiBOb3cgdGhhdCB0aGUgTUZEIGFuZCBHUElPIHBhdGNoZXMgb2YgdjYgb2YgdGhpcyBzZXJpZXMg
aGF2ZSBiZWVuDQo+ID4gPiBhcHBsaWVkDQo+ID4gb24gcmVzcGVjdGl2ZSB0cmVlcywgY2FuIHlv
dSBhZHZpc2UgdGhlIG5leHQgc3RlcHMgZm9yIHRoZSBBQ1BJIC8gUE1JQw0KPiA+IE9wcmVnaW9u
IGRyaXZlcj8NCj4gPg0KPiA+IFdlbGwsIGl0IHdvdWxkIGhhdmUgYmVlbiBiZXR0ZXIgdG8gcm91
dGUgdGhlIHdob2xlIHNlcmllcyB0aHJvdWdoIG9uZSB0cmVlLg0KPiA+IE5vdyBpdCdzIGJldHRl
ciB0byB3YWl0IHVudGlsIHRoZSB0d28gb3RoZXIgdHJlZXMgZ2V0IG1lcmdlZCBhbmQgdGhlbg0K
PiA+IGFwcGx5IHRoZSBvcHJlZ2lvbiBwYXRjaC4NCj4gPg0KPiANCj4gQWNrLg0KPiBMZXQgbWUg
Z2V0IGJhY2sgb25jZSB0aGUgb3RoZXIgMiB0cmVlcyBhcmUgbWVyZ2VkLg0KPiANCg0KQm90aCBN
RkQgYW5kIEdQSU8gcGF0Y2hlcyBvZiB0aGlzIHNlcmllcyBnb3QgbWVyZ2VkIHVwc3RyZWFtIGFz
IG9mIHRvZGF5Lg0KDQpUaGFua3MNClJhag0K
