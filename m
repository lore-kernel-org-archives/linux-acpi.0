From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 03/11] vga-switcheroo: make PCI dependency explicit
Date: Sat, 22 Dec 2018 17:40:13 +0100
Message-ID: <20181222164013.2l7etklpxjrrobnm@wunner.de>
References: <20181222090720.19234-1-okaya@kernel.org>
 <20181222090720.19234-4-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20181222090720.19234-4-okaya@kernel.org>
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
Cc: linux-acpi@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>, linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
List-Id: linux-acpi@vger.kernel.org

T24gU2F0LCBEZWMgMjIsIDIwMTggYXQgMDk6MDc6MTJBTSArMDAwMCwgU2luYW4gS2F5YSB3cm90
ZToKPiBUaGlzIGRyaXZlciBkZXBlbmRzIG9uIHRoZSBQQ0kgaW5mcmFzdHJ1Y3R1cmUgYnV0IHRo
ZSBkZXBlbmRlbmN5IGhhcyBub3QKPiBiZWVuIGV4cGxpY2l0bHkgY2FsbGVkIG91dC4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBTaW5hbiBLYXlhIDxva2F5YUBrZXJuZWwub3JnPgo+IFJldmlld2VkLWJ5
OiBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT4KClRoaXMgc2VyaWVzIGRvZXNuJ3QgaGF2
ZSBhIGNvdmVyIGxldHRlciBzbyBpdCdzIHVuY2xlYXIgdG8gbWUgdGhyb3VnaAp3aGljaCB0cmVl
IGl0J3Mgc3VwcG9zZWQgdG8gZ28gaW4/ICBFYWNoIHBhdGNoIHRocm91Z2ggdGhlIGluZGl2aWR1
YWwKc3Vic3lzdGVtIHRyZWUgb3IgYWxsIHRocm91Z2ggdGhlIHNhbWUgdHJlZT8gIElmIHRoZSBm
b3JtZXIgSSBndWVzcyBJCmNvdWxkIHB1c2ggdGhpcyB0byBkcm0tbWlzYy4uLgoKVGhhbmtzLAoK
THVrYXMKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L3ZnYS9LY29uZmlnIHwgMSArCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS92Z2Ev
S2NvbmZpZyBiL2RyaXZlcnMvZ3B1L3ZnYS9LY29uZmlnCj4gaW5kZXggYjY3N2U1ZDUyNGU2Li5k
NWYxZDhlMWM2ZjggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvdmdhL0tjb25maWcKPiArKysg
Yi9kcml2ZXJzL2dwdS92Z2EvS2NvbmZpZwo+IEBAIC0yMSw2ICsyMSw3IEBAIGNvbmZpZyBWR0Ff
U1dJVENIRVJPTwo+ICAJYm9vbCAiTGFwdG9wIEh5YnJpZCBHcmFwaGljcyAtIEdQVSBzd2l0Y2hp
bmcgc3VwcG9ydCIKPiAgCWRlcGVuZHMgb24gWDg2Cj4gIAlkZXBlbmRzIG9uIEFDUEkKPiArCWRl
cGVuZHMgb24gUENJCj4gIAlzZWxlY3QgVkdBX0FSQgo+ICAJaGVscAo+ICAJICBNYW55IGxhcHRv
cHMgcmVsZWFzZWQgaW4gMjAwOC85LzEwIGhhdmUgdHdvIEdQVXMgd2l0aCBhIG11bHRpcGxleGVy
Cj4gLS0gCj4gMi4xOS4wCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1k
ZXZlbAo=
