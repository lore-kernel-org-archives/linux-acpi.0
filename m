From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 3/3] drm/i915/intel_dsi_vbt: Add support for
 PMIC mipi sequences
Date: Thu,  6 Dec 2018 14:47:05 +0100
Message-ID: <20181206134705.18554-3-hdegoede@redhat.com>
References: <20181206134705.18554-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20181206134705.18554-1-hdegoede@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

QWRkIHN1cHBvcnQgZm9yIFBNSUMgbWlwaSBzZXF1ZW5jZXMgdXNpbmcgdGhlIG5ldwppbnRlbF9z
b2NfcG1pY19leGVjX21pcGlfcG1pY19zZXFfZWxlbWVudCBmdW5jdGlvbi4KClNpZ25lZC1vZmYt
Ynk6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2k5MTUvaW50ZWxfZHNpX3ZidC5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RzaV92
YnQuYyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RzaV92YnQuYwppbmRleCBmMjdhZjQ3
YzZlNDkuLjZhMmVkMWNhNzJlMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50
ZWxfZHNpX3ZidC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RzaV92YnQuYwpA
QCAtMjksNiArMjksNyBAQAogI2luY2x1ZGUgPGRybS9kcm1fZWRpZC5oPgogI2luY2x1ZGUgPGRy
bS9pOTE1X2RybS5oPgogI2luY2x1ZGUgPGxpbnV4L2dwaW8vY29uc3VtZXIuaD4KKyNpbmNsdWRl
IDxsaW51eC9tZmQvaW50ZWxfc29jX3BtaWMuaD4KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CiAj
aW5jbHVkZSA8dmlkZW8vbWlwaV9kaXNwbGF5Lmg+CiAjaW5jbHVkZSA8YXNtL2ludGVsLW1pZC5o
PgpAQCAtMzcxLDcgKzM3MiwxMSBAQCBzdGF0aWMgY29uc3QgdTggKm1pcGlfZXhlY19zcGkoc3Ry
dWN0IGludGVsX2RzaSAqaW50ZWxfZHNpLCBjb25zdCB1OCAqZGF0YSkKIAogc3RhdGljIGNvbnN0
IHU4ICptaXBpX2V4ZWNfcG1pYyhzdHJ1Y3QgaW50ZWxfZHNpICppbnRlbF9kc2ksIGNvbnN0IHU4
ICpkYXRhKQogeworI2lmZGVmIENPTkZJR19QTUlDX09QUkVHSU9OCisJaW50ZWxfc29jX3BtaWNf
ZXhlY19taXBpX3BtaWNfc2VxX2VsZW1lbnQoZGF0YSk7CisjZWxzZQogCURSTV9ERUJVR19LTVMo
IlNraXBwaW5nIFBNSUMgZWxlbWVudCBleGVjdXRpb25cbiIpOworI2VuZGlmCiAKIAlyZXR1cm4g
ZGF0YSArIDE1OwogfQotLSAKMi4xOS4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9pbnRlbC1nZngK
