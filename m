From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v2 03/11] vga-switcheroo: make PCI dependency explicit
Date: Sat, 22 Dec 2018 09:07:12 +0000
Message-ID: <20181222090720.19234-4-okaya@kernel.org>
References: <20181222090720.19234-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181222090720.19234-1-okaya@kernel.org>
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
eTogU2luYW4gS2F5YSA8b2theWFAa2VybmVsLm9yZz4KUmV2aWV3ZWQtYnk6IEx1a2FzIFd1bm5l
ciA8bHVrYXNAd3VubmVyLmRlPgotLS0KIGRyaXZlcnMvZ3B1L3ZnYS9LY29uZmlnIHwgMSArCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS92
Z2EvS2NvbmZpZyBiL2RyaXZlcnMvZ3B1L3ZnYS9LY29uZmlnCmluZGV4IGI2NzdlNWQ1MjRlNi4u
ZDVmMWQ4ZTFjNmY4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS92Z2EvS2NvbmZpZworKysgYi9k
cml2ZXJzL2dwdS92Z2EvS2NvbmZpZwpAQCAtMjEsNiArMjEsNyBAQCBjb25maWcgVkdBX1NXSVRD
SEVST08KIAlib29sICJMYXB0b3AgSHlicmlkIEdyYXBoaWNzIC0gR1BVIHN3aXRjaGluZyBzdXBw
b3J0IgogCWRlcGVuZHMgb24gWDg2CiAJZGVwZW5kcyBvbiBBQ1BJCisJZGVwZW5kcyBvbiBQQ0kK
IAlzZWxlY3QgVkdBX0FSQgogCWhlbHAKIAkgIE1hbnkgbGFwdG9wcyByZWxlYXNlZCBpbiAyMDA4
LzkvMTAgaGF2ZSB0d28gR1BVcyB3aXRoIGEgbXVsdGlwbGV4ZXIKLS0gCjIuMTkuMAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
