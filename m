From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH V2] ACPI/Battery: Add a _BIX quirk for NEC LZ750/LS
Date: Wed, 15 Jan 2014 16:48:55 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7BF73F@ORSMSX103.amr.corp.intel.com>
References: <1389019837-13619-1-git-send-email-tianyu.lan@intel.com>
 <5255063.SeYbBZqxVQ@vostro.rjw.lan> <20140114212406.GA25438@srcf.ucam.org>
 <4100200.O09E65sAKi@vostro.rjw.lan> <52D69E57.5020208@intel.com>
 <20140115144720.GA23218@srcf.ucam.org> <52D6A3FF.8070100@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31722 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbaAOQs6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jan 2014 11:48:58 -0500
In-Reply-To: <52D6A3FF.8070100@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lan, Tianyu" <tianyu.lan@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "fcr@adinet.com.uy" <fcr@adinet.com.uy>, "l@dorileo.org" <l@dorileo.org>, "Zheng, Lv" <lv.zheng@intel.com>

SWYgYW4gb2JqZWN0IGRvZXMgbm90IGV4aXN0LCBBRV9OT1RfRk9VTkQgaXMgcmV0dXJuZWQgYnkg
ZXZhbHVhdGVfb2JqZWN0Lg0KDQpJZiB0aGUgcGFja2FnZSBpcyBlbXB0eSBvciBoYXMgaW5zdWZm
aWNpZW50IGVsZW1lbnRzLCBzb21ldGhpbmcgbGlrZSBBRV9BTUxfT1BFUkFORF9WQUxVRSBpcyBy
ZXR1cm5lZC4NCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhbiwg
VGlhbnl1DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAxNSwgMjAxNCA3OjA3IEFNDQo+IFRv
OiBNYXR0aGV3IEdhcnJldHQNCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpOyBEbWl0cnkgVG9yb2to
b3Y7IGxlbmJAa2VybmVsLm9yZzsgbGludXgtDQo+IGFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBmY3JAYWRpbmV0LmNvbS51eTsNCj4gbEBkb3JpbGVv
Lm9yZzsgWmhlbmcsIEx2OyBNb29yZSwgUm9iZXJ0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjJd
IEFDUEkvQmF0dGVyeTogQWRkIGEgX0JJWCBxdWlyayBmb3IgTkVDIExaNzUwL0xTDQo+IA0KPiBP
biAwMS8xNS8yMDE0IDEwOjQ3IFBNLCBNYXR0aGV3IEdhcnJldHQgd3JvdGU6DQo+ID4gT24gV2Vk
LCBKYW4gMTUsIDIwMTQgYXQgMTA6NDI6MzFQTSArMDgwMCwgTGFuIFRpYW55dSB3cm90ZToNCj4g
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9iYXR0ZXJ5LmMgYi9kcml2ZXJzL2FjcGkvYmF0
dGVyeS5jIGluZGV4DQo+ID4+IGZiZjFhY2UuLmU5OGZhODMgMTAwNjQ0DQo+ID4+IC0tLSBhL2Ry
aXZlcnMvYWNwaS9iYXR0ZXJ5LmMNCj4gPj4gKysrIGIvZHJpdmVycy9hY3BpL2JhdHRlcnkuYw0K
PiA+PiBAQCAtNzcwLDcgKzc3MCw3IEBAIHN0YXRpYyBpbnQgYWNwaV9iYXR0ZXJ5X2FkZChzdHJ1
Y3QgYWNwaV9kZXZpY2UNCj4gKmRldmljZSkNCj4gPj4gICAgICAgICAgZGV2aWNlLT5kcml2ZXJf
ZGF0YSA9IGJhdHRlcnk7DQo+ID4+ICAgICAgICAgIG11dGV4X2luaXQoJmJhdHRlcnktPmxvY2sp
Ow0KPiA+PiAgICAgICAgICBtdXRleF9pbml0KCZiYXR0ZXJ5LT5zeXNmc19sb2NrKTsNCj4gPj4g
LSAgICAgICBpZiAoYWNwaV9oYXNfbWV0aG9kKGJhdHRlcnktPmRldmljZS0+aGFuZGxlLCAiX0JJ
WCIpKQ0KPiA+PiArICAgICAgIGlmIChhY3BpX2V2YWx1YXRlX29iamVjdChkZXZpY2UtPmhhbmRs
ZSwgIl9CSVgiLCBOVUxMLA0KPiA+PiArICZidWZmZXIpOykNCj4gPj4gICAgICAgICAgICAgICAg
ICBzZXRfYml0KEFDUElfQkFUVEVSWV9YSU5GT19QUkVTRU5ULA0KPiA+PiAmYmF0dGVyeS0+Zmxh
Z3MpOw0KPiA+DQo+ID4gRG9lc24ndCBhY3BpX2V2YWx1YXRlX29iamVjdCgpIHJldHVybiAwIG9u
IHN1Y2Nlc3M/IEkgdGhpbms6DQo+ID4NCj4gPiBpZiAoQUNQSV9TVUNFU1MoYWNwaV9ldmFsdWF0
ZV9vYmplY3QoZGV2aWNlLT5oYW5kbGUsICJfQklYIiwgTlVMTCwNCj4gPiAmYnVmZmVyKSkNCj4g
Pg0KPiANCj4gWWVzLCBTb3JyeSBmb3Igb29wcy4NCj4gDQo+ID4gQnV0IG1heWJlIHdlIHNob3Vs
ZCBjaGVjayBmb3IgZXhpc3RlbmNlIGZpcnN0IGFuZCBnaXZlIGFuIEZXX0JVRw0KPiA+IG1lc3Nh
Z2UgdG8gaW5kaWNhdGUgYW4gaW52YWxpZCBfQklYPw0KPiANCj4gWWVzLCB0aGlzIGlzIGEgZ29v
ZCBpZGVhLg0KPiANCj4gQW5vdGhlciBwb2ludCwgdGhlIGFjcGlfZXZhbHVhdGVfb2JqZWN0IHNo
b3VsZCByZXR1cm4gZGlmZmVyZW50IGVycm9yIGNvZGUNCj4gZm9yIHRoZXNlIHR3byBjYXNlcyhu
byBfQklYIGFuZCB3cm9uZyBzaXplLikuIEkgd29uZGVyIHdoZXRoZXIgd2UgY2FuIHVzZQ0KPiB0
aGUgZXJyb3IgY29kZSB0byBkZXRlcm1pbmUgaXQgYmVsb25nIHdoaWNoIGNhc2U/DQo+ID4NCj4g
DQo+IA0KPiAtLQ0KPiBCZXN0IFJlZ2FyZHMNCj4gVGlhbnl1IExhbg0K
