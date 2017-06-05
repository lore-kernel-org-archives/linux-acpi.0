From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/5] acpi,
	nfit: Switch to use new generic UUID API
Date: Mon, 05 Jun 2017 20:10:42 +0300
Message-ID: <1496682642.22624.23.camel@linux.intel.com>
References: <20170605164046.82676-1-andriy.shevchenko@linux.intel.com>
 <20170605164046.82676-2-andriy.shevchenko@linux.intel.com>
 <CAPcyv4h4PY1JBxTB6Powf2y2uiHAZ4QtnZG16bBzdQqsQ2KAYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <CAPcyv4h4PY1JBxTB6Powf2y2uiHAZ4QtnZG16bBzdQqsQ2KAYQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: intel-gfx@lists.freedesktop.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Christoph Hellwig <hch@lst.de>
List-Id: linux-acpi@vger.kernel.org

T24gTW9uLCAyMDE3LTA2LTA1IGF0IDA5OjQ5IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
T24gTW9uLCBKdW4gNSwgMjAxNyBhdCA5OjQwIEFNLCBBbmR5IFNoZXZjaGVua28KPiA8YW5kcml5
LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPiB3cm90ZToKPiA+IFRoZXJlIGFyZSBuZXcgdHlw
ZXMgYW5kIGhlbHBlcnMgdGhhdCBhcmUgc3VwcG9zZWQgdG8gYmUgdXNlZCBpbiBuZXcKPiA+IGNv
ZGUuCj4gPiAKPiA+IEFzIGEgcHJlcGFyYXRpb24gdG8gZ2V0IHJpZCBvZiBsZWdhY3kgdHlwZXMg
YW5kIEFQSSBmdW5jdGlvbnMgZG8KPiA+IHRoZSBjb252ZXJzaW9uIGhlcmUuCgpJIGhvcGUgQ2hy
aXN0b3BoIGNhbiByZXBsYWNlIG9sZCB2ZXJzaW9uIG9mIHRoaXMgc2VyaWVzIHdpdGggbmV3IG9u
ZSBpbgpoaXMgdXVpZCBicmFuY2guIFVSTCBpbiBjb3ZlciBsZXR0ZXIsIHJlcGVhdGluZyBmb3Ig
eW91ciBjb252ZW5pZW5jZToKClsxXTogZ2l0Oi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMvaGNo
L3V1aWQuZ2l0Cgo+ID4gCj4gPiBSZXZpZXdlZC1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxs
aWFtc0BpbnRlbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJp
eS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4KPiA+IC0tLQo+ID4gwqBkcml2ZXJzL2FjcGkv
bmZpdC9jb3JlLmMgfCA1NCArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCj4g
PiAtLS0tLS0tLS0tLQo+ID4gwqBkcml2ZXJzL2FjcGkvbmZpdC9uZml0LmggfMKgwqAzICstLQo+
ID4gwqBpbmNsdWRlL2xpbnV4L2FjcGkuaMKgwqDCoMKgwqB8wqDCoDEgKwo+ID4gwqAzIGZpbGVz
IGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQo+IAo+IElzIHRoZXJl
IGEgZ2l0IGJyYW5jaCB3aXRoIHRoZXNlIGF2YWlsYWJsZSwgc28gSSBjYW4gcnVuIGl0IHRocm91
Z2gKPiB0aGUgbnZkaW1tIHJlZ3Jlc3Npb24gc3VpdGU/CgotLSAKQW5keSBTaGV2Y2hlbmtvIDxh
bmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+CkludGVsIEZpbmxhbmQgT3kKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxp
bmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
