From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 13/30] ACPI / sysfs: Provide quirk mechanism to prevent
 GPE flooding
Date: Thu, 11 Aug 2016 03:30:55 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC0CD8D@SHSMSX101.ccr.corp.intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
 <3d86ecd98996bc782a1f4a0bb0c0a0ae2b958df9.1470299677.git.lv.zheng@intel.com>
 <1940728.OSvgQcsBu1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41240 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932276AbcHKDeF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Aug 2016 23:34:05 -0400
In-Reply-To: <1940728.OSvgQcsBu1@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

SGksIFJhZmFlbA0KDQo+IEZyb206IFJhZmFlbCBKLiBXeXNvY2tpIFttYWlsdG86cmp3QHJqd3lz
b2NraS5uZXRdDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMTMvMzBdIEFDUEkgLyBzeXNmczogUHJv
dmlkZSBxdWlyayBtZWNoYW5pc20gdG8NCj4gcHJldmVudCBHUEUgZmxvb2RpbmcNCj4gDQo+IE9u
IFRodXJzZGF5LCBBdWd1c3QgMDQsIDIwMTYgMDQ6NDM6NTEgUE0gTHYgWmhlbmcgd3JvdGU6DQo+
ID4gU29tZXRpbWVzLCB0aGUgdXNlcnMgbWF5IHJlcXVpcmUgYSBxdWlyayB0byBiZSBwcm92aWRl
ZCBmcm9tIEFDUEkNCj4gc3Vic3lzdGVtDQo+ID4gY29yZSB0byBwcmV2ZW50IGEgR1BFIGZyb20g
Zmxvb2RpbmcuIE5vcm1hbGx5LCBpZiBhIEdQRSBjYW5ub3QgYmUNCj4gPiBkaXNwYXRjaGVkLCBB
Q1BJQ0EgY29yZSBhdXRvbWF0aWNhbGx5IHByZXZlbnRzIHRoZSBHUEUgZnJvbSBmaXJpbmcuIEJ1
dA0KPiA+IHRoZXJlIGFyZSBjYXNlcyB0aGUgR1BFIGlzIGRpc3BhdGNoZWQgYnkgX0x4eC9fRXh4
IHByb3ZpZGVkIHZpYSBBTUwNCj4gdGFibGUsDQo+ID4gYW5kIE9TUE0gaXMgbGFja2luZyBvZiB0
aGUga25vd2xlZGdlIHRvIGdldCBfTHh4L19FeHggY29ycmVjdGx5DQo+IGV4ZWN1dGVkIHRvDQo+
ID4gaGFuZGxlIHRoZSBHUEUsIHRodXMgdGhlIEdQRSBmbG9vZGluZyBtYXkgc3RpbGwgb2NjdXIu
DQo+ID4NCj4gPiBUaGlzIHBhdGNoIHByb3ZpZGVzIGEgcXVpcmsgbWVjaGFuaXNtIHRvIHN0b3Ag
dGhpcyBraW5kIG9mIEdQRSBmbG9vZGluZy4NCj4gPg0KPiA+IExpbms6IGh0dHBzOi8vYnVnemls
bGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9NTMwNzENCj4gPiBMaW5rOiBodHRwczovL2J1
Z3MubGF1bmNocGFkLm5ldC91YnVudHUvK3NvdXJjZS9saW51eC8rYnVnLzg4Nzc5Mw0KPiA+IFNp
Z25lZC1vZmYtYnk6IEx2IFpoZW5nIDxsdi56aGVuZ0BpbnRlbC5jb20+DQo+IA0KPiBJIGRpZG4n
dCBsaWtlIHRoaXMgcGF0Y2ggYmVmb3JlIGFuZCBJIHN0aWxsIGRvbid0IGxpa2UgaXQuDQo+IA0K
W0x2IFpoZW5nXSANCk9LLg0KU28gcGxlYXNlIGhlbHAgdG8gZHJvcCBpdCBmcm9tIHRoaXMgc2Vy
aWVzLg0KDQo+IEJlc2lkZXMsIEknZCBhcHByZWNpYXRlIGl0IGlmIHlvdSBkaWRuJ3QgbWl4IEFD
UElDQSByZWxlYXNlIHBhdGNoZXMgd2l0aA0KPiBub24tQUNQSUNBIG9uZXMuDQpbTHYgWmhlbmdd
IA0KT0suDQpTb21ldGltZXMsIEknbGwgaGF2ZSB0byBwdXQgbm9uLUFDUElDQSBtYXRlcmlhbHMg
aW4gdGhlIEFDUElDQSByZWxlYXNlIHNlcmllcyBpbiBvcmRlciBub3QgdG8gYnJlYWsgdGhpbmdz
IGJlY2F1c2Ugb2YgQUNQSUNBIHVwc3RyZWFtIGNoYW5nZXMuDQpCdXQgdGhpcyBwYXRjaCBpc24n
dCBzdWNoIGtpbmQgb2YgcmVxdWlyZWQgdXBkYXRlLCBpdCdzIG15IGZhdWx0LCBwbGVhc2UgZHJv
cCBpdC4NCg0KVGhhbmtzDQpMdg0KDQo=
