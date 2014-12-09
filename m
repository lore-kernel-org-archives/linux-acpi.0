From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] drm/i915/opregion: work around
 buggy	firmware that provides 8+ output devices
Date: Tue, 09 Dec 2014 17:15:12 +0800
Message-ID: <5486BDA0.3000801@intel.com>
References: <52FAE504.8020001@intel.com>
 <20140212103156.GC5298@nuc-i3427.alporthouse.com>
 <52FC8C01.1040002@intel.com>
 <20140213100814.GM14909@nuc-i3427.alporthouse.com>
 <CAKMK7uGN3Of2VU6_LsSLh041kkx4TrhyH0H8zvE-PRvOtzJgfg@mail.gmail.com>
 <53045DD1.5010406@intel.com> <20140219073339.GA30685@srcf.ucam.org>
 <5304725A.3020909@intel.com> <20140304144504.GE17001@phenom.ffwll.local>
 <548505D2.8030904@intel.com> <8761dmo17c.fsf@intel.com>
 <87388qo119.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <87388qo119.fsf@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Jani Nikula <jani.nikula@linux.intel.com>, Dmitry Tunin <hanipouspilot@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Matthew Garrett <mjg59@srcf.ucam.org>, Chris Wilson <chris@chris-wilson.co.uk>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, jaime.91@hotmail.es, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Oleksij Rempel <linux@rempel-privat.de>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gMTIvMDgvMjAxNCAwNzowNCBQTSwgSmFuaSBOaWt1bGEgd3JvdGU6Cj4gT24gTW9uLCAwOCBE
ZWMgMjAxNCwgSmFuaSBOaWt1bGEgPGphbmkubmlrdWxhQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6
Cj4+IE9uIE1vbiwgMDggRGVjIDIwMTQsIEFhcm9uIEx1IDxhYXJvbi5sdUBpbnRlbC5jb20+IHdy
b3RlOgo+Pj4gV2UgaGF2ZSBhIG5ldyBidWcgcmVwb3J0IHRoYXQgaGFzIHRoZSBzYW1lIHByb2Js
ZW06Cj4+PiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTg4OTQx
Cj4+Pgo+Pj4gVGhlIHBvc3RlZCBwYXRjaCBzb2x2ZXMgdGhlIHByb2JsZW0uIEkga25vdyBpdCdz
IG5vdCBwZXJmZWN0LCBidXQgaXQKPj4+IGRvZXNuJ3Qgc2VlbSBpdCB3b3VsZCBkbyBhbnkgaGFy
bSB0byBleGlzdGluZyBzeXN0ZW1zIHNvIHNob3VsZCBiZSBzYWZlLgo+Pj4KPj4+IEJldHRlciwg
aWYgc29tZW9uZSBjYW4gc2hlZCBzb21lIGxpZ2h0IG9uIGhvdyB0aGlzIHNob3VsZCBiZSBwcm9w
ZXJseQo+Pj4gaGFuZGxlZCwgdGhhdCB3b3VsZCBiZSBncmVhdC4KPj4KPj4gVGhlcmUgd2FzIGEg
YnVnIHJlcG9ydCB0aGF0IEkgY2FuJ3QgZmluZCByaWdodCBub3cgdGhhdCBoYWQgYSBzaW1pbGFy
Cj4+IHByb2JsZW0uIEkgd3JvdGUgYSBmZXcgcGF0Y2hlcywgZXZlbiBzb21ld2hhdCBwb2xpc2hl
ZCBvbmVzICh0aGF0IEkgbm93Cj4+IHB1c2hlZCB0byBbMV0gZm9yIHJlZmVyZW5jZSkgdG8gaGFu
ZGxlIGV4dGVuZGVkIERJREwuIFVuZm9ydHVuYXRlbHkgdGhpcwo+PiBkaWRuJ3QgaGVscCB0aGUg
YnVnIHJlcG9ydGVyIGJlY2F1c2UgdGhlIHJpZ2h0IG9uZSB3YXMgYmV5b25kIHRoZQo+PiBleHRl
bmRlZCBESURMIHRvbywgc28gSSBkb24ndCB0aGluayBJIGV2ZW4gc2VudCB0aGVzZSB0byB0aGUg
bGlzdC4KPj4KPj4gQW55d2F5LCBqdXN0IG9uZSBtb3JlIGRhdGEgcG9pbnQuIFRoaXMgbWlnaHQg
aGVscCB5b3VyIHJlcG9ydGVyLCBzbwo+PiB3b3J0aCBhIHRyeS4gQnV0IGl0IGRvZXNuJ3Qgc29s
dmUgZXZlcnl0aGluZy4KPiAKPiBbMV0gaHR0cDovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL35qYW5p
L2RybS9sb2cvP2g9ZGlkbAoKVGhhbmtzIGZvciB0aGUgaW5mbywgSSd2ZSBhc2tlZCBEbWl0cnkg
dG8gZ2l2ZSBpdCBhIHRyeS4KClJlZ2FyZHMsCkFhcm9uCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
