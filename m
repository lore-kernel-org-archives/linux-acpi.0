From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 11/22] drm: Probe panels on demand
Date: Tue, 28 Jul 2015 15:19:42 +0200
Message-ID: <1438089593-7696-12-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
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
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

V2hlbiBsb29raW5nIHVwIGEgcGFuZWwgdGhyb3VnaCBpdHMgZmlybXdhcmUgbm9kZSwgcHJvYmUg
aXQgaWYgaXQgaGFzbid0CmFscmVhZHkuCgpUaGUgZ29hbCBpcyB0byByZWR1Y2UgZGVmZXJyZWQg
cHJvYmVzIHRvIGEgbWluaW11bSwgYXMgaXQgbWFrZXMgaXQgdmVyeQpjdW1iZXJzb21lIHRvIGZp
bmQgb3V0IHdoeSBhIGRldmljZSBmYWlsZWQgdG8gcHJvYmUsIGFuZCBjYW4gaW50cm9kdWNlCnZl
cnkgYmlnIGRlbGF5cyBpbiB3aGVuIGEgY3JpdGljYWwgZGV2aWNlIGlzIHByb2JlZC4KClNpZ25l
ZC1vZmYtYnk6IFRvbWV1IFZpem9zbyA8dG9tZXUudml6b3NvQGNvbGxhYm9yYS5jb20+Ci0tLQoK
Q2hhbmdlcyBpbiB2MjogTm9uZQoKIGRyaXZlcnMvZ3B1L2RybS9kcm1fcGFuZWwuYyB8IDIgKysK
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vZHJtX3BhbmVsLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX3BhbmVsLmMKaW5kZXggMmVm
OTg4ZTAzN2I3Li4zNzRhOTY0YzM4NDIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1f
cGFuZWwuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX3BhbmVsLmMKQEAgLTgwLDYgKzgwLDgg
QEAgc3RydWN0IGRybV9wYW5lbCAqb2ZfZHJtX2ZpbmRfcGFuZWwoc3RydWN0IGRldmljZV9ub2Rl
ICpucCkKIHsKIAlzdHJ1Y3QgZHJtX3BhbmVsICpwYW5lbDsKIAorCWZ3bm9kZV9lbnN1cmVfZGV2
aWNlKCZucC0+Zndub2RlKTsKKwogCW11dGV4X2xvY2soJnBhbmVsX2xvY2spOwogCiAJbGlzdF9m
b3JfZWFjaF9lbnRyeShwYW5lbCwgJnBhbmVsX2xpc3QsIGxpc3QpIHsKLS0gCjIuNC4zCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFp
bGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
