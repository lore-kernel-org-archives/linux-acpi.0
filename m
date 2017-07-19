From: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v1 1/3] mfd: Add new mfd device TPS68470
Date: Wed, 19 Jul 2017 23:23:51 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A59725DCCC2@FMSMSX114.amr.corp.intel.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-2-git-send-email-rajmohan.mani@intel.com>
 <CAHp75VfiTM2t=WxWpG4+kUfGA3DrfGfMOwxP6Cs42nGwHjAp7w@mail.gmail.com>
 <20170607115827.GY1019@valkosipuli.retiisi.org.uk>
 <6F87890CF0F5204F892DEA1EF0D77A59725BECB0@FMSMSX114.amr.corp.intel.com>
 <20170612082038.x6z3rx2bknxmfyfp@dell>
 <6F87890CF0F5204F892DEA1EF0D77A59725BF469@FMSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:25936 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753580AbdGSXXy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Jul 2017 19:23:54 -0400
In-Reply-To: <6F87890CF0F5204F892DEA1EF0D77A59725BF469@FMSMSX114.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Lee Jones' <lee.jones@linaro.org>
Cc: 'Sakari Ailus' <sakari.ailus@iki.fi>, 'Andy Shevchenko' <andy.shevchenko@gmail.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-gpio@vger.kernel.org'" <linux-gpio@vger.kernel.org>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, 'Linus Walleij' <linus.walleij@linaro.org>, 'Alexandre Courbot' <gnurou@gmail.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Len Brown' <lenb@kernel.org>

SGkgTGVlLA0KDQo+ID4gT24gRnJpLCAwOSBKdW4gMjAxNywgTWFuaSwgUmFqbW9oYW4gd3JvdGU6
DQo+ID4NCj4gPiA+IEhpIEFuZHksDQo+ID4gPg0KPiA+ID4gPiBPbiBUdWUsIEp1biAwNiwgMjAx
NyBhdCAwMzo1OTo0OVBNICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gPiA+ID4g
T24gVHVlLCBKdW4gNiwgMjAxNyBhdCAyOjU1IFBNLCBSYWptb2hhbiBNYW5pDQo+ID4gPiA+IDxy
YWptb2hhbi5tYW5pQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiBUaGUgVFBTNjg0NzAg
ZGV2aWNlIGlzIGFuIGFkdmFuY2VkIHBvd2VyIG1hbmFnZW1lbnQgdW5pdCB0aGF0DQo+ID4gPiA+
ID4gPiBwb3dlcnMgYSBDb21wYWN0IENhbWVyYSBNb2R1bGUgKENDTSksIGdlbmVyYXRlcyBjbG9j
a3MgZm9yDQo+ID4gPiA+ID4gPiBpbWFnZSBzZW5zb3JzLCBkcml2ZXMgYSBkdWFsIExFRCBmb3Ig
Rmxhc2ggYW5kIGluY29ycG9yYXRlcw0KPiA+ID4gPiA+ID4gdHdvIExFRCBkcml2ZXJzIGZvciBn
ZW5lcmFsIHB1cnBvc2UgaW5kaWNhdG9ycy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGlz
IHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgVFBTNjg0NzAgbWZkIGRldmljZS4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IEkgZHVubm8gd2h5IHlvdSBkZWNpZGUgdG8gc2VuZCB0aGlzIG91dCBub3csIHNl
ZSBteSBjb21tZW50cw0KPiBiZWxvdy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gK3N0YXRpYyBp
bnQgdHBzNjg0NzBfY2hpcF9pbml0KHN0cnVjdCB0cHM2ODQ3MCAqdHBzKSB7DQo+ID4gPiA+ID4g
PiArICAgICAgIHVuc2lnbmVkIGludCB2ZXJzaW9uOw0KPiA+ID4gPiA+ID4gKyAgICAgICBpbnQg
cmV0Ow0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiArICAgICAgIC8qIEZJWE1FOiBjb25maWd1cmUg
dGhlc2UgZHluYW1pY2FsbHkgKi8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNvLCB3aGF0IHByZXZl
bnRzIHlvdSB0byBmaXggdGhpcz8NCj4gPiA+ID4NCj4gPiA+ID4gTm90aGluZyBJIHN1cHBvc2Uu
IFRoZXkncmUgaG93ZXZlciBub3QgbmVlZGVkIHJpZ2h0IG5vdyBhbmQgY2FuIGJlDQo+ID4gPiA+
IGltcGxlbWVudGVkIGxhdGVyIG9uIGlmIHRoZXkncmUgZXZlciBuZWVkZWQuDQo+ID4gPiA+DQo+
ID4gPg0KPiA+ID4gQWNrDQo+ID4NCj4gPiBXaGF0IGRvZXMgdGhpcyBtZWFuPyAgSXMgdGhlIHBs
YW4gdG8gZml4IGl0IG9yIG5vdD8gIEkgZG9uJ3Qgd2FudA0KPiA+IEZJWE1FcyBpbiB0aGUgY29k
ZSB0aGF0IGEpIGNhbiBiZSBmaXhlZCByaWdodCBhd2F5IG9yIGIpIG1pZ2h0IG5ldmVyIGJlDQo+
IGZpeGVkLg0KPiA+DQo+IA0KPiBJIG1lYW50IHRoYXQgdGhpcyBjYW4gYmUgaW1wbGVtZW50ZWQg
bGF0ZXIgb24sIGlmIHRoZXJlJ3MgYSBuZWVkLg0KPiBJIHdpbGwgbG9vayBpbnRvIHRoaXMgYW5k
IHNlZSBob3cgdGhpcyBjYW4gYmUgZml4ZWQuDQo+IA0KDQpUaGFua3MgZm9yIHlvdXIgcGF0aWVu
Y2UuDQpUaGlzIGlzIGZpeGVkIHdpdGggdjQgb2YgdGhpcyBzZXJpZXMuDQoNClJhag0K
