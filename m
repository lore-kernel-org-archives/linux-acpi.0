From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 3/3] drm/i915/intel_dsi_vbt: Add support for PMIC mipi
 sequences
Date: Wed, 12 Dec 2018 15:02:59 +0100
Message-ID: <6f6b5840-f460-531a-ab01-99156ab18036@redhat.com>
References: <20181206134705.18554-1-hdegoede@redhat.com>
 <20181206134705.18554-3-hdegoede@redhat.com>
 <20181207171728.GZ9144@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181207171728.GZ9144@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

SGksCgpPbiAwNy0xMi0xOCAxODoxNywgVmlsbGUgU3lyasOkbMOkIHdyb3RlOgo+IE9uIFRodSwg
RGVjIDA2LCAyMDE4IGF0IDAyOjQ3OjA1UE0gKzAxMDAsIEhhbnMgZGUgR29lZGUgd3JvdGU6Cj4+
IEFkZCBzdXBwb3J0IGZvciBQTUlDIG1pcGkgc2VxdWVuY2VzIHVzaW5nIHRoZSBuZXcKPj4gaW50
ZWxfc29jX3BtaWNfZXhlY19taXBpX3BtaWNfc2VxX2VsZW1lbnQgZnVuY3Rpb24uCj4gCj4gUGxl
YXNlIGRvY3VtZW50IHNvbWV3aGVyZSB3aGljaCBtYWNoaW5lcyB5b3UndmUgZm91bmQgdG8gbmVl
ZAo+IHRoaXMgKGNvbW1pdCBtc2cgc2hvdWxkIGJlIHN1ZmZpY2llbnQgSSBzdXBwb3NlKS4gQ2Fu
IG1ha2UgaXQKPiBtdWNoIGVhc2llciB0byByZXNwb25kIHRvIGJ1ZyByZXBvcnRzIGxpa2UgIm15
IG1hY2hpbmUgWCB3aXRoCj4gRFNJIGRvZXNuJ3Qgd29yayIuCgpPaywgSSd2ZSBhZGRlZCB0aGlz
IGluZm8gdG8gdGhlIGNvbW1pdCBtZXNzYWdlIGZvciB2MyBvZiB0aGUKcGF0Y2gtc2V0LgoKUmVn
YXJkcywKCkhhbnMKCgo+IAo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVn
b2VkZUByZWRoYXQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9k
c2lfdmJ0LmMgfCA1ICsrKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+
Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfZHNpX3ZidC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfZHNpX3ZidC5jCj4+IGluZGV4IGYyN2FmNDdjNmU0
OS4uNmEyZWQxY2E3MmUwIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRl
bF9kc2lfdmJ0LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfZHNpX3ZidC5j
Cj4+IEBAIC0yOSw2ICsyOSw3IEBACj4+ICAgI2luY2x1ZGUgPGRybS9kcm1fZWRpZC5oPgo+PiAg
ICNpbmNsdWRlIDxkcm0vaTkxNV9kcm0uaD4KPj4gICAjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25z
dW1lci5oPgo+PiArI2luY2x1ZGUgPGxpbnV4L21mZC9pbnRlbF9zb2NfcG1pYy5oPgo+PiAgICNp
bmNsdWRlIDxsaW51eC9zbGFiLmg+Cj4+ICAgI2luY2x1ZGUgPHZpZGVvL21pcGlfZGlzcGxheS5o
Pgo+PiAgICNpbmNsdWRlIDxhc20vaW50ZWwtbWlkLmg+Cj4+IEBAIC0zNzEsNyArMzcyLDExIEBA
IHN0YXRpYyBjb25zdCB1OCAqbWlwaV9leGVjX3NwaShzdHJ1Y3QgaW50ZWxfZHNpICppbnRlbF9k
c2ksIGNvbnN0IHU4ICpkYXRhKQo+PiAgIAo+PiAgIHN0YXRpYyBjb25zdCB1OCAqbWlwaV9leGVj
X3BtaWMoc3RydWN0IGludGVsX2RzaSAqaW50ZWxfZHNpLCBjb25zdCB1OCAqZGF0YSkKPj4gICB7
Cj4+ICsjaWZkZWYgQ09ORklHX1BNSUNfT1BSRUdJT04KPj4gKwlpbnRlbF9zb2NfcG1pY19leGVj
X21pcGlfcG1pY19zZXFfZWxlbWVudChkYXRhKTsKPj4gKyNlbHNlCj4+ICAgCURSTV9ERUJVR19L
TVMoIlNraXBwaW5nIFBNSUMgZWxlbWVudCBleGVjdXRpb25cbiIpOwo+PiArI2VuZGlmCj4+ICAg
Cj4+ICAgCXJldHVybiBkYXRhICsgMTU7Cj4+ICAgfQo+PiAtLSAKPj4gMi4xOS4yCj4gCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
