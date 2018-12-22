From: Sinan Kaya <Okaya@kernel.org>
Subject: Re: [PATCH v2 03/11] vga-switcheroo: make PCI dependency explicit
Date: Sun, 23 Dec 2018 02:00:15 +0300
Message-ID: <CAK9iUCNkQR=bUhBPYp_3kr6fo7Y0Jtko=BSjU4QozuOs9mA+kQ@mail.gmail.com>
References: <20181222090720.19234-1-okaya@kernel.org>
 <20181222090720.19234-4-okaya@kernel.org>
 <20181222164013.2l7etklpxjrrobnm@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181222164013.2l7etklpxjrrobnm@wunner.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
List-Id: linux-acpi@vger.kernel.org

T24gU2F0LCBEZWMgMjIsIDIwMTggYXQgNzo0MCBQTSBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5l
ci5kZT4gd3JvdGU6Cj4KPiBPbiBTYXQsIERlYyAyMiwgMjAxOCBhdCAwOTowNzoxMkFNICswMDAw
LCBTaW5hbiBLYXlhIHdyb3RlOgo+ID4gVGhpcyBkcml2ZXIgZGVwZW5kcyBvbiB0aGUgUENJIGlu
ZnJhc3RydWN0dXJlIGJ1dCB0aGUgZGVwZW5kZW5jeSBoYXMgbm90Cj4gPiBiZWVuIGV4cGxpY2l0
bHkgY2FsbGVkIG91dC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTaW5hbiBLYXlhIDxva2F5YUBr
ZXJuZWwub3JnPgo+ID4gUmV2aWV3ZWQtYnk6IEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRl
Pgo+Cj4gVGhpcyBzZXJpZXMgZG9lc24ndCBoYXZlIGEgY292ZXIgbGV0dGVyIHNvIGl0J3MgdW5j
bGVhciB0byBtZSB0aHJvdWdoCj4gd2hpY2ggdHJlZSBpdCdzIHN1cHBvc2VkIHRvIGdvIGluPyAg
RWFjaCBwYXRjaCB0aHJvdWdoIHRoZSBpbmRpdmlkdWFsCj4gc3Vic3lzdGVtIHRyZWUgb3IgYWxs
IHRocm91Z2ggdGhlIHNhbWUgdHJlZT8gIElmIHRoZSBmb3JtZXIgSSBndWVzcyBJCj4gY291bGQg
cHVzaCB0aGlzIHRvIGRybS1taXNjLi4uCj4KCkZlZWwgZnJlZSB0byBhcHBseSBpbmRpdmlkdWFs
IHBhdGNoZXMgaW5kZXBlbmRlbnRseS4gTGV0IG1lIGtub3cgd2hpY2gKb25lIHlvdSBhcHBsaWVk
IHNvIHRoYXQgSSBjYW4gZHJvcCB0aGVtIG9uIHRoZSBuZXh0IHJldi4KCj4gVGhhbmtzLAo+Cj4g
THVrYXMKPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9ncHUvdmdhL0tjb25maWcgfCAxICsKPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvdmdhL0tjb25maWcgYi9kcml2ZXJzL2dwdS92Z2EvS2NvbmZpZwo+ID4gaW5kZXggYjY3
N2U1ZDUyNGU2Li5kNWYxZDhlMWM2ZjggMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS92Z2Ev
S2NvbmZpZwo+ID4gKysrIGIvZHJpdmVycy9ncHUvdmdhL0tjb25maWcKPiA+IEBAIC0yMSw2ICsy
MSw3IEBAIGNvbmZpZyBWR0FfU1dJVENIRVJPTwo+ID4gICAgICAgYm9vbCAiTGFwdG9wIEh5YnJp
ZCBHcmFwaGljcyAtIEdQVSBzd2l0Y2hpbmcgc3VwcG9ydCIKPiA+ICAgICAgIGRlcGVuZHMgb24g
WDg2Cj4gPiAgICAgICBkZXBlbmRzIG9uIEFDUEkKPiA+ICsgICAgIGRlcGVuZHMgb24gUENJCj4g
PiAgICAgICBzZWxlY3QgVkdBX0FSQgo+ID4gICAgICAgaGVscAo+ID4gICAgICAgICBNYW55IGxh
cHRvcHMgcmVsZWFzZWQgaW4gMjAwOC85LzEwIGhhdmUgdHdvIEdQVXMgd2l0aCBhIG11bHRpcGxl
eGVyCj4gPiAtLQo+ID4gMi4xOS4wCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbAo=
