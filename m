From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/3] ACPI / PMIC: Implement
 exec_mipi_pmic_seq_element for CHT Whiskey Cove PMIC
Date: Sun, 9 Dec 2018 15:34:22 +0100
Message-ID: <65e861e5-b75d-b46d-b90f-0eee88f11557@redhat.com>
References: <20181207141805.GI10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20181207141805.GI10650@smile.fi.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org
List-Id: linux-acpi@vger.kernel.org

SGksCgpPbiAwNy0xMi0xOCAxNToxOCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOgo+PiBJbXBsZW1l
bnQgdGhlIGV4ZWNfbWlwaV9wbWljX3NlcV9lbGVtZW50IGNhbGxiYWNrIGZvciB0aGUgQ0hUIFdo
aXNrZXkgQ292ZQo+PiBQTUlDLgo+IAo+PiBPbiBzb21lIENIVCBkZXZpY2VzIHRoaXMgZml4ZXMg
dGhlIExDRCBwYW5lbCBub3QgbGlnaHRpbmcgdXAgd2hlbiBpdCB3YXMKPj4gbm90IGluaXRpYWxp
emVkIGJ5IHRoZSBHT1AsIGJlY2F1c2UgYW4gZXh0ZXJuYWwgbW9uaXRvciB3YXMgcGx1Z2dlZCBp
biBhbmQKPj4gdGhlIEdPUCBpbml0aWFsaXplZCBvbmx5IHRoZSBleHRlcm5hbCBtb25pdG9yLgo+
IAo+PiArCS8qIGJ5dGUgMCBha2EgUE1JQyBGbGFnIGlzIHJlc2VydmVkICovCj4+ICsJaTJjX2Ns
aWVudF9hZGRyZXNzCT0gZ2V0X3VuYWxpZ25lZF9sZTE2KGRhdGEgKyAxKTsKPj4gKwlyZWdfYWRk
cmVzcwkJPSBnZXRfdW5hbGlnbmVkX2xlMzIoZGF0YSArIDMpOwo+PiArCXZhbHVlCQkJPSBnZXRf
dW5hbGlnbmVkX2xlMzIoZGF0YSArIDcpOwo+PiArCW1hc2sJCQk9IGdldF91bmFsaWduZWRfbGUz
MihkYXRhICsgMTEpOwo+PiArCj4gCj4+ICsJaWYgKGkyY19jbGllbnRfYWRkcmVzcyA+IDI1NSB8
fCByZWdfYWRkcmVzcyA+IDI1NSkgewo+IAo+IEhtbS4uLiBJIHdvdWxkIHJhdGhlciBsaWtlIHRv
IHNlZSBoZXhhZGVjaW1hbCBmb3IgYWRkcmVzc2VzIGFuZCBkZWNpbWFsIGZvcgo+IHNvbWV0aGlu
ZyBsaWtlIGNvdW50YWJsZSB2YWx1ZSBmb3IgZGF0YS4KCk9rLCBmaXhlZCBmb3IgdjMuCgpSZWdh
cmRzLAoKSGFucwoKPiAKPj4gKwkJcHJfd2FybigiJXMgd2FybmluZyBhZGRyZXNzZXMgdG9vIGJp
ZyBjbGllbnQgMHgleCByZWcgMHgleFxuIiwKPj4gKwkJCV9fZnVuY19fLCBpMmNfY2xpZW50X2Fk
ZHJlc3MsIHJlZ19hZGRyZXNzKTsKPj4gKwkJcmV0dXJuOwo+PiArCX0KPj4gKwo+PiArCWFkZHJl
c3MgPSAoaTJjX2NsaWVudF9hZGRyZXNzIDw8IDgpIHwgcmVnX2FkZHJlc3M7Cj4+ICsJcmVnbWFw
X3VwZGF0ZV9iaXRzKHJlZ21hcCwgYWRkcmVzcywgbWFzaywgdmFsdWUpOwo+PiArfQo+IApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFp
bGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK
