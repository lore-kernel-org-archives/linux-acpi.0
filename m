From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 2/3] ACPI / PMIC: Implement
 exec_mipi_pmic_seq_element for CHT Whiskey Cove PMIC
Date: Fri, 14 Dec 2018 12:52:14 +0100
Message-ID: <CAJZ5v0jdpmw1ML8Evffcs+t_0uEkND6gZP_vcQdt6ivBgaTTpQ@mail.gmail.com>
References: <20181213153533.10949-1-hdegoede@redhat.com>
 <20181213153533.10949-2-hdegoede@redhat.com>
 <20181214094926.GT2469@lahna.fi.intel.com>
 <78611327-6c8d-2fe5-e3f9-af0aec9d02f7@redhat.com>
 <20181214110457.GU2469@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20181214110457.GU2469@lahna.fi.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, dri-devel <dri-devel@lists.freedesktop.org>, rodrigo.vivi@intel.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gRnJpLCBEZWMgMTQsIDIwMTggYXQgMTI6MDUgUE0gTWlrYSBXZXN0ZXJiZXJnCjxtaWthLndl
c3RlcmJlcmdAbGludXguaW50ZWwuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgRGVjIDE0LCAyMDE4
IGF0IDExOjQ4OjM1QU0gKzAxMDAsIEhhbnMgZGUgR29lZGUgd3JvdGU6Cj4gPiA+ID4gKyNpbmNs
dWRlIDxhc20vdW5hbGlnbmVkLmg+Cj4gPiA+Cj4gPiA+IFdoeSBpcyB0aGlzIGluY2x1ZGUgbmVl
ZGVkPwo+ID4KPiA+IEl0IGlzIG5vIGxvbmdlciBuZWVkZWQgaW4gdjQsIHNpbmNlIHRoZSBwYXJz
aW5nIG9mIHRoZSByYXcKPiA+IE1JUEkgc2VxdWVuY2UgZGF0YSAod2hpY2ggbmVlZGVkIHRoaXMg
aW5jbHVkZSkgaGFzIGJlZW4gbW92ZWQKPiA+IHRvIHRoZSBpOTE1IFZCVCBjb2RlIG5vdy4KPiA+
Cj4gPiBJJ3ZlIGRyb3BwZWQgdGhpcyBmcm9tIG15IGxvY2FsIHZlcnNpb24gb2YgdGhlIHBhdGNo
Lgo+Cj4gT0suCj4KPiA+IE5vdGUgc3VyZSBpZiB5b3UgKE1pa2EpIGFyZSB0aGUgcmlnaHQgcGVy
c29uIHRvIGFzaywgYnV0IGluIHRoZQo+ID4gY292ZXJsZXR0ZXIgb2YgdjEgSSBzdWdnZXN0ZWQg
bWVyZ2luZyBhbGwgMyBwYXRjaGVzIHRocm91Z2ggdGhlIGk5MTUgdHJlZQo+ID4gc2luY2UgdGhl
IGRyaXZlcnMvYWNwaS9wbWljL2ludGVsX3BtaWMqIGZpbGVzIHR5cGljYWxseSBkbwo+ID4gbm90
IHNlZSBhbGwgdGhhdCBjaHVybi4gIElmIEkgY2FuIGdldCBhbiBBY2sgZnJvbSB5b3Ugb3IKPiA+
IFJhZmFlbCBmb3IgdGhhdCB0aGVuIEkgY2FuIHB1c2ggdGhlIHZlcnNpb24gd2l0aCB0aGUgaW5j
bHVkZQo+ID4gZHJvcHBlZCB0byBkcm0tbmV4dCAodGhyb3VnaCBkcm0taW50ZWwtbmV4dC1xdWV1
ZWQpIG15c2VsZgo+ID4gb25jZSB0aGUgM3RoIHBhdGNoIGFsc28gaGFzIGJlZW4gYWNrZWQuCj4K
PiBJIGd1ZXNzIGl0IGlzIHVwIHRvIFJhZmFlbCB3aGV0aGVyIG15IGFjayBpcyBlbm91Z2gKClll
cywgaXQgaXMuIDotKQoKPiBidXQgaGVyZSBpdCBpcyBmb3IgYm90aCBwYXRjaGVzLAo+Cj4gQWNr
ZWQtYnk6IE1pa2EgV2VzdGVyYmVyZyA8bWlrYS53ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNvbT4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
