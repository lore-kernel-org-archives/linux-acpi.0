From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 4/5] ACPI / extlog: Switch to use new
	generic UUID API
Date: Mon, 05 Jun 2017 19:23:05 +0300
Message-ID: <1496679785.22624.19.camel@linux.intel.com>
References: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com>
 <20170531194152.65927-5-andriy.shevchenko@linux.intel.com>
 <20170605160626.GD29981@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170605160626.GD29981@lst.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Christoph Hellwig <hch@lst.de>
Cc: intel-gfx@lists.freedesktop.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Borislav Petkov <bp@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

T24gTW9uLCAyMDE3LTA2LTA1IGF0IDE4OjA2ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToKPiA+IEBAIC0xNjUsMTEgKzE2NSwxMSBAQCBzdGF0aWMgaW50IGV4dGxvZ19wcmludChzdHJ1
Y3Qgbm90aWZpZXJfYmxvY2sKPiA+ICpuYiwgdW5zaWduZWQgbG9uZyB2YWwsCj4gPiDCoAllcnJf
c2VxKys7Cj4gPiDCoAlnZGF0YSA9IChzdHJ1Y3QgYWNwaV9oZXN0X2dlbmVyaWNfZGF0YSAqKSh0
bXAgKyAxKTsKPiA+IMKgCWlmIChnZGF0YS0+dmFsaWRhdGlvbl9iaXRzICYgQ1BFUl9TRUNfVkFM
SURfRlJVX0lEKQo+ID4gLQkJZnJ1X2lkID0gKHV1aWRfbGUgKilnZGF0YS0+ZnJ1X2lkOwo+ID4g
KwkJZnJ1X2lkID0gKGd1aWRfdCAqKWdkYXRhLT5mcnVfaWQ7Cj4gPiDCoAlpZiAoZ2RhdGEtPnZh
bGlkYXRpb25fYml0cyAmIENQRVJfU0VDX1ZBTElEX0ZSVV9URVhUKQo+ID4gwqAJCWZydV90ZXh0
ID0gZ2RhdGEtPmZydV90ZXh0Owo+ID4gLQlzZWNfdHlwZSA9ICh1dWlkX2xlICopZ2RhdGEtPnNl
Y3Rpb25fdHlwZTsKPiA+IC0JaWYgKCF1dWlkX2xlX2NtcCgqc2VjX3R5cGUsIENQRVJfU0VDX1BM
QVRGT1JNX01FTSkpIHsKPiA+ICsJc2VjX3R5cGUgPSAoZ3VpZF90ICopZ2RhdGEtPnNlY3Rpb25f
dHlwZTsKPiAKPiBGcm9tIGEgcXVpY2sgbG9vayBvdmVyIHRoZSB0cmVlIGl0IHNlZW1zIGxpa2Ug
Ym90aCBmcnVfaWQgYW5kCj4gc2VjdGlvbl90eXBlIHNob3VsZCBiZSBkZWNsYXJlZCBhcyBndWlk
X3QgaW4KPiBzdHJ1Y3QgYWNwaV9oZXN0X2dlbmVyaWNfZGF0YS4KCgpUaGV5IGFyZSBhcnJheXMg
b2YgMTYgdTg6cy4KQW5kIHNpbmNlIGl0J3MgZGVmaW5lZCBpbiBBQ1BJIHRhYmxlIGRlZmluaXRp
b24gSSdtIG5vdCBzdXJlIHdlIGNhbgpjaGFuZ2UgaXQuCgo+IAo+ID4gKwlpZiAoIWd1aWRfZXF1
YWwoc2VjX3R5cGUsICZDUEVSX1NFQ19QTEFURk9STV9NRU0pKSB7Cj4gCj4gVGhlICIhIiBzZWVt
cyBpbmNvcnJlY3QgaGVyZS4KClJpZ2h0LgoKLS0gCkFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNo
ZXZjaGVua29AbGludXguaW50ZWwuY29tPgpJbnRlbCBGaW5sYW5kIE95Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QK
SW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
