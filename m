From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [Devel] [PATCH 15/18] acpi: use ARRAY_SIZE
Date: Tue, 3 Oct 2017 16:38:17 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E613032@ORSMSX110.amr.corp.intel.com>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
 <1668017.YFhvic4TWu@aspire.rjw.lan>
 <20171002211622.30d324ca@blatinox-laptop.localdomain>
 <5437275.MVdmGJ04h3@aspire.rjw.lan>
 <e0ab5224-1120-4b06-b625-822491d6b926@canonical.com>
 <CAJZ5v0j+UPDJrWfiZzE26=PGSzmqZnQwMwCkei9N8+M1JkEmyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62423 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751801AbdJCQiU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Oct 2017 12:38:20 -0400
In-Reply-To: <CAJZ5v0j+UPDJrWfiZzE26=PGSzmqZnQwMwCkei9N8+M1JkEmyg@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Colin Ian King <colin.king@canonical.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, =?utf-8?B?SsOpcsOpbXkgTGVmYXVyZQ==?= <jeremy.lefaure@lse.epita.fr>, "devel@acpica.org" <devel@acpica.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGV2ZWwgW21haWx0bzpk
ZXZlbC1ib3VuY2VzQGFjcGljYS5vcmddIE9uIEJlaGFsZiBPZiBSYWZhZWwgSi4NCj4gV3lzb2Nr
aQ0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDMsIDIwMTcgOTowNSBBTQ0KPiBUbzogQ29saW4g
SWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gQ2M6IFd5c29ja2ksIFJhZmFl
bCBKIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT47IFJhZmFlbCBKLiBXeXNvY2tpDQo+IDxy
andAcmp3eXNvY2tpLm5ldD47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgQUNQSSBEZXZlbCBNYWxpbmcgTGlzdCA8bGludXgtDQo+
IGFjcGlAdmdlci5rZXJuZWwub3JnPjsgSsOpcsOpbXkgTGVmYXVyZSA8amVyZW15LmxlZmF1cmVA
bHNlLmVwaXRhLmZyPjsNCj4gZGV2ZWxAYWNwaWNhLm9yZw0KPiBTdWJqZWN0OiBSZTogW0RldmVs
XSBbUEFUQ0ggMTUvMThdIGFjcGk6IHVzZSBBUlJBWV9TSVpFDQo+IA0KPiBPbiBUdWUsIE9jdCAz
LCAyMDE3IGF0IDI6MzQgUE0sIENvbGluIElhbiBLaW5nDQo+IDxjb2xpbi5raW5nQGNhbm9uaWNh
bC5jb20+IHdyb3RlOg0KPiA+IE9uIDAzLzEwLzE3IDEyOjM5LCBSYWZhZWwgSi4gV3lzb2NraSB3
cm90ZToNCj4gPj4gT24gVHVlc2RheSwgT2N0b2JlciAzLCAyMDE3IDM6MTY6MjIgQU0gQ0VTVCBK
w6lyw6lteSBMZWZhdXJlIHdyb3RlOg0KPiA+Pj4gT24gTW9uLCAwMiBPY3QgMjAxNyAxNDoyNzo1
MiArMDIwMA0KPiA+Pj4gIlJhZmFlbCBKLiBXeXNvY2tpIiA8cmp3QHJqd3lzb2NraS5uZXQ+IHdy
b3RlOg0KPiA+Pj4NCj4gPj4+PiBBQ1BJQ0EgaXMgc29ld2hhdCBzcGVjaWFsIGNvZGUsIHRob3Vn
aCBhbmQgSSdtIG5vdCB0YWtpbmcgb3IgQUNLaW5nDQo+ID4+Pj4gcGF0Y2hlcyBmb3IgaXQgZGly
ZWN0bHkgYXMgYSBydWxlLg0KPiA+Pj4+DQo+ID4+Pj4gRm9yIG9uZSwgSSdtIG5vdCBzdXJlIGlm
IEFDUElDQSBjYW4gdXNlIEFSUkFZX1NJWkUgYXQgYWxsLg0KPiA+Pj4gV2h5IGlzIGl0IHNwZWNp
YWwgY29kZSB0aGF0IGNhbid0IHVzZSBBUlJBWV9TSVpFID8gSXMgaXQgYmVjYXVzZQ0KPiA+Pj4g
dGhpcyBtYWNybyBpcyBkZWZpbmVkIGluIGxpbnV4L2tlcm5lbC5oID8NCj4gPg0KPiA+IEhvd2V2
ZXIsIEFDUElDQSBkb2VzIGhhdmUgQUNQSV9BUlJBWV9MRU5HVEgoeCksIHNlZQ0KPiA+IHNvdXJj
ZS9pbmNsdWRlL2FjdHlwZXMuaA0KPiANCj4gRmFpciBlbm91Z2gsIGJ1dCB0aGF0IGNsZWFudXAg
c2hvdWxkIGdvIGluIHZpYSBBQ1BJQ0EgdXBzdHJlYW0gYW55d2F5Lg0KW01vb3JlLCBSb2JlcnRd
IA0KDQpUaGlzIHdvdWxkIGJlIGFjY2VwdGFibGUsIGFzIGxvbmcgYXMgaXQgd2lsbCB3b3JrIHBy
b3Blcmx5IGluIHRoZSBjYXNlcyB0aGF0IHdlcmUgcHJlc2VudGVkIGVhcmxpZXIgKHVzaW5nIEFS
UkFZX1NJWkUpLg0KDQoNCj4gDQo+IFRoYW5rcywNCj4gUmFmYWVsDQo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IERldmVsIG1haWxpbmcgbGlzdA0K
PiBEZXZlbEBhY3BpY2Eub3JnDQo+IGh0dHBzOi8vbGlzdHMuYWNwaWNhLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RldmVsDQo=
