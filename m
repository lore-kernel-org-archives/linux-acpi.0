From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v2 03/11] vga-switcheroo: make PCI dependency explicit
Date: Mon, 24 Dec 2018 02:13:11 +0300
Message-ID: <7e3c5fa9-bd21-bb1f-f668-77d55a72d40a@kernel.org>
References: <20181222090720.19234-1-okaya@kernel.org>
 <20181222090720.19234-4-okaya@kernel.org>
 <20181222164013.2l7etklpxjrrobnm@wunner.de>
 <CAK9iUCNkQR=bUhBPYp_3kr6fo7Y0Jtko=BSjU4QozuOs9mA+kQ@mail.gmail.com>
 <20181223171501.4hwqu6wn4jzwrcmn@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181223171501.4hwqu6wn4jzwrcmn@wunner.de>
Content-Language: en-US
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

T24gMTIvMjMvMjAxOCA4OjE1IFBNLCBMdWthcyBXdW5uZXIgd3JvdGU6Cj4gT24gU3VuLCBEZWMg
MjMsIDIwMTggYXQgMDI6MDA6MTVBTSArMDMwMCwgU2luYW4gS2F5YSB3cm90ZToKPj4gT24gU2F0
LCBEZWMgMjIsIDIwMTggYXQgNzo0MCBQTSBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT4g
d3JvdGU6Cj4+PiBPbiBTYXQsIERlYyAyMiwgMjAxOCBhdCAwOTowNzoxMkFNICswMDAwLCBTaW5h
biBLYXlhIHdyb3RlOgo+Pj4+IFRoaXMgZHJpdmVyIGRlcGVuZHMgb24gdGhlIFBDSSBpbmZyYXN0
cnVjdHVyZSBidXQgdGhlIGRlcGVuZGVuY3kgaGFzIG5vdAo+Pj4+IGJlZW4gZXhwbGljaXRseSBj
YWxsZWQgb3V0Lgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogU2luYW4gS2F5YSA8b2theWFAa2Vy
bmVsLm9yZz4KPj4+PiBSZXZpZXdlZC1ieTogTHVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+
Cj4+Pgo+Pj4gVGhpcyBzZXJpZXMgZG9lc24ndCBoYXZlIGEgY292ZXIgbGV0dGVyIHNvIGl0J3Mg
dW5jbGVhciB0byBtZSB0aHJvdWdoCj4+PiB3aGljaCB0cmVlIGl0J3Mgc3VwcG9zZWQgdG8gZ28g
aW4/ICBFYWNoIHBhdGNoIHRocm91Z2ggdGhlIGluZGl2aWR1YWwKPj4+IHN1YnN5c3RlbSB0cmVl
IG9yIGFsbCB0aHJvdWdoIHRoZSBzYW1lIHRyZWU/ICBJZiB0aGUgZm9ybWVyIEkgZ3Vlc3MgSQo+
Pj4gY291bGQgcHVzaCB0aGlzIHRvIGRybS1taXNjLi4uCj4+Cj4+IEZlZWwgZnJlZSB0byBhcHBs
eSBpbmRpdmlkdWFsIHBhdGNoZXMgaW5kZXBlbmRlbnRseS4gTGV0IG1lIGtub3cgd2hpY2gKPj4g
b25lIHlvdSBhcHBsaWVkIHNvIHRoYXQgSSBjYW4gZHJvcCB0aGVtIG9uIHRoZSBuZXh0IHJldi4K
PiAKPiBJJ3ZlIHJlYWxpemVkIG9ubHkgbm93IHRoYXQgdGhpcyBwYXRjaCBmaXhlcyBmYWxsb3V0
IG9mIGNvbW1pdAo+IDVkMzJhNjY1NDFjNCAoIlBDSS9BQ1BJOiBBbGxvdyBBQ1BJIHRvIGJlIGJ1
aWx0IHdpdGhvdXQgQ09ORklHX1BDSSBzZXQiKQo+IHdoaWNoIGlzIHBhcnQgb2YgUmFmYWVsJ3Mg
YWNwaSBwdWxsIGZvciB2NC4yMS4KPiAKPiBVc3VhbGx5IHN1Y2ggZml4ZXMgZ28gdGhyb3VnaCB0
aGUgc2FtZSB0cmVlIGFzIHRoZSBvZmZlbmRpbmcgY29tbWl0LAo+IHNvIEknZCBleHBlY3QgUmFw
aGFlbCB0byBwaWNrIHVwIHRoZSB3aG9sZSBzZXJpZXMgYW5kIGZvcndhcmQgaXQgdG8KPiBMaW51
cyBpbiB0aGUgc2Vjb25kIGhhbGYgb2YgdGhlIG1lcmdlIHdpbmRvdy4gIEknbSBub3Qgc3VyZSBp
ZiB0aGF0J3MKPiBob3cgaXQnbGwgcGxheSBvdXQgdGhvdWdoIGdpdmVuIHRoZSBob2xpZGF5cy4K
CkknbGwgZG8gZm9sbG93LXVwIHdpdGggUmFmYWVsLiBBcG9sb2dpemUgZm9yIG5vdCBnaXZpbmcg
dGhlIGZ1bGwgc3RvcnkuClRyeWluZyB0byBnZXQgcGllY2VzIG91dCBpbiB0aGUgbWlkZGxlIG9m
IHZhY2F0aW9uIGFzIHRoZXJlIHdhcyBhIGJyZWFrYWdlLgpJIGRpZG4ndCBoYXZlIHRpbWUgdG8g
cG9saXNoLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
