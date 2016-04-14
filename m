From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 15/16] x86/init: disable pnpbios for
	X86_SUBARCH_INTEL_MID
Date: Wed, 13 Apr 2016 17:04:45 -0700
Message-ID: <1460592286-300-16-git-send-email-mcgrof@kernel.org>
References: <1460592286-300-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1460592286-300-1-git-send-email-mcgrof@kernel.org>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: kozerkov@parallels.com, matt@codeblueprint.co.uk, bigeasy@linutronix.de, lv.zheng@intel.com, ffainelli@freebox.fr, mbizon@freebox.fr, xen-devel@lists.xensource.com, x86@kernel.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, glin@suse.com, lenb@kernel.org, julien.grall@linaro.org, josh@joshtriplett.org, george.dunlap@citrix.com, jlee@suse.com, lguest@lists.ozlabs.org, boris.ostrovsky@oracle.com, andriy.shevchenko@linux.intel.com, jgross@suse.com, toshi.kani@hp.com, andrew.cooper3@citrix.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, luto@amacapital.net, "Luis R. Rodriguez" <mcgrof@kernel.org>, david.vrabel@citrix.com, tiwai@suse.de
List-Id: linux-acpi@vger.kernel.org

QXMgcGVyIGhwYSBJbnRlbCBNSUQgcGxhdGZvcm1zIGNhbiBhbHNvIGRpc2FibGUgcG5wYmlvcyBb
MF0uCgpBcyBwZXIgMC1kYXksIHRoaXMgYnVtcHMgdGhlIHZtbGludXggc2l6ZSB1c2luZyBpMzg2
LXRpbnljb25maWcgYXMKZm9sbG93czoKClRPVEFMICAgVEVYVCAgIGluaXQudGV4dCAgIHg4Nl9l
YXJseV9pbml0X3BsYXRmb3JtX3F1aXJrcygpCi04ICAgICAgLTggICAgIC04ICAgICAgICAgIC04
CgpbMF0gaHR0cDovL2xrbWwua2VybmVsLm9yZy9yLzU3MDJCNUMyLjcwNzAxMDFAenl0b3IuY29t
Cgp2NjogYWRkIDAtZGF5IHNpemUgaW1wYWN0CgpTdWdnZXN0ZWQtYnk6IEguIFBldGVyIEFudmlu
IDxocGFAenl0b3IuY29tPgpTaWduZWQtb2ZmLWJ5OiBMdWlzIFIuIFJvZHJpZ3VleiA8bWNncm9m
QGtlcm5lbC5vcmc+Ci0tLQogYXJjaC94ODYva2VybmVsL3BsYXRmb3JtLXF1aXJrcy5jIHwgNCAr
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3BsYXRmb3JtLXF1aXJrcy5jIGIvYXJjaC94ODYva2Vy
bmVsL3BsYXRmb3JtLXF1aXJrcy5jCmluZGV4IGFiNjQzODI1YTdhYS4uODUzOTE5NDg0MzQwIDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvcGxhdGZvcm0tcXVpcmtzLmMKKysrIGIvYXJjaC94
ODYva2VybmVsL3BsYXRmb3JtLXF1aXJrcy5jCkBAIC0xNiwxMCArMTYsOCBAQCB2b2lkIF9faW5p
dCB4ODZfZWFybHlfaW5pdF9wbGF0Zm9ybV9xdWlya3Modm9pZCkKIAkJYnJlYWs7CiAJY2FzZSBY
ODZfU1VCQVJDSF9YRU46CiAJY2FzZSBYODZfU1VCQVJDSF9MR1VFU1Q6Ci0JCXg4Nl9wbGF0Zm9y
bS5sZWdhY3kuZGV2aWNlcy5wbnBiaW9zID0gMDsKLQkJeDg2X3BsYXRmb3JtLmxlZ2FjeS5ydGMg
PSAwOwotCQlicmVhazsKIAljYXNlIFg4Nl9TVUJBUkNIX0lOVEVMX01JRDoKKwkJeDg2X3BsYXRm
b3JtLmxlZ2FjeS5kZXZpY2VzLnBucGJpb3MgPSAwOwogCQl4ODZfcGxhdGZvcm0ubGVnYWN5LnJ0
YyA9IDA7CiAJCWJyZWFrOwogCX0KLS0gCjIuNy4yCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxA
bGlzdHMueGVuLm9yZwpodHRwOi8vbGlzdHMueGVuLm9yZy94ZW4tZGV2ZWwK
