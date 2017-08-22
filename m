From: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v5 0/3] TPS68470 PMIC drivers
Date: Tue, 22 Aug 2017 00:13:07 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A5972FA6A91@FMSMSX114.amr.corp.intel.com>
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
Received: from mga07.intel.com ([134.134.136.100]:8275 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754466AbdHVANJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Aug 2017 20:13:09 -0400
In-Reply-To: <CAJZ5v0hO3oSJWT_CxcP0ogO2yAU=YKYRwGokPqbQbAvWY7mzQg@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Len Brown <lenb@kernel.org>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>

SGkgUmFmYWVsLA0KDQo+ID4+ID4gPj4gPiBUaGlzIGlzIHRoZSBwYXRjaCBzZXJpZXMgZm9yIFRQ
UzY4NDcwIFBNSUMgdGhhdCB3b3JrcyBhcyBhIGNhbWVyYQ0KPiBQTUlDLg0KPiA+PiA+ID4+ID4N
Cj4gPj4gPiA+PiA+IFRoZSBwYXRjaCBzZXJpZXMgcHJvdmlkZSB0aGUgZm9sbG93aW5nIDMgZHJp
dmVycywgdG8gaGVscA0KPiA+PiA+ID4+ID4gY29uZmlndXJlIHRoZQ0KPiA+PiB2b2x0YWdlIHJl
Z3VsYXRvcnMsIGNsb2NrcyBhbmQgR1BJT3MgcHJvdmlkZWQgYnkgdGhlIFRQUzY4NDcwIFBNSUMs
DQo+ID4+IHRvIGJlIGFibGUgdG8gdXNlIHRoZSBjYW1lcmEgc2Vuc29ycyBjb25uZWN0ZWQgdG8g
dGhpcyBQTUlDLg0KPiA+PiA+ID4+ID4NCj4gPj4gPiA+PiA+IFRQUzY4NDcwIE1GRCBkcml2ZXI6
DQo+ID4+ID4gPj4gPiBUaGlzIGlzIHRoZSBtdWx0aSBmdW5jdGlvbiBkcml2ZXIgdGhhdCBpbml0
aWFsaXplcyB0aGUNCj4gPj4gPiA+PiA+IFRQUzY4NDcwIFBNSUMgYW5kDQo+ID4+IHN1cHBvcnRz
IHRoZSBHUElPIGFuZCBPcCBSZWdpb24gZnVuY3Rpb25zLg0KPiA+PiA+ID4+ID4NCj4gPj4gPiA+
PiA+IFRQUzY4NDcwIEdQSU8gZHJpdmVyOg0KPiA+PiA+ID4+ID4gVGhpcyBpcyB0aGUgUE1JQyBH
UElPIGRyaXZlciB0aGF0IHdpbGwgYmUgdXNlZCBieSB0aGUgT1MgR1BJTw0KPiA+PiA+ID4+ID4g
bGF5ZXIsDQo+ID4+IHdoZW4gdGhlIEJJT1MgLyBmaXJtd2FyZSB0cmlnZ2VyZWQgR1BJTyBhY2Nl
c3MgaXMgZG9uZS4NCj4gPj4gPiA+PiA+DQo+ID4+ID4gPj4gPiBUUFM2ODQ3MCBPcCBSZWdpb24g
ZHJpdmVyOg0KPiA+PiA+ID4+ID4gVGhpcyBpcyB0aGUgZHJpdmVyIHRoYXQgd2lsbCBiZSBpbnZv
a2VkLCB3aGVuIHRoZSBCSU9TIC8NCj4gPj4gPiA+PiA+IGZpcm13YXJlDQo+ID4+IGNvbmZpZ3Vy
ZXMgdGhlIHZvbHRhZ2UgLyBjbG9jayBmb3IgdGhlIHNlbnNvcnMgLyB2Y20gZGV2aWNlcw0KPiA+
PiBjb25uZWN0ZWQgdG8gdGhlIFBNSUMuDQo+ID4+ID4gPj4gPg0KPiA+PiA+ID4+DQo+ID4+ID4g
Pj4gQWxsIHRocmVlIHBhdGNoZXMgYXJlIGdvb2QgdG8gbWUgKHdlIGRpZCBmZXcgcm91bmRzIG9m
IGludGVybmFsDQo+ID4+ID4gPj4gcmV2aWV3IGJlZm9yZSBwb3N0aW5nIHY0KQ0KPiA+PiA+ID4+
DQo+ID4+ID4gPj4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtv
QGdtYWlsLmNvbT4NCj4gPj4gPiA+DQo+ID4+ID4gPiBPSywgc28gaG93IHNob3VsZCB0aGV5IGJl
IHJvdXRlZD8NCj4gPj4gPg0KPiA+PiA+IEdvb2QgcXVlc3Rpb24uIEkgZG9uJ3Qga25vdyBob3cg
bGFzdCB0aW1lIFBNSUMgZHJpdmVycyB3ZXJlIG1lcmdlZCwNCj4gPj4gPiBoZXJlIEkgdGhpbmsg
aXMganVzdCBzYW5lIHRvIHJvdXRlIHZpIE1GRCB3aXRoIGltbXV0YWJsZSBicmFuY2gNCj4gPj4g
PiBjcmVhdGVkLg0KPiA+Pg0KPiA+PiBPSw0KPiA+Pg0KPiA+PiBJIHdpbGwgYXNzdW1lIHRoYXQg
dGhlIHNlcmllcyB3aWxsIGdvIGluIHRocm91Z2ggTUZEIHRoZW4uDQo+ID4+DQo+ID4NCj4gPiBO
b3cgdGhhdCB0aGUgTUZEIGFuZCBHUElPIHBhdGNoZXMgb2YgdjYgb2YgdGhpcyBzZXJpZXMgaGF2
ZSBiZWVuIGFwcGxpZWQNCj4gb24gcmVzcGVjdGl2ZSB0cmVlcywgY2FuIHlvdSBhZHZpc2UgdGhl
IG5leHQgc3RlcHMgZm9yIHRoZSBBQ1BJIC8gUE1JQyBPcHJlZ2lvbg0KPiBkcml2ZXI/DQo+IA0K
PiBXZWxsLCBpdCB3b3VsZCBoYXZlIGJlZW4gYmV0dGVyIHRvIHJvdXRlIHRoZSB3aG9sZSBzZXJp
ZXMgdGhyb3VnaCBvbmUgdHJlZS4NCj4gTm93IGl0J3MgYmV0dGVyIHRvIHdhaXQgdW50aWwgdGhl
IHR3byBvdGhlciB0cmVlcyBnZXQgbWVyZ2VkIGFuZCB0aGVuIGFwcGx5IHRoZQ0KPiBvcHJlZ2lv
biBwYXRjaC4NCj4gDQoNCkFjay4NCkxldCBtZSBnZXQgYmFjayBvbmNlIHRoZSBvdGhlciAyIHRy
ZWVzIGFyZSBtZXJnZWQuDQoNClRoYW5rcw0KUmFqDQo=
