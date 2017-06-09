From: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v1 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation
 region driver
Date: Fri, 9 Jun 2017 22:20:59 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A59725BECD0@FMSMSX114.amr.corp.intel.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-4-git-send-email-rajmohan.mani@intel.com>
 <CAHp75VcvV_AbLJCq9Rm_8yab3nViPm6ikxxme4oyw9vm4Kz7Gg@mail.gmail.com>
 <831b2236-29d9-ecaf-e7ca-74e6d1686080@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:20917 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751640AbdFIWVB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Jun 2017 18:21:01 -0400
In-Reply-To: <831b2236-29d9-ecaf-e7ca-74e6d1686080@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

SGkgSGFucywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5zIGRl
IEdvZWRlIFttYWlsdG86aGRlZ29lZGVAcmVkaGF0LmNvbV0NCj4gU2VudDogVHVlc2RheSwgSnVu
ZSAwNiwgMjAxNyA4OjIyIEFNDQo+IFRvOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5r
b0BnbWFpbC5jb20+OyBNYW5pLCBSYWptb2hhbg0KPiA8cmFqbW9oYW4ubWFuaUBpbnRlbC5jb20+
DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1ncGlvQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+IGFjcGlAdmdlci5rZXJuZWwub3JnOyBMZWUgSm9uZXMgPGxlZS5q
b25lc0BsaW5hcm8ub3JnPjsgTGludXMgV2FsbGVpag0KPiA8bGludXMud2FsbGVpakBsaW5hcm8u
b3JnPjsgQWxleGFuZHJlIENvdXJib3QgPGdudXJvdUBnbWFpbC5jb20+OyBSYWZhZWwgSi4NCj4g
V3lzb2NraSA8cmp3QHJqd3lzb2NraS5uZXQ+OyBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAzLzNdIEFDUEkgLyBQTUlDOiBBZGQgVEkgUE1JQyBU
UFM2ODQ3MCBvcGVyYXRpb24NCj4gcmVnaW9uIGRyaXZlcg0KPiANCj4gSGksDQo+IA0KPiBPbiAw
Ni8wNi8yMDE3IDA0OjIzIFBNLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gK0NjIEhhbnMg
KHRoYXQncyB3aHkgZGlkbid0IGRlbGV0ZSBhbnl0aGluZyBmcm9tIG9yaWdpbmFsIG1haWwsIGp1
c3QNCj4gPiBhZGRpbmcgbXkgY29tbWVudHMpLg0KPiA+DQo+ID4gSGFucywgaWYgeW91IGhhdmUg
ZmV3IG1pbnV0ZXMgaXQgd291bGQgYmUgYXBwcmVjaWF0ZWQgdG8gZ2xhbmNlIG9uIHRoZQ0KPiA+
IGJlbG93IGZvciBzb21lIGlzc3VlcyBpZiBhbnkgc2luY2UgeW91IGRpZCBwYXNzIHF1aXRlIGEg
Z29vZCBxdWVzdA0KPiA+IHdpdGggb3RoZXIgUE1JQyBkcml2ZXJzLg0KPiANCj4gSSd2ZSBnb25l
IG92ZXIgdGhpcyBkcml2ZXIsIG5vdGhpbmcgc3RhbmRzIG91dCBpbiBhIGJhZCB3YXkgdG8gbWUs
IElPVyB0aGlzDQo+IHNlZW1zIGxpa2UgYSBub3JtYWwgUE1JQyBPcFJlZ2lvbiBoYW5kbGVyIHRv
IG1lLg0KPiANCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3cyBhbmQgdGltZS4NCg==
