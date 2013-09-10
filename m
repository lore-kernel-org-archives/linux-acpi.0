From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI / video / i915: Remove ACPI
	backlight if firmware expects Windows 8
Date: Tue, 10 Sep 2013 17:21:41 +0300
Message-ID: <87bo40ahai.fsf@intel.com>
References: <522D88C3.7000808@intel.com> <1793135.3qk7NfcINN@vostro.rjw.lan>
	<20130909152118.GG27291@phenom.ffwll.local>
	<5155010.Y1gov7SKhP@vostro.rjw.lan> <87eh8wail7.fsf@intel.com>
	<1378821416.17982.56.camel@x230.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1378821416.17982.56.camel@x230.lan>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Seth Forshee <seth.forshee@canonical.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Yves-Alexis Perez <corsac@debian.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Lee,
	Chun-Yi" <joeyli.kernel@gmail.com>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, Lee Chun-Yi <jlee@novell.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gVHVlLCAxMCBTZXAgMjAxMywgTWF0dGhldyBHYXJyZXR0IDxtYXR0aGV3LmdhcnJldHRAbmVi
dWxhLmNvbT4gd3JvdGU6Cj4gT24gVHVlLCAyMDEzLTA5LTEwIGF0IDE2OjUzICswMzAwLCBKYW5p
IE5pa3VsYSB3cm90ZToKPgo+PiBJIHRoaW5rIHRoZSBwYXJhbWV0ZXIgIkRvZXMgdGhlIEFDUEkg
YmFja2xpZ2h0IGludGVyZmFjZSB3b3JrIG9yIG5vdCIKPj4gYmVsb25ncyB0byB0aGUgQUNQSSB2
aWRlbyBkcml2ZXIuCj4KPiBUaGF0IGRlcGVuZHMgb24gaG93IFdpbmRvd3MgOCB3b3Jrcy4gSWYg
V2luZG93cyA4IHBvbGljeSBpcyBoYW5kbGVkIGJ5Cj4gdGhlIEdQVSBkcml2ZXJzIHRoZW4gaXQg
YmVsb25ncyBpbiBpOTE1LiBJZiBpdCdzIGhhbmRsZWQgYnkgdGhlIEFDUEkKPiBjb2RlIHRoZW4g
aXQgYmVsb25ncyBpbiB0aGUgQUNQSSBjb2RlLgoKSSBmYWlsIHRvIHNlZSB0aGUgbG9naWMuIFdp
bmRvd3MgOCBwb2xpY3kgZGljdGF0ZXMgd2hldGhlciB3ZSBjYW4gdXNlCnRoZSBBTUwgY29kZSBv
ciBub3QuIElNSE8sIEFDUEkgY29kZSBpcyBpbiB0aGUgYmVzdCBwb3NpdGlvbiB0byBmaWd1cmUK
dGhpcyBvdXQgYW5kIHF1aXJrIGFzIG5lY2Vzc2FyeS4gSXQncyB0aGUgcGFydCB0aGF0IGtub3dz
IGFib3V0IFdpbmRvd3MKOCwgbm90IGk5MTUuCgo+IEJ1dCBJIGhhdmUgbm8gd2F5IG9mIGRldGVy
bWluaW5nIHRoYXQsIHdoZXJlYXMgeW91IHdvcmsgZm9yIGEgY29tcGFueQo+IHRoYXQgcHJvZHVj
ZXMgYSBXaW5kb3dzIDggdmlkZW8gZHJpdmVy4oCmCgpIZXJlIEkgZG8gc2VlIHRoZSBsb2dpYy4g
SG93ZXZlciBzZWUgc2lnbmF0dXJlOyBJJ20gbm90IGluIHRoZSBiZXN0IG9mCnBvc2l0aW9ucyB0
byBmaWd1cmUgb3V0IHRoaW5ncyBhYm91dCBXaW5kb3dzIDggdmlkZW8gZHJpdmVycy4gOykgQnV0
CkknbGwgc2VlIHdoYXQgSSBjYW4gZG8uCgpCUiwKSmFuaS4KCgotLSAKSmFuaSBOaWt1bGEsIElu
dGVsIE9wZW4gU291cmNlIFRlY2hub2xvZ3kgQ2VudGVyCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
