From: "Verma, Vishal L" <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] acpi, nfit: fix the memory error check in nfit_handle_mce
Date: Fri, 21 Apr 2017 19:56:39 +0000
Message-ID: <1492804517.2738.25.camel@intel.com>
References: <20170420221818.23522-1-vishal.l.verma@intel.com>
 <CAPcyv4ijU2V-4WOPysL12ByOovAXDO=Mci1D4wNDFqxRjdvT2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CAPcyv4ijU2V-4WOPysL12ByOovAXDO=Mci1D4wNDFqxRjdvT2w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <4D5D01114A55264FB209E7DB283EFDA4-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "Williams, Dan J" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Luck,
 Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

T24gRnJpLCAyMDE3LTA0LTIxIGF0IDEyOjIxIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIFRodSwgQXByIDIwLCAyMDE3IGF0IDM6MTggUE0sIFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwu
dmVybWFAaW50ZWwuY28NCj4gbT4gd3JvdGU6DQo+ID4gVGhlIGNoZWNrIGZvciBhbiBNQ0UgYmVp
bmcgYSBtZW1vcnkgZXJyb3IgaW4gdGhlIE5GSVQgbWNlIGhhbmRsZXINCj4gPiB3YXMNCj4gPiBi
b2d1cy4gRml4IGl0IHRvIGNoZWNrIGZvciB0aGUgY29ycmVjdCBNQ0Egc3RhdHVzIGNvbXBvdW5k
IGVycm9yDQo+ID4gY29kZS4NCj4gPiANCj4gPiBSZXBvcnRlZC1ieTogVG9ueSBMdWNrIDx0b255
Lmx1Y2tAaW50ZWwuY29tPg0KPiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCj4g
PiAtLS0NCj4gPiDCoGRyaXZlcnMvYWNwaS9uZml0L21jZS5jIHwgMiArLQ0KPiA+IMKgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYWNwaS9uZml0L21jZS5jIGIvZHJpdmVycy9hY3BpL25maXQvbWNlLmMN
Cj4gPiBpbmRleCAzYmExYzM0Li4yM2UxMmEwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYWNw
aS9uZml0L21jZS5jDQo+ID4gKysrIGIvZHJpdmVycy9hY3BpL25maXQvbWNlLmMNCj4gPiBAQCAt
MjYsNyArMjYsNyBAQCBzdGF0aWMgaW50IG5maXRfaGFuZGxlX21jZShzdHJ1Y3Qgbm90aWZpZXJf
YmxvY2sNCj4gPiAqbmIsIHVuc2lnbmVkIGxvbmcgdmFsLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgbmZpdF9zcGEgKm5maXRfc3BhOw0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqAvKiBX
ZSBvbmx5IGNhcmUgYWJvdXQgbWVtb3J5IGVycm9ycyAqLw0KPiA+IC3CoMKgwqDCoMKgwqDCoGlm
ICghKG1jZS0+c3RhdHVzICYgTUNBQ09EKSkNCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIShtY2Ut
PnN0YXR1cyAmIDB4ZWY4MCkgPT0gQklUKDcpKQ0KPiANCj4gQ2FuIHdlIGdldCBhIGRlZmluZSBm
b3IgdGhpcywgb3IgYSBjb21tZW50IGV4cGxhaW5pbmcgYWxsIHRoZSBtYWdpYw0KPiB0aGF0J3Mg
aGFwcGVuaW5nIG9uIHRoYXQgb25lIGxpbmU/DQoNClllcyAtIGFsc28gbGlrZSBsa3AgcG9pbnRl
ZCBvdXQsIHRoZSBjaGVjayBpc24ndCBjb3JyZWN0IGF0IGFsbC4gTGV0IG1lDQpmaWd1cmUgb3V0
IHdoYXQgcmVhbGx5IG5lZWRzIHRvIGJlIGRvbmUsIGFuZCBJIHdpbGwgcmVzZW5kIHdpdGggYSBi
ZXR0ZXINCmNvbW1lbnQuIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5v
cmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udmRpbW0K
