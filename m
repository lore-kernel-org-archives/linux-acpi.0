From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 2/4] ACPI / PMIC: Implement
 exec_mipi_pmic_seq_element for CHT Whiskey Cove PMIC
Date: Mon, 7 Jan 2019 17:38:08 +0200
Message-ID: <20190107153808.GP9170@smile.fi.intel.com>
References: <20190107111556.4510-1-hdegoede@redhat.com>
 <20190107111556.4510-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190107111556.4510-3-hdegoede@redhat.com>
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
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gTW9uLCBKYW4gMDcsIDIwMTkgYXQgMTI6MTU6NTRQTSArMDEwMCwgSGFucyBkZSBHb2VkZSB3
cm90ZToKPiBJbXBsZW1lbnQgdGhlIGV4ZWNfbWlwaV9wbWljX3NlcV9lbGVtZW50IGNhbGxiYWNr
IGZvciB0aGUgQ0hUIFdoaXNrZXkgQ292ZQo+IFBNSUMuCj4gCj4gT24gc29tZSBDSFQgZGV2aWNl
cyB0aGlzIGZpeGVzIHRoZSBMQ0QgcGFuZWwgbm90IGxpZ2h0aW5nIHVwIHdoZW4gaXQgd2FzCj4g
bm90IGluaXRpYWxpemVkIGJ5IHRoZSBHT1AsIGJlY2F1c2UgYW4gZXh0ZXJuYWwgbW9uaXRvciB3
YXMgcGx1Z2dlZCBpbiBhbmQKPiB0aGUgR09QIGluaXRpYWxpemVkIG9ubHkgdGhlIGV4dGVybmFs
IG1vbml0b3IuCgo+ICsJaWYgKGkyY19jbGllbnRfYWRkcmVzcyA+IDB4ZmYgfHwgcmVnX2FkZHJl
c3MgPiAweGZmKSB7Cj4gKwkJcHJfd2FybigiJXMgd2FybmluZyBhZGRyZXNzZXMgdG9vIGJpZyBj
bGllbnQgMHgleCByZWcgMHgleFxuIiwKPiArCQkJX19mdW5jX18sIGkyY19jbGllbnRfYWRkcmVz
cywgcmVnX2FkZHJlc3MpOwoKSSB0cmllZCB0byBwYXJzZSB0aGUgbWVzc2FnZSBhbmQgZmFpbGVk
LgpQZXJoYXBzIHNvbWV0aGluZyBsaWtlCiIlczogYWRkcmVzc2VzIHRvbyBiaWcgZm9yIGNsaWVu
dCAweCV4LCByZWcgMHgleFxuIgp3b3VsZCBiZSBlYXNpZXIgdG8gdW5kZXJzdGFuZD8KCj4gKwkJ
cmV0dXJuIC1FUkFOR0U7Cj4gKwl9CgotLSAKV2l0aCBCZXN0IFJlZ2FyZHMsCkFuZHkgU2hldmNo
ZW5rbwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCklu
dGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
