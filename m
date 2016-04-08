From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 10/14] x86/cpu/intel: remove not needed
	paravirt_enabled() for f00f work around
Date: Fri,  8 Apr 2016 16:40:21 -0700
Message-ID: <1460158825-13117-11-git-send-email-mcgrof@kernel.org>
References: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: kozerkov@parallels.com, matt@codeblueprint.co.uk, lv.zheng@intel.com, xen-devel@lists.xensource.com, joro@8bytes.org, x86@kernel.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, glin@suse.com, lenb@kernel.org, josh@joshtriplett.org, jlee@suse.com, lguest@lists.ozlabs.org, boris.ostrovsky@oracle.com, andriy.shevchenko@linux.intel.com, toshi.kani@hp.com, andrew.cooper3@citrix.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, luto@amacapital.net, "Luis R. Rodriguez" <mcgrof@kernel.org>, david.vrabel@citrix.com, tiwai@suse.de
List-Id: linux-acpi@vger.kernel.org

VGhlIFg4Nl9CVUdfRjAwRiB3b3JrIGFyb3VuZCBpcyByZXNwb25zaWJsZSBmb3IgZml4aW5nIHVw
IHRoZSBlcnJvcgpnZW5lcmF0ZWQgb24gYXR0ZW1wdGVkIEYwMEYgZXhwbG9pdGF0aW9uIGZyb20g
YW4gT09QUyB0byBhIFNJR0lMTC4KVGhlcmUgaXMgbm8gcmVhc29uIHdoeSB0aGlzIGNvZGUgc2hv
dWxkIG5vdCBiZSBhbGxvd2VkIHRvIHJ1biBvbgpQViBndWVzdCBvbiBhIEYwMEYtYWZmZWN0ZWQg
Q1BVIC0tIGl0IHdvdWxkIHNpbXBseSBuZXZlciB0cmlnZ2VyLgpUaGUgcHZfZW5hYmxlZCgpIGNo
ZWNrIHdhcyB0aGVyZSBvbmx5IHRvIGF2b2lkIHByaW50aW5nIHRoZSBmMDBmCndvcmthcm91bmQs
IHNvIHJlbW92aW5nIHRoZSBjaGVjayBpcyBwdXJlbHkgYSBjb3NtZXRpYyBjaGFuZ2UuCgpTdWdn
ZXN0ZWQtYnk6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BhbWFjYXBpdGFsLm5ldD4KU2lnbmVkLW9m
Zi1ieTogTHVpcyBSLiBSb2RyaWd1ZXogPG1jZ3JvZkBrZXJuZWwub3JnPgotLS0KIGFyY2gveDg2
L2tlcm5lbC9jcHUvaW50ZWwuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvaW50ZWwu
YyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvaW50ZWwuYwppbmRleCBmNzFhMzQ5NDRiNTYuLjY2NTA5
Mjg1ZmZkZCAxMDA2NDQKLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9pbnRlbC5jCisrKyBiL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvaW50ZWwuYwpAQCAtMjMzLDcgKzIzMyw3IEBAIHN0YXRpYyB2b2lk
IGludGVsX3dvcmthcm91bmRzKHN0cnVjdCBjcHVpbmZvX3g4NiAqYykKIAkgKiBUaGUgUXVhcmsg
aXMgYWxzbyBmYW1pbHkgNSwgYnV0IGRvZXMgbm90IGhhdmUgdGhlIHNhbWUgYnVnLgogCSAqLwog
CWNsZWFyX2NwdV9idWcoYywgWDg2X0JVR19GMDBGKTsKLQlpZiAoIXBhcmF2aXJ0X2VuYWJsZWQo
KSAmJiBjLT54ODYgPT0gNSAmJiBjLT54ODZfbW9kZWwgPCA5KSB7CisJaWYgKGMtPng4NiA9PSA1
ICYmIGMtPng4Nl9tb2RlbCA8IDkpIHsKIAkJc3RhdGljIGludCBmMDBmX3dvcmthcm91bmRfZW5h
YmxlZDsKIAogCQlzZXRfY3B1X2J1ZyhjLCBYODZfQlVHX0YwMEYpOwotLSAKMi43LjIKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpYZW4tZGV2ZWwgbWFp
bGluZyBsaXN0Clhlbi1kZXZlbEBsaXN0cy54ZW4ub3JnCmh0dHA6Ly9saXN0cy54ZW4ub3JnL3hl
bi1kZXZlbAo=
