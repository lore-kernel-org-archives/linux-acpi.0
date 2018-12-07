From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] ACPI / PMIC: Implement
 exec_mipi_pmic_seq_element for CHT Whiskey Cove PMIC
Date: Fri, 7 Dec 2018 16:18:05 +0200
Message-ID: <20181207141805.GI10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org
List-Id: linux-acpi@vger.kernel.org

PiBJbXBsZW1lbnQgdGhlIGV4ZWNfbWlwaV9wbWljX3NlcV9lbGVtZW50IGNhbGxiYWNrIGZvciB0
aGUgQ0hUIFdoaXNrZXkgQ292ZQo+IFBNSUMuCgo+IE9uIHNvbWUgQ0hUIGRldmljZXMgdGhpcyBm
aXhlcyB0aGUgTENEIHBhbmVsIG5vdCBsaWdodGluZyB1cCB3aGVuIGl0IHdhcwo+IG5vdCBpbml0
aWFsaXplZCBieSB0aGUgR09QLCBiZWNhdXNlIGFuIGV4dGVybmFsIG1vbml0b3Igd2FzIHBsdWdn
ZWQgaW4gYW5kCj4gdGhlIEdPUCBpbml0aWFsaXplZCBvbmx5IHRoZSBleHRlcm5hbCBtb25pdG9y
LgoKPiArCS8qIGJ5dGUgMCBha2EgUE1JQyBGbGFnIGlzIHJlc2VydmVkICovCj4gKwlpMmNfY2xp
ZW50X2FkZHJlc3MJPSBnZXRfdW5hbGlnbmVkX2xlMTYoZGF0YSArIDEpOwo+ICsJcmVnX2FkZHJl
c3MJCT0gZ2V0X3VuYWxpZ25lZF9sZTMyKGRhdGEgKyAzKTsKPiArCXZhbHVlCQkJPSBnZXRfdW5h
bGlnbmVkX2xlMzIoZGF0YSArIDcpOwo+ICsJbWFzawkJCT0gZ2V0X3VuYWxpZ25lZF9sZTMyKGRh
dGEgKyAxMSk7Cj4gKwoKPiArCWlmIChpMmNfY2xpZW50X2FkZHJlc3MgPiAyNTUgfHwgcmVnX2Fk
ZHJlc3MgPiAyNTUpIHsKCkhtbS4uLiBJIHdvdWxkIHJhdGhlciBsaWtlIHRvIHNlZSBoZXhhZGVj
aW1hbCBmb3IgYWRkcmVzc2VzIGFuZCBkZWNpbWFsIGZvcgpzb21ldGhpbmcgbGlrZSBjb3VudGFi
bGUgdmFsdWUgZm9yIGRhdGEuCgo+ICsJCXByX3dhcm4oIiVzIHdhcm5pbmcgYWRkcmVzc2VzIHRv
byBiaWcgY2xpZW50IDB4JXggcmVnIDB4JXhcbiIsCj4gKwkJCV9fZnVuY19fLCBpMmNfY2xpZW50
X2FkZHJlc3MsIHJlZ19hZGRyZXNzKTsKPiArCQlyZXR1cm47Cj4gKwl9Cj4gKwo+ICsJYWRkcmVz
cyA9IChpMmNfY2xpZW50X2FkZHJlc3MgPDwgOCkgfCByZWdfYWRkcmVzczsKPiArCXJlZ21hcF91
cGRhdGVfYml0cyhyZWdtYXAsIGFkZHJlc3MsIG1hc2ssIHZhbHVlKTsKPiArfQoKLS0gCldpdGgg
QmVzdCBSZWdhcmRzLApBbmR5IFNoZXZjaGVua28KCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9pbnRlbC1nZngK
