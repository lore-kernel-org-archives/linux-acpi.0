From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 1/3] ACPI / PMIC: Add support for
 executing PMIC MIPI sequence elements
Date: Fri, 14 Dec 2018 11:47:02 +0200
Message-ID: <20181214094702.GS2469@lahna.fi.intel.com>
References: <20181213153533.10949-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20181213153533.10949-1-hdegoede@redhat.com>
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

T24gVGh1LCBEZWMgMTMsIDIwMTggYXQgMDQ6MzU6MzFQTSArMDEwMCwgSGFucyBkZSBHb2VkZSB3
cm90ZToKPiBEU0kgTENEIHBhbmVscyBkZXNjcmliZSBhbiBpbml0aWFsaXphdGlvbiBzZXF1ZW5j
ZSBpbiB0aGUgVmlkZW8gQklPUwo+IFRhYmxlcyB1c2luZyBzbyBjYWxsZWQgTUlQSSBzZXF1ZW5j
ZXMuIE9uZSBwb3NzaWJsZSBlbGVtZW50IGluIHRoZXNlCj4gc2VxdWVuY2VzIGlzIGEgUE1JQyBz
cGVjaWZpYyBlbGVtZW50IG9mIDE1IGJ5dGVzLgo+IAo+IEFsdGhvdWdoIHRoaXMgaXMgbm90IHJl
YWxseSBhbiBBQ1BJIG9wcmVnaW9uLCB0aGUgQUNQSSBvcHJlZ2lvbiBjb2RlIGlzIHRoZQo+IGNs
b3Nlc3QgdGhpbmcgd2UgaGF2ZS4gV2UgbmVlZCB0byBoYXZlIHN1cHBvcnQgZm9yIHRoZXNlIFBN
SUMgc3BlY2lmaWMgTUlQSQo+IHNlcXVlbmNlIGVsZW1lbnRzIHNvbXdoZXJlLiBTaW5jZSB3ZSBh
bHJlYWR5IGluc3RhbnRpYXRlIGEgc3BlY2lhbCBwbGF0Zm9ybQo+IGRldmljZSBmb3IgSW50ZWwg
UE1JQ3MgZm9yIHRoZSBBQ1BJIFBNSUMgT3BSZWdpb24gaGFuZGxlciB0byBiaW5kIHRvLAo+IHdp
dGggUE1JQyBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbnMgb2YgdGhlIE9wUmVnaW9uLCB0aGUgaGFu
ZGxpbmcgb2YgTUlQSQo+IHNlcXVlbmNlIFBNSUMgZWxlbWVudHMgZml0cyB2ZXJ5IHdlbGwgaW4g
dGhlIEFDUEkgUE1JQyBPcFJlZ2lvbiBjb2RlLgo+IAo+IFRoaXMgY29tbWl0IGFkZHMgYSBuZXcg
aW50ZWxfc29jX3BtaWNfZXhlY19taXBpX3BtaWNfc2VxX2VsZW1lbnQoKQo+IGZ1bmN0aW9uLCB3
aGljaCBpcyB0byBiZSBiYWNrZWQgYnkgYSBQTUlDIHNwZWNpZmljCj4gZXhlY19taXBpX3BtaWNf
c2VxX2VsZW1lbnQgY2FsbGJhY2suIFRoaXMgZnVuY3Rpb24gd2lsbCBiZSBjYWxsZWQgYnkgdGhl
Cj4gaTkxNSBjb2RlIHRvIGV4ZWN0dXJlIE1JUEkgc2VxdWVuY2UgUE1JQyBlbGVtZW50cy4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPgoKUmV2
aWV3ZWQtYnk6IE1pa2EgV2VzdGVyYmVyZyA8bWlrYS53ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNv
bT4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwt
Z2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
