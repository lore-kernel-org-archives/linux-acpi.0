From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH] drm/i915/opregion: work around
	buggy	firmware that provides 8+ output devices
Date: Mon, 08 Dec 2014 13:04:34 +0200
Message-ID: <87388qo119.fsf@intel.com>
References: <52FAE504.8020001@intel.com>
 <20140212103156.GC5298@nuc-i3427.alporthouse.com>
 <52FC8C01.1040002@intel.com>
 <20140213100814.GM14909@nuc-i3427.alporthouse.com>
 <CAKMK7uGN3Of2VU6_LsSLh041kkx4TrhyH0H8zvE-PRvOtzJgfg@mail.gmail.com>
 <53045DD1.5010406@intel.com> <20140219073339.GA30685@srcf.ucam.org>
 <5304725A.3020909@intel.com> <20140304144504.GE17001@phenom.ffwll.local>
 <548505D2.8030904@intel.com> <8761dmo17c.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <8761dmo17c.fsf@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Aaron Lu <aaron.lu@intel.com>, Daniel Vetter <daniel@ffwll.ch>, Matthew Garrett <mjg59@srcf.ucam.org>, Chris Wilson <chris@chris-wilson.co.uk>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, jaime.91@hotmail.es, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Oleksij Rempel <linux@rempel-privat.de>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gTW9uLCAwOCBEZWMgMjAxNCwgSmFuaSBOaWt1bGEgPGphbmkubmlrdWxhQGxpbnV4LmludGVs
LmNvbT4gd3JvdGU6Cj4gT24gTW9uLCAwOCBEZWMgMjAxNCwgQWFyb24gTHUgPGFhcm9uLmx1QGlu
dGVsLmNvbT4gd3JvdGU6Cj4+IFdlIGhhdmUgYSBuZXcgYnVnIHJlcG9ydCB0aGF0IGhhcyB0aGUg
c2FtZSBwcm9ibGVtOgo+PiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dp
P2lkPTg4OTQxCj4+Cj4+IFRoZSBwb3N0ZWQgcGF0Y2ggc29sdmVzIHRoZSBwcm9ibGVtLiBJIGtu
b3cgaXQncyBub3QgcGVyZmVjdCwgYnV0IGl0Cj4+IGRvZXNuJ3Qgc2VlbSBpdCB3b3VsZCBkbyBh
bnkgaGFybSB0byBleGlzdGluZyBzeXN0ZW1zIHNvIHNob3VsZCBiZSBzYWZlLgo+Pgo+PiBCZXR0
ZXIsIGlmIHNvbWVvbmUgY2FuIHNoZWQgc29tZSBsaWdodCBvbiBob3cgdGhpcyBzaG91bGQgYmUg
cHJvcGVybHkKPj4gaGFuZGxlZCwgdGhhdCB3b3VsZCBiZSBncmVhdC4KPgo+IFRoZXJlIHdhcyBh
IGJ1ZyByZXBvcnQgdGhhdCBJIGNhbid0IGZpbmQgcmlnaHQgbm93IHRoYXQgaGFkIGEgc2ltaWxh
cgo+IHByb2JsZW0uIEkgd3JvdGUgYSBmZXcgcGF0Y2hlcywgZXZlbiBzb21ld2hhdCBwb2xpc2hl
ZCBvbmVzICh0aGF0IEkgbm93Cj4gcHVzaGVkIHRvIFsxXSBmb3IgcmVmZXJlbmNlKSB0byBoYW5k
bGUgZXh0ZW5kZWQgRElETC4gVW5mb3J0dW5hdGVseSB0aGlzCj4gZGlkbid0IGhlbHAgdGhlIGJ1
ZyByZXBvcnRlciBiZWNhdXNlIHRoZSByaWdodCBvbmUgd2FzIGJleW9uZCB0aGUKPiBleHRlbmRl
ZCBESURMIHRvbywgc28gSSBkb24ndCB0aGluayBJIGV2ZW4gc2VudCB0aGVzZSB0byB0aGUgbGlz
dC4KPgo+IEFueXdheSwganVzdCBvbmUgbW9yZSBkYXRhIHBvaW50LiBUaGlzIG1pZ2h0IGhlbHAg
eW91ciByZXBvcnRlciwgc28KPiB3b3J0aCBhIHRyeS4gQnV0IGl0IGRvZXNuJ3Qgc29sdmUgZXZl
cnl0aGluZy4KClsxXSBodHRwOi8vY2dpdC5mcmVlZGVza3RvcC5vcmcvfmphbmkvZHJtL2xvZy8/
aD1kaWRsCgoKLS0gCkphbmkgTmlrdWxhLCBJbnRlbCBPcGVuIFNvdXJjZSBUZWNobm9sb2d5IENl
bnRlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRl
bC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
