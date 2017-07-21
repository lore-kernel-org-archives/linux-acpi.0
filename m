From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Fri, 21 Jul 2017 16:40:20 +0000
Message-ID: <1500654661.2042.49.camel@hpe.com>
References: <20170718060007.GB8736@nazgul.tnic>
         <1500407379.2042.21.camel@hpe.com>     <20170718181545.32bd9181@vento.lan>
         <1500481869.2042.29.camel@hpe.com>     <20170720043344.GC14367@nazgul.tnic>
         <1500579646.2042.37.camel@hpe.com>     <20170721133441.GB5036@nazgul.tnic>
         <20170721104001.3cd2b884@vento.lan>    <20170721134715.GC5036@nazgul.tnic>
         <1500649162.2042.43.camel@hpe.com>     <20170721151317.GA13424@nazgul.tnic>
         <1500650732.2042.45.camel@hpe.com> <20170721124401.5f94aba9@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:56940 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdGUQkY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2017 12:40:24 -0400
In-Reply-To: <20170721124401.5f94aba9@vento.lan>
Content-Language: en-US
Content-ID: <0C8054128F61B44BB6BEE931C0404DA3@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "mchehab@s-opensource.com" <mchehab@s-opensource.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

T24gRnJpLCAyMDE3LTA3LTIxIGF0IDEyOjQ0IC0wMzAwLCBNYXVybyBDYXJ2YWxobyBDaGVoYWIg
d3JvdGU6DQo+IEVtIEZyaSwgMjEgSnVsIDIwMTcgMTU6MzQ6NTAgKzAwMDANCj4gIkthbmksIFRv
c2hpbWl0c3UiIDx0b3NoaS5rYW5pQGhwZS5jb20+IGVzY3JldmV1Og0KPiANCj4gPiBPbiBGcmks
IDIwMTctMDctMjEgYXQgMTc6MTMgKzAyMDAsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gPiA+
IE9uIEZyaSwgSnVsIDIxLCAyMDE3IGF0IDAzOjA4OjQxUE0gKzAwMDAsIEthbmksIFRvc2hpbWl0
c3UNCj4gPiA+IHdyb3RlOsKgwqANCj4gPiA+ID4gWWVzLCB0aGF0IGlzIGNvcnJlY3QuwqDCoENv
cnJlY3RlZCBlcnJvcnMgYXJlIHJlcG9ydGVkIHRvIHRoZSBPUw0KPiA+ID4gPiB3aGVuIHRoZXkg
ZXhjZWVkZWQgdGhlIHBsYXRmb3JtJ3MgdGhyZXNob2xkLsKgwqANCj4gPiA+IA0KPiA+ID4gQXJl
IHRob3NlIHRocmVzaG9sZHMgdXNlci1jb25maWd1cmFibGU/wqDCoA0KPiA+IA0KPiA+IEkgc3Vw
cG9zZSBpdCdkIGRlcGVuZCBvbiB2ZW5kb3JzLCBidXQgSSBkbyBub3QgdGhpbmsgdXNlcnMgY2Fu
IGRvDQo+ID4gaXQgcHJvcGVybHkgdW5sZXNzIHRoZXkgaGF2ZSBkZXB0aCBrbm93bGVkZ2UgYWJv
dXQgdGhlIGhhcmR3YXJlLg0KPiA+IA0KPiA+ID4gSWYgbm90LCB3aGF0IGFyZSB5b3UgdGVsbGlu
ZyB1c2VycyB3aG8gd2FudCB0byBzZWUgKmV2ZXJ5Kg0KPiA+ID4gY29ycmVjdGVkIGVycm9yIGZv
ciBtZWFzdXJpbmcgRElNTSB3ZWFyIGFuZCBzbyBvbi4uLj/CoMKgDQo+ID4gDQo+ID4gQ29ycmVj
dGVkIGVycm9ycyBhcmUgbm9ybWFsIGFuZCBleHBlY3RlZCB0byBvY2N1ciBvbiBoZWFsdGh5DQo+
ID4gaGFyZHdhcmUuICBUaGV5IGRvIG5vdCBuZWVkIHVzZXIncyBhdHRlbnRpb24gdW50aWwgdGhl
eSByZXBlYXRlZGx5DQo+ID4gb2NjdXJyZWQgYXQgYSBzYW1lIHBsYWNlLg0KPiANCj4gWWVzLCB0
aGV5J3JlIGV4cGVjdGVkIHRvIGhhcHBlbi4gU3RpbGwsIHNvbWUgc3lzIGFkbWlucyBoYXZlIHRo
ZWlyDQo+IG93biBtZWFzdXJlbWVudHMgYWJvdXQgd2hhdCdzICJub3JtYWwiIGZvciB0aGVpciBz
Y2VuYXJpbywgYW5kIHdhbnQNCj4gdG8gbW9uaXRvciBldmVyeSBzaW5nbGUgY29ycmVjdGVkIGVy
cm9yLCBydW5uaW5nIHRoZWlyIG93bg0KPiBhbGdvcml0aG0gdG8gd2FybiBpZiB0aGUgbnVtYmVy
IG9mIGNvcnJlY3RlZCBlcnJvcnMgaXMgYWJvdmUgdGhlaXINCj4gIm5vcm1hbCIgcmF0ZS4NCg0K
SSBzdXBwb3NlIHRoZXNlIGFkbWlucyBoYWQgdG8gZG8gaXQgYmVjYXVzZSB0aGVpciBwbGF0Zm9y
bXMgcmVwb3J0ZWQNCmFsbCBjb3JyZWN0ZWQgZXJyb3JzLiAgSXQgYWRkcmVzc2VzIHN1Y2ggYWRt
aW5pc3RyYXRvcnMnIGJ1cmRlbi4NCg0KVGhhbmtzLA0KLVRvc2hpDQo=
