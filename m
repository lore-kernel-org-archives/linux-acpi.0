From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 3.11-rc2 (acpi backlight, revert)
Date: Mon, 05 Aug 2013 00:15:03 +0200
Message-ID: <2172124.xGLVSKhdfZ@vostro.rjw.lan>
References: <CA+55aFy330bSRjK5HT1n0wXioPykL3RquHXyBPjm5GpTz_Y=DQ@mail.gmail.com>
	<1854576.vakuIzNrby@vostro.rjw.lan> <1514588.PZegN9olxR@merkaba>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1514588.PZegN9olxR@merkaba>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Martin Steigerwald <Martin@lichtvoll.de>
Cc: Aaron Lu <aaron.lu@intel.com>, James Hogan <james@albanarts.com>, Joerg Platte <jplatte@naasa.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>, Matthew Garrett <matthew.garrett@nebula.com>, Linus Torvalds <torvalds@linux-foundation.org>, Kalle Valo <kvalo@adurom.com>
List-Id: linux-acpi@vger.kernel.org

T24gU3VuZGF5LCBBdWd1c3QgMDQsIDIwMTMgMDk6MzM6NDMgUE0gTWFydGluIFN0ZWlnZXJ3YWxk
IHdyb3RlOgo+IEFtIEZyZWl0YWcsIDI2LiBKdWxpIDIwMTMsIDE0OjQwOjU4IHNjaHJpZWIgUmFm
YWVsIEouIFd5c29ja2k6Cj4gPiBPbiBGcmlkYXksIEp1bHkgMjYsIDIwMTMgMDI6MDk6MDggUE0g
TWFydGluIFN0ZWlnZXJ3YWxkIHdyb3RlOgo+ID4gPiBBbSBEb25uZXJzdGFnLCAyNS4gSnVsaSAy
MDEzLCAxNTowMDoyNiBzY2hyaWViIFJhZmFlbCBKLiBXeXNvY2tpOgo+ID4gPiA+IE9uIE1vbmRh
eSwgSnVseSAyMiwgMjAxMyAwOTo1NDoyMSBQTSBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToKPiA+
ID4gPiA+IE9uIE1vbmRheSwgSnVseSAyMiwgMjAxMyAxMToxMTo1NCBBTSBMaW51cyBUb3J2YWxk
cyB3cm90ZToKPiA+ID4gPiA+ID4gT24gTW9uLCBKdWwgMjIsIDIwMTMgYXQgNjowMiBBTSwgUmFm
YWVsIEouIFd5c29ja2kgPHJqd0BzaXNrLnBsPiAKPiB3cm90ZToKPiA+ID4gPiA+ID4gPiBMaW51
cywgZG8geW91IHdhbnQgbWUgdG8gc2VuZCBhIHB1bGwgcmVxdWVzdCByZXZlcnRpbmcgOGM1YmQ3
YSBhbmQKPiA+ID4gPiA+ID4gPiBlZmFhMTRjPwo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gWWVz
LCBidXQgbGV0J3Mgd2FpdCBhIHdoaWxlLiBOb3QgYmVjYXVzZSBJIHRoaW5rIHdlJ2xsIGZpeCB0
aGUKPiA+ID4gPiA+ID4gcHJvYmxlbQo+ID4gPiA+ID4gPiAoaGV5LCBtaXJhY2xlcyBtaWdodCBo
YXBwZW4pLCBidXQgYmVjYXVzZSBJIHRoaW5rIGl0IHdvdWxkIGJlIHVzZWZ1bAo+ID4gPiA+ID4g
PiB0byBjb3VwbGUgdGhlIHJldmVydHMgd2l0aCBpbmZvcm1hdGlvbiBhYm91dCB0aGUgcGFydGlj
dWxhciBtYWNoaW5lcwo+ID4gPiA+ID4gPiB0aGF0IGJyb2tlIChhbmQgdGhlIHBlb3BsZSB3aG8g
cmVwb3J0ZWQgaXQpLiBTbyB0aGF0IHdoZW4gd2UKPiA+ID4gPiA+ID4gaW5ldml0YWJseSB0cnkg
YWdhaW4sIHdlIGNhbiBwZXJoYXBzIGdldCBzb21lIHRlc3RpbmcgZWZmb3J0IHdpdGgKPiA+ID4g
PiA+ID4gdGhvc2UgbWFjaGluZXMvcGVvcGxlLgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gSXQg
ZG9lc24ndCBzZWVtIHRvIGJlIGEgc2hvdy1zdG9wcGVkIGZvciBhIGxhcmdlIG51bWJlciBvZiBw
ZW9wbGUsCj4gPiA+ID4gPiA+IHNvCj4gPiA+ID4gPiA+IHRoZXJlJ3Mgbm8gaHVnZSBodXJyeS4g
SSdkIHN1Z2dlc3QgZG9pbmcgdGhlIHJldmVydCBqdXN0IGluIHRpbWUgZm9yCj4gPiA+ID4gPiA+
IHJjMywgYnV0IHdhaXRpbmcgdW50aWwgdGhlbiB0byBnYXRoZXIgaW5mbyBhYm91dCBwZW9wbGUg
d2hvIHNlZQo+ID4gPiA+ID4gPiBicmVha2FnZS4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IFNv
dW5kIGxpa2UgYSBwbGFuPwo+ID4gPiA+ID4gCj4gPiA+ID4gPiBZZXMsIGl0IGRvZXMuCj4gPiA+
ID4gCj4gPiA+ID4gT0ssIHRpbWUgdG8gcmV2ZXJ0IEkgZ3Vlc3MuCj4gPiA+ID4gCj4gPiA+ID4g
SmFtZXMsIEthbWFsLCBTdGV2ZW4sIErDtnJnLCBNYXJ0aW4sIEthbGxlLCBwbGVhc2UgY2hlY2sg
aWYgdGhlIGFwcHBlbmRlZAo+ID4gPiA+IHBhdGNoIGZpeGVzIHRoZSBiYWNrbGlnaHQgZm9yIHlv
dS4KPiA+ID4gCj4gPiA+IFJhZmFlbCwgZG8geW91IHN0aWxsIG5lZWQgbW9yZSB0ZXN0aW5nIHVy
Z2VudGx5PyBPdGhlcndpc2UgScK0ZCB3YWl0IHRpbGwKPiA+ID4gaXRzIGluIHNvbWUgbmV4dCAz
LjExIHJjIGFuZCB0ZXN0IHRoZW4uCj4gPiAKPiA+IFdlbGwsIGl0IHNlZW1zIHRvIHdvcmsgZm9y
IGV2ZXJ5Ym9keSBlbHNlIChTdGV2ZW4sIEpvZXJnLCB0aGFua3MgZm9yIHlvdXIKPiA+IHJlcG9y
dHMhKSwgc28gSSBkb24ndCB0aGluayB5b3UgbmVlZCB0byB0ZXN0IGl0IHVyZ2VudGx5Lgo+IAo+
IEp1c3QgYSBsYXRlIGNvbmZpcm1hdGlvbjogV2l0aCAzLjExLXJjMyBiYWNrIGxpZ2h0IHN0dWZm
IGlzIHdvcmtpbmcgbmljZWx5IG9uIAo+IHRoaXMgVGhpbmtQYWQgVDUyMC4KClRoYW5rcyEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBt
YWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
