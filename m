From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4 03/11] vga-switcheroo: make PCI dependency explicit
Date: Mon, 7 Jan 2019 11:34:48 +0100
Message-ID: <20190107103448.GG21184@phenom.ffwll.local>
References: <20181230195612.6657-1-okaya@kernel.org>
 <20181230195612.6657-4-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20181230195612.6657-4-okaya@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sinan Kaya <okaya@kernel.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Sean Paul <sean@poorly.run>
List-Id: linux-acpi@vger.kernel.org

T24gU3VuLCBEZWMgMzAsIDIwMTggYXQgMDc6NTY6MDRQTSArMDAwMCwgU2luYW4gS2F5YSB3cm90
ZToKPiBUaGlzIGRyaXZlciBkZXBlbmRzIG9uIHRoZSBQQ0kgaW5mcmFzdHJ1Y3R1cmUgYnV0IHRo
ZSBkZXBlbmRlbmN5IGhhcyBub3QKPiBiZWVuIGV4cGxpY2l0bHkgY2FsbGVkIG91dC4KPiAKPiBG
aXhlczogNWQzMmE2NjU0MWM0NiAoIlBDSS9BQ1BJOiBBbGxvdyBBQ1BJIHRvIGJlIGJ1aWx0IHdp
dGhvdXQgQ09ORklHX1BDSSBzZXQiKQo+IFNpZ25lZC1vZmYtYnk6IFNpbmFuIEtheWEgPG9rYXlh
QGtlcm5lbC5vcmc+Cj4gUmV2aWV3ZWQtYnk6IEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRl
Pgo+IEFja2VkLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVyQGZmd2xsLmNoPgoKSSdt
IGFzc3VtaW5nIHRoaXMgZ29lcyBpbiB0aHJvdWdoIHRoZSBhY3BpIHRyZWUsIGNvcnJlY3Q/Ci1E
YW5pZWwKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L3ZnYS9LY29uZmlnIHwgMSArCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS92Z2Ev
S2NvbmZpZyBiL2RyaXZlcnMvZ3B1L3ZnYS9LY29uZmlnCj4gaW5kZXggYjY3N2U1ZDUyNGU2Li5k
NWYxZDhlMWM2ZjggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvdmdhL0tjb25maWcKPiArKysg
Yi9kcml2ZXJzL2dwdS92Z2EvS2NvbmZpZwo+IEBAIC0yMSw2ICsyMSw3IEBAIGNvbmZpZyBWR0Ff
U1dJVENIRVJPTwo+ICAJYm9vbCAiTGFwdG9wIEh5YnJpZCBHcmFwaGljcyAtIEdQVSBzd2l0Y2hp
bmcgc3VwcG9ydCIKPiAgCWRlcGVuZHMgb24gWDg2Cj4gIAlkZXBlbmRzIG9uIEFDUEkKPiArCWRl
cGVuZHMgb24gUENJCj4gIAlzZWxlY3QgVkdBX0FSQgo+ICAJaGVscAo+ICAJICBNYW55IGxhcHRv
cHMgcmVsZWFzZWQgaW4gMjAwOC85LzEwIGhhdmUgdHdvIEdQVXMgd2l0aCBhIG11bHRpcGxleGVy
Cj4gLS0gCj4gMi4xOS4wCj4gCgotLSAKRGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVlciwg
SW50ZWwgQ29ycG9yYXRpb24KaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
