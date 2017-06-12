From: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v1 2/3] gpio: Add support for TPS68470 GPIOs
Date: Mon, 12 Jun 2017 09:17:38 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A59725BF45D@FMSMSX114.amr.corp.intel.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-3-git-send-email-rajmohan.mani@intel.com>
 <CAHp75Vc6PSDqc=Vxj2z-d49p+E-7tciunhki=8a7HPjQGuSwXQ@mail.gmail.com>
 <6F87890CF0F5204F892DEA1EF0D77A59725BF110@FMSMSX114.amr.corp.intel.com>
 <20170611113007.GV1019@valkosipuli.retiisi.org.uk>
 <CAHp75VeJaQjWb1834Nt7178GL72rcym=d3zV8tPpvJ5qKDuM_Q@mail.gmail.com>
 <20170611165028.GA12407@valkosipuli.retiisi.org.uk>
 <CAHp75VcyPy5kO+Ra-fPqaXZOp66sTe=L6W4UF00JWA6LP_KGeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16300 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752298AbdFLJRm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Jun 2017 05:17:42 -0400
In-Reply-To: <CAHp75VcyPy5kO+Ra-fPqaXZOp66sTe=L6W4UF00JWA6LP_KGeQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

SGkgQW5keSwgU2FrYXJpLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMi8zXSBncGlvOiBB
ZGQgc3VwcG9ydCBmb3IgVFBTNjg0NzAgR1BJT3MNCj4gDQo+IE9uIFN1biwgSnVuIDExLCAyMDE3
IGF0IDc6NTAgUE0sIFNha2FyaSBBaWx1cyA8c2FrYXJpLmFpbHVzQGlraS5maT4gd3JvdGU6DQo+
ID4gT24gU3VuLCBKdW4gMTEsIDIwMTcgYXQgMDQ6NDA6MTZQTSArMDMwMCwgQW5keSBTaGV2Y2hl
bmtvIHdyb3RlOg0KPiA+PiBPbiBTdW4sIEp1biAxMSwgMjAxNyBhdCAyOjMwIFBNLCBTYWthcmkg
QWlsdXMgPHNha2FyaS5haWx1c0Bpa2kuZmk+IHdyb3RlOg0KPiANCj4gPj4gPiBBZ2FpbiwgSSdt
IG5vdCByZWFsbHkgd29ycmllZCBhYm91dCB0aGlzIGRyaXZlciwgYnV0IHRoZSBBQ1BJDQo+ID4+
ID4gdGFibGVzLiBIb3cgZG9lcyB0aGUgZGlmZmVyZW5jZSBzaG93IHRoZXJlPw0KPiA+Pg0KPiA+
PiBTYW1lIHdheS4gWW91IHdpbGwgaGF2ZSBjb21tb24gbnVtYmVyaW5nIG92ZXIgdGhlIGNoaXAg
WzAsIDldLiBJdA0KPiA+PiB3aWxsIGJlIGp1c3QgYW4gYWJzdHJhY3Rpb24gaW5zaWRlIHRoZSBk
cml2ZXIuDQo+ID4NCj4gPiBPaCwgaW4gdGhhdCBjYXNlIHRoYXQgc2hvdWxkIGJlIGEgbm9uLWlz
c3VlLg0KPiANCj4gPj4gQWJvdmUgc3RhdGVzIHRoZSBvcHBvc2l0ZSwgc28sIGl0J3MgY2xlYXIg
dG8gbWUgdGhhdCBhYnN0cmFjdGlvbiBvZiAyDQo+ID4+IEdQSU8gY2hpcHMgb3ZlciAxIGNhbiBi
ZSB1dGlsaXplZCBoZXJlLg0KPiA+DQo+ID4gU291bmRzIGZpbmUgdG8gbWUsIHRha2VuIHRoYXQg
dGhpcyBkb2VzIG5vdCBhZGQgY29tcGxpY2F0aW9ucyB0byBBQ1BJDQo+ID4gdGFibGVzLg0KPiAN
Cj4gVGhleSBqdXN0IG5lZWQgdG8gc2hhcmUgdGhlIHNhbWUgQUNQSV9IQU5ETEUgKGl0IG1pZ2h0
IHJlcXVpcmUgdG8gZG8gdGhpcyBpbg0KPiBnZW5lcmljIHdheSBpbiBncGlvbGliKSBhbmQgaGF2
ZSBhIGNvbnRpbnVvdXMgbnVtYmVyaW5nIChlYXN5IHRvIGFjaGlldmUgd2l0aA0KPiBjYXJlZnVs
bHkgY2hvc2VuIGJhc2VzKS4NCj4gDQoNCkZldyBjbGFyaWZpY2F0aW9ucy4uLg0KDQpBcmUgeW91
IGltcGx5aW5nIG5ldyBrZXJuZWwgY2hhbmdlcyBhcmUgbmVlZGVkIGluIGdwaW9saWIgdG8gYWNj
b21tb2RhdGUgMiBHUElPIGNoaXBzPw0KRG9lcyBpdCBuZWVkIGNoYW5nZXMgaW4gcGxhdGZvcm0g
ZmlybXdhcmUgb3IgaXMgaXQgZXhwZWN0ZWQgdG8gd29yayBqdXN0IHdpdGggdGhlIGdwaW9saWIg
Y2hhbmdlcyB0aGF0IHlvdSBkZXNjcmliZWQgYWJvdmU/DQoNClRoYW5rcw0KUmFqDQo=
