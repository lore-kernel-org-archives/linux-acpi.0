From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v4 09/22] drm: Probe panels on demand
Date: Mon,  7 Sep 2015 14:23:34 +0200
Message-ID: <1441628627-5143-10-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

V2hlbiBsb29raW5nIHVwIGEgcGFuZWwgdGhyb3VnaCBpdHMgT0Ygbm9kZSwgcHJvYmUgaXQgaWYg
aXQgaGFzbid0CmFscmVhZHkuCgpUaGUgZ29hbCBpcyB0byByZWR1Y2UgZGVmZXJyZWQgcHJvYmVz
IHRvIGEgbWluaW11bSwgYXMgaXQgbWFrZXMgaXQgdmVyeQpjdW1iZXJzb21lIHRvIGZpbmQgb3V0
IHdoeSBhIGRldmljZSBmYWlsZWQgdG8gcHJvYmUsIGFuZCBjYW4gaW50cm9kdWNlCnZlcnkgYmln
IGRlbGF5cyBpbiB3aGVuIGEgY3JpdGljYWwgZGV2aWNlIGlzIHByb2JlZC4KClNpZ25lZC1vZmYt
Ynk6IFRvbWV1IFZpem9zbyA8dG9tZXUudml6b3NvQGNvbGxhYm9yYS5jb20+Ci0tLQoKQ2hhbmdl
cyBpbiB2NDogTm9uZQpDaGFuZ2VzIGluIHYzOiBOb25lCkNoYW5nZXMgaW4gdjI6IE5vbmUKCiBk
cml2ZXJzL2dwdS9kcm0vZHJtX3BhbmVsLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fcGFuZWwuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9kcm1fcGFuZWwuYwppbmRleCAyZWY5ODhlMDM3YjcuLmFkNzlhN2I5Yzc0
ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9wYW5lbC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9kcm1fcGFuZWwuYwpAQCAtMjMsNiArMjMsNyBAQAogCiAjaW5jbHVkZSA8bGludXgv
ZXJyLmg+CiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5jbHVkZSA8bGludXgvb2ZfZGV2
aWNlLmg+CiAKICNpbmNsdWRlIDxkcm0vZHJtX2NydGMuaD4KICNpbmNsdWRlIDxkcm0vZHJtX3Bh
bmVsLmg+CkBAIC04MCw2ICs4MSw4IEBAIHN0cnVjdCBkcm1fcGFuZWwgKm9mX2RybV9maW5kX3Bh
bmVsKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApCiB7CiAJc3RydWN0IGRybV9wYW5lbCAqcGFuZWw7
CiAKKwlvZl9kZXZpY2VfcHJvYmUobnApOworCiAJbXV0ZXhfbG9jaygmcGFuZWxfbG9jayk7CiAK
IAlsaXN0X2Zvcl9lYWNoX2VudHJ5KHBhbmVsLCAmcGFuZWxfbGlzdCwgbGlzdCkgewotLSAKMi40
LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
