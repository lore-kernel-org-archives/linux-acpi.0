From: "Kani, Toshimitsu" <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
Subject: Re: [PATCH] Add support of NVDIMM memory error notification in ACPI
 6.2
Date: Thu, 8 Jun 2017 17:38:21 +0000
Message-ID: <1496943475.9288.5.camel@hpe.com>
References: <20170607184947.18733-1-toshi.kani@hpe.com>
 <CAPcyv4i7bLU17QEmdUBQrtWP3AZxPRyKK0NN105XrTj8K3nAAQ@mail.gmail.com>
 <1496869051.9288.1.camel@hpe.com>
 <CAPcyv4hwhRc6+JW8m3zVn_tKz__wE9BHOfpjy69RS6OwiqV-PA@mail.gmail.com>
 <1496871186.9288.3.camel@hpe.com>
 <b91c4a7b-3e19-df5d-12e7-61cdf1bc2c84@hpe.com>
 <CAPcyv4hocL=1Mzqa+nJCdmRz7YgxUc3P1w-nn7F=uQG8wu94KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CAPcyv4hocL=1Mzqa+nJCdmRz7YgxUc3P1w-nn7F=uQG8wu94KA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <B947811C99E89B4B91EC94A67C8BBA90-mmYPd6ayCNGroOM5E8FhRbjFIynDaujOfM0AETQt39g@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Knippers, Linda" <linda.knippers-ZPxbGqLxI0U@public.gmane.org>
Cc: "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

T24gVGh1LCAyMDE3LTA2LTA4IGF0IDEwOjM0IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIFRodSwgSnVuIDgsIDIwMTcgYXQgMTA6MzAgQU0sIExpbmRhIEtuaXBwZXJzIDxsaW5kYS5r
bmlwcGVyc0BocGUuYw0KPiBvbT4gd3JvdGU6DQo+IFsuLl0NCj4gPiBXYXNuJ3QgRGFuIGNvbmNl
cm5lZCBhYm91dCBob3cgdGhlIE9TIGNhbiBrbm93IHdoZXRoZXIgdGhlIEZXDQo+ID4gc3VwcG9y
dHMgdGhhdCBiaXQgaW4gdGhlIFN0YXJ0IEFSUz8NCj4gPiANCj4gPiBUaGUgUXVlcnkgQVJTIENh
cGFiaWxpdGllcyBEU00gaGFzIGEgYml0IHRoYXQgdGVsbHMgdGhlIE9TIHdoZXRoZXINCj4gPiB0
aGUgcGxhdGZvcm0gc3VwcG9ydHMgdGhlIG5vdGlmaWNhdGlvbiBhbmQgdGhlIHBvaW50IG9mIHRo
ZQ0KPiA+IG5vdGlmaWNhdGlvbiB3YXMgdG8gdGVsbCB0aGUgT1MgaXQgY291bGQgZG8gYSBTdGFy
dCBBUlMgd2l0aCBiaXQgMQ0KPiA+IHNldC7CoMKgT2YgY291cnNlLCBpZiB5b3UgZ2V0IHRoZSBu
b3RpZmljYXRpb24gdGhlbiB0aGF0IG1lYW5zIHRoZQ0KPiA+IHBsYXRmb3JtIGhhcyB0aGUgY2Fw
YWJpbGl0eSB0byBkZWxpdmVyIGl0LCBidXQgaXQgbWlnaHQgbm90IGh1cnQgdG8NCj4gPiBjaGVj
ayB0aGUgZmxhZyBmcm9tIHRoZSBRdWVyeSBDYXBhYmlsaXRpZXMgYml0Lg0KPiANCj4gR29vZCBw
b2ludCwgeWVzLCBJIHRoaW5rIGl0IGlzIHNhZmUgdG8gYXNzdW1lIHRoYXQgYSBCSU9TIHRoYXQg
Y2xhaW1zDQo+IHRvIHN1cHBvcnQgdW4tY29ycmVjdGFibGUgZXJyb3Igbm90aWZpY2F0aW9uIGFs
c28gc3VwcG9ydHMgdGhpcyBTdGFydA0KPiBBUlMgZmxhZy4NCg0KWWVzLCBBQ1BJIDYuMiwgc2Vj
dGlvbiA5LjIwLjcuMiwgZGVmaW5lcyB0aGF0Og0KDQrCoMKgwqDCoMKgwqBVcG9uIHJlY2Vpdmlu
ZyB0aGUgbm90aWZpY2F0aW9uLCB0aGUgT1NQTSBtYXkgZGVjaWRlIHRvIGlzc3VlDQrCoMKgwqDC
oMKgwqBhIFN0YXJ0IEFSUyB3aXRoIEZsYWdzIEJpdCBbMV0gc2V0IHRvIHByZXBhcmUgZm9yIHRo
ZSByZXRyaWV2YWwNCsKgwqDCoMKgwqDCoG9mIGV4aXN0aW5nIHJlY29yZHMgYW5kIGlzc3VlIHRo
ZSBRdWVyeSBBUlMgU3RhdHVzIGZ1bmN0aW9uIHRvDQrCoMKgwqDCoMKgwqByZXRyaWV2ZSB0aGUg
cmVjb3Jkcy4NCg0KU28swqBJIGJlbGlldmUgaXQgaXMgc2FmZSB0byBhc3N1bWUgdGhhdCBCSU9T
IHN1cHBvcnRpbmcgMHg4MSBhbHNvDQpzdXBwb3J0cyBmbGFncyBCaWcgWzFdLiAgU29ycnksIHRo
aXMgaXMgd2hhdCBJIHNob3VsZCBoYXZlIHNhaWQgaW4gbXkNCnByZXZpb3VzIGVtYWlsLi4uDQoN
ClRoYW5rcywNCi1Ub3NoaQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5v
cmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udmRpbW0K
