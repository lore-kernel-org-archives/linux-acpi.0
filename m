From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v5 03/11] vga-switcheroo: make PCI dependency explicit
Date: Wed,  2 Jan 2019 18:10:30 +0000
Message-ID: <20190102181038.4418-4-okaya@kernel.org>
References: <20190102181038.4418-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190102181038.4418-1-okaya@kernel.org>
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
ZW5kZW5jeSBoYXMgbm90CmJlZW4gZXhwbGljaXRseSBjYWxsZWQgb3V0LgoKRml4ZXM6IDVkMzJh
NjY1NDFjNDYgKCJQQ0kvQUNQSTogQWxsb3cgQUNQSSB0byBiZSBidWlsdCB3aXRob3V0IENPTkZJ
R19QQ0kgc2V0IikKU2lnbmVkLW9mZi1ieTogU2luYW4gS2F5YSA8b2theWFAa2VybmVsLm9yZz4K
UmV2aWV3ZWQtYnk6IEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPgpBY2tlZC1ieTogRGFu
aWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4KLS0tCiBkcml2ZXJzL2dwdS92Z2Ev
S2NvbmZpZyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvdmdhL0tjb25maWcgYi9kcml2ZXJzL2dwdS92Z2EvS2NvbmZpZwppbmRl
eCBiNjc3ZTVkNTI0ZTYuLmQ1ZjFkOGUxYzZmOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvdmdh
L0tjb25maWcKKysrIGIvZHJpdmVycy9ncHUvdmdhL0tjb25maWcKQEAgLTIxLDYgKzIxLDcgQEAg
Y29uZmlnIFZHQV9TV0lUQ0hFUk9PCiAJYm9vbCAiTGFwdG9wIEh5YnJpZCBHcmFwaGljcyAtIEdQ
VSBzd2l0Y2hpbmcgc3VwcG9ydCIKIAlkZXBlbmRzIG9uIFg4NgogCWRlcGVuZHMgb24gQUNQSQor
CWRlcGVuZHMgb24gUENJCiAJc2VsZWN0IFZHQV9BUkIKIAloZWxwCiAJICBNYW55IGxhcHRvcHMg
cmVsZWFzZWQgaW4gMjAwOC85LzEwIGhhdmUgdHdvIEdQVXMgd2l0aCBhIG11bHRpcGxleGVyCi0t
IAoyLjE5LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
