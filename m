From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 3/3] drm/i915/intel_dsi_vbt: Add support
 for PMIC mipi sequences
Date: Fri, 7 Dec 2018 19:17:28 +0200
Message-ID: <20181207171728.GZ9144@intel.com>
References: <20181206134705.18554-1-hdegoede@redhat.com>
 <20181206134705.18554-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20181206134705.18554-3-hdegoede@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gVGh1LCBEZWMgMDYsIDIwMTggYXQgMDI6NDc6MDVQTSArMDEwMCwgSGFucyBkZSBHb2VkZSB3
cm90ZToKPiBBZGQgc3VwcG9ydCBmb3IgUE1JQyBtaXBpIHNlcXVlbmNlcyB1c2luZyB0aGUgbmV3
Cj4gaW50ZWxfc29jX3BtaWNfZXhlY19taXBpX3BtaWNfc2VxX2VsZW1lbnQgZnVuY3Rpb24uCgpQ
bGVhc2UgZG9jdW1lbnQgc29tZXdoZXJlIHdoaWNoIG1hY2hpbmVzIHlvdSd2ZSBmb3VuZCB0byBu
ZWVkCnRoaXMgKGNvbW1pdCBtc2cgc2hvdWxkIGJlIHN1ZmZpY2llbnQgSSBzdXBwb3NlKS4gQ2Fu
IG1ha2UgaXQKbXVjaCBlYXNpZXIgdG8gcmVzcG9uZCB0byBidWcgcmVwb3J0cyBsaWtlICJteSBt
YWNoaW5lIFggd2l0aApEU0kgZG9lc24ndCB3b3JrIi4KCj4gCj4gU2lnbmVkLW9mZi1ieTogSGFu
cyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJt
L2k5MTUvaW50ZWxfZHNpX3ZidC5jIHwgNSArKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2Rz
aV92YnQuYyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RzaV92YnQuYwo+IGluZGV4IGYy
N2FmNDdjNmU0OS4uNmEyZWQxY2E3MmUwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9p
OTE1L2ludGVsX2RzaV92YnQuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2Rz
aV92YnQuYwo+IEBAIC0yOSw2ICsyOSw3IEBACj4gICNpbmNsdWRlIDxkcm0vZHJtX2VkaWQuaD4K
PiAgI2luY2x1ZGUgPGRybS9pOTE1X2RybS5oPgo+ICAjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25z
dW1lci5oPgo+ICsjaW5jbHVkZSA8bGludXgvbWZkL2ludGVsX3NvY19wbWljLmg+Cj4gICNpbmNs
dWRlIDxsaW51eC9zbGFiLmg+Cj4gICNpbmNsdWRlIDx2aWRlby9taXBpX2Rpc3BsYXkuaD4KPiAg
I2luY2x1ZGUgPGFzbS9pbnRlbC1taWQuaD4KPiBAQCAtMzcxLDcgKzM3MiwxMSBAQCBzdGF0aWMg
Y29uc3QgdTggKm1pcGlfZXhlY19zcGkoc3RydWN0IGludGVsX2RzaSAqaW50ZWxfZHNpLCBjb25z
dCB1OCAqZGF0YSkKPiAgCj4gIHN0YXRpYyBjb25zdCB1OCAqbWlwaV9leGVjX3BtaWMoc3RydWN0
IGludGVsX2RzaSAqaW50ZWxfZHNpLCBjb25zdCB1OCAqZGF0YSkKPiAgewo+ICsjaWZkZWYgQ09O
RklHX1BNSUNfT1BSRUdJT04KPiArCWludGVsX3NvY19wbWljX2V4ZWNfbWlwaV9wbWljX3NlcV9l
bGVtZW50KGRhdGEpOwo+ICsjZWxzZQo+ICAJRFJNX0RFQlVHX0tNUygiU2tpcHBpbmcgUE1JQyBl
bGVtZW50IGV4ZWN1dGlvblxuIik7Cj4gKyNlbmRpZgo+ICAKPiAgCXJldHVybiBkYXRhICsgMTU7
Cj4gIH0KPiAtLSAKPiAyLjE5LjIKCi0tIApWaWxsZSBTeXJqw6Rsw6QKSW50ZWwKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcg
bGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
