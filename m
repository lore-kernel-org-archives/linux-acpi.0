From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v1 03/11] vga-switcheroo: make PCI dependency explicit
Date: Sat, 22 Dec 2018 00:14:44 +0000
Message-ID: <20181222001452.7474-4-okaya@kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181222001452.7474-1-okaya@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-next@vger.kernel.org
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>, Sinan Kaya <okaya@kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, linux-acpi@vger.kernel.org, Sean Paul <sean@poorly.run>
List-Id: linux-acpi@vger.kernel.org

VGhpcyBkcml2ZXIgZGVwZW5kcyBvbiB0aGUgUENJIGluZnJhc3RydWN0dXJlIGJ1dCB0aGUgZGVw
ZW5kZW5jeSBoYXMgbm90CmJlZW4gZXhwbGljaXRseSBjYWxsZWQgb3V0LgoKU2lnbmVkLW9mZi1i
eTogU2luYW4gS2F5YSA8b2theWFAa2VybmVsLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS92Z2EvS2Nv
bmZpZyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvdmdhL0tjb25maWcgYi9kcml2ZXJzL2dwdS92Z2EvS2NvbmZpZwppbmRleCBi
Njc3ZTVkNTI0ZTYuLmQ1ZjFkOGUxYzZmOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvdmdhL0tj
b25maWcKKysrIGIvZHJpdmVycy9ncHUvdmdhL0tjb25maWcKQEAgLTIxLDYgKzIxLDcgQEAgY29u
ZmlnIFZHQV9TV0lUQ0hFUk9PCiAJYm9vbCAiTGFwdG9wIEh5YnJpZCBHcmFwaGljcyAtIEdQVSBz
d2l0Y2hpbmcgc3VwcG9ydCIKIAlkZXBlbmRzIG9uIFg4NgogCWRlcGVuZHMgb24gQUNQSQorCWRl
cGVuZHMgb24gUENJCiAJc2VsZWN0IFZHQV9BUkIKIAloZWxwCiAJICBNYW55IGxhcHRvcHMgcmVs
ZWFzZWQgaW4gMjAwOC85LzEwIGhhdmUgdHdvIEdQVXMgd2l0aCBhIG11bHRpcGxleGVyCi0tIAoy
LjE5LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
