From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/5] ACPI / APEI: Switch to use new
	generic UUID API
Date: Mon, 05 Jun 2017 19:19:43 +0300
Message-ID: <1496679583.22624.15.camel@linux.intel.com>
References: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com>
 <20170531194152.65927-3-andriy.shevchenko@linux.intel.com>
 <20170605160151.GB29981@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170605160151.GB29981@lst.de>
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

T24gTW9uLCAyMDE3LTA2LTA1IGF0IDE4OjAxICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToKPiA+IC0JCWlmICghdXVpZF9sZV9jbXAoKih1dWlkX2xlICopZ2RhdGEtPnNlY3Rpb25fdHlw
ZSwKPiA+IC0JCQkJwqBDUEVSX1NFQ19QTEFURk9STV9NRU0pKSB7Cj4gPiArCQlpZiAoIWd1aWRf
ZXF1YWwoc2VjX3R5cGUsICZDUEVSX1NFQ19QTEFURk9STV9NRU0pKQo+ID4gewo+IAo+IFRoZSAi
ISIgaGVyZSBzZWVtcyBpbmNvcnJlY3QuCj4gCj4gPiDCoCNpZmRlZiBDT05GSUdfQUNQSV9BUEVJ
X1BDSUVBRVIKPiA+IC0JCWVsc2UgaWYgKCF1dWlkX2xlX2NtcCgqKHV1aWRfbGUgKilnZGF0YS0K
PiA+ID5zZWN0aW9uX3R5cGUsCj4gPiAtCQkJCcKgwqDCoMKgwqDCoENQRVJfU0VDX1BDSUUpKSB7
Cj4gPiArCQllbHNlIGlmICghZ3VpZF9lcXVhbChzZWNfdHlwZSwgJkNQRVJfU0VDX1BDSUUpKSB7
Cj4gCj4gU2FtZSBoZXJlLgoKVGhhbmtzIQpBcmUgeW91IGdvaW5nIHRvIGZpeHVwIHdoZW4gYXBw
bHlpbmcgb3IgYmV0dGVyIG1lIHRvIHNlbmQgYW4gdXBkYXRlZAp2ZXJzaW9uPwoKLS0gCkFuZHkg
U2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPgpJbnRlbCBGaW5s
YW5kIE95Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCklu
dGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
