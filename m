From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/3] ACPI-PMIC + i915: Add support for PMIC MIPI sequences
Date: Wed,  5 Dec 2018 22:03:07 +0100
Message-ID: <20181205210311.16865-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

SGkgQWxsLAoKVGhpcyBzZXJpZXMgaXMgdGhlIHJlc3VsdCBvZiBtZSBkZWJ1Z2dpbmcgYW5kIGZp
eGluZyB0aGUgTENEIHBhbmVsIG5vdApsaWdodGluZyB1cCBvbiBzb21lIENIVCBkZXZpY2VzIHdo
ZW4gdGhleSBhcmUgYm9vdGVkIHdpdGggYW4gZXh0ZXJuYWwKbW9uaXRvciBjb25uZWN0ZWQgYW5k
IHRoZSBHT1Agb25seSBpbml0aWFsaXplcyB0aGUgZXh0ZXJuYWwgbW9uaXRvciwKbGVhdmluZyB0
aGUgTENEIHVuaW5pdGlhbGl6ZWQuCgpUaGlzIGlzIGNhdXNlZCBieSB0aGUgbGFjayBvZiBzdXBw
b3J0IGZvciBleGVjdXRpbmcgUE1JQyBNSVBJIHNlcXVlbmNlcwppbiBkcml2ZXJzL2dwdS9kcm0v
aTkxNS9pbnRlbF9kc2lfdmJ0LmMuIFNwZWNpZmljYWxseSB0aGUgVkJUIG9uIHRoZXNlCmRldmlj
ZXMgdXNlcyBhIFBNSUMgTUlQSSBzZXF1ZW5jZSB0byB0b2dnbGUgYSBHUElPIG9uIHRoZSBQTUlD
LgoKQmVzaWRlcyBmaXhpbmcgdGhlIExDRCBwYW5lbCBub3Qgd29ya2luZyBhdCBhbGwgd2hlbiBh
biBleHRlcm5hbCBtb25pdG9yCmlzIHVzZWQsIHRoaXMgc2hvdWxkIGFsc28gc2F2ZSBzb21lIHBv
d2VyIHdoZW4gdGhlIHBhbmVsIGlzIG9mZi4KClRoaXMgc2VyaWVzIHRvdWNoZXMgc29tZSBmaWxl
cyB1bmRlciBkcml2ZXJzL2FjcGkvcG1pYyBhcyB3ZWxsIGFzIHNvbWUKaTkxNSBjb2RlLiBTaW5j
ZSB0aGUgY29kZSB1bmRlciBkcml2ZXJzL2FjcGkvcG1pYyBkb2VzIG5vdCBjaGFuZ2UgdGhhdApv
ZnRlbiwgSSBiZWxpZXZlIGl0IHdvdWxkIGJlIGJlc3QgdG8gbWVyZ2UgdGhpcyBlbnRpcmUgc2Vy
aWVzIHRocm91Z2gKaW50ZWwtZHJtLW5leHQtcXVldWVkLCB3aXRoIGFja3MgZnJvbSB0aGUgQUNQ
SSBtYWludGFpbmVycy4KClJlZ2FyZHMsCgpIYW5zCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcmktZGV2ZWwK
