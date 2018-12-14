From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 2/3] ACPI / PMIC: Implement
 exec_mipi_pmic_seq_element for CHT Whiskey Cove PMIC
Date: Fri, 14 Dec 2018 13:04:57 +0200
Message-ID: <20181214110457.GU2469@lahna.fi.intel.com>
References: <20181213153533.10949-1-hdegoede@redhat.com>
 <20181213153533.10949-2-hdegoede@redhat.com>
 <20181214094926.GT2469@lahna.fi.intel.com>
 <78611327-6c8d-2fe5-e3f9-af0aec9d02f7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <78611327-6c8d-2fe5-e3f9-af0aec9d02f7@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gRnJpLCBEZWMgMTQsIDIwMTggYXQgMTE6NDg6MzVBTSArMDEwMCwgSGFucyBkZSBHb2VkZSB3
cm90ZToKPiA+ID4gKyNpbmNsdWRlIDxhc20vdW5hbGlnbmVkLmg+Cj4gPiAKPiA+IFdoeSBpcyB0
aGlzIGluY2x1ZGUgbmVlZGVkPwo+IAo+IEl0IGlzIG5vIGxvbmdlciBuZWVkZWQgaW4gdjQsIHNp
bmNlIHRoZSBwYXJzaW5nIG9mIHRoZSByYXcKPiBNSVBJIHNlcXVlbmNlIGRhdGEgKHdoaWNoIG5l
ZWRlZCB0aGlzIGluY2x1ZGUpIGhhcyBiZWVuIG1vdmVkCj4gdG8gdGhlIGk5MTUgVkJUIGNvZGUg
bm93Lgo+IAo+IEkndmUgZHJvcHBlZCB0aGlzIGZyb20gbXkgbG9jYWwgdmVyc2lvbiBvZiB0aGUg
cGF0Y2guCgpPSy4KCj4gTm90ZSBzdXJlIGlmIHlvdSAoTWlrYSkgYXJlIHRoZSByaWdodCBwZXJz
b24gdG8gYXNrLCBidXQgaW4gdGhlCj4gY292ZXJsZXR0ZXIgb2YgdjEgSSBzdWdnZXN0ZWQgbWVy
Z2luZyBhbGwgMyBwYXRjaGVzIHRocm91Z2ggdGhlIGk5MTUgdHJlZQo+IHNpbmNlIHRoZSBkcml2
ZXJzL2FjcGkvcG1pYy9pbnRlbF9wbWljKiBmaWxlcyB0eXBpY2FsbHkgZG8KPiBub3Qgc2VlIGFs
bCB0aGF0IGNodXJuLiAgSWYgSSBjYW4gZ2V0IGFuIEFjayBmcm9tIHlvdSBvcgo+IFJhZmFlbCBm
b3IgdGhhdCB0aGVuIEkgY2FuIHB1c2ggdGhlIHZlcnNpb24gd2l0aCB0aGUgaW5jbHVkZQo+IGRy
b3BwZWQgdG8gZHJtLW5leHQgKHRocm91Z2ggZHJtLWludGVsLW5leHQtcXVldWVkKSBteXNlbGYK
PiBvbmNlIHRoZSAzdGggcGF0Y2ggYWxzbyBoYXMgYmVlbiBhY2tlZC4KCkkgZ3Vlc3MgaXQgaXMg
dXAgdG8gUmFmYWVsIHdoZXRoZXIgbXkgYWNrIGlzIGVub3VnaCBidXQgaGVyZSBpdCBpcyBmb3IK
Ym90aCBwYXRjaGVzLAoKQWNrZWQtYnk6IE1pa2EgV2VzdGVyYmVyZyA8bWlrYS53ZXN0ZXJiZXJn
QGxpbnV4LmludGVsLmNvbT4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50
ZWwtZ2Z4Cg==
