From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 07/14] tools/lguest: force disable tboot and
	apm
Date: Fri,  8 Apr 2016 16:40:18 -0700
Message-ID: <1460158825-13117-8-git-send-email-mcgrof@kernel.org>
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

VGhlIHBhcmF2aXJ0X2VuYWJsZWQoKSBjaGVjayBpcyBnb2luZyBhd2F5LCB0aGUgYXJlYSB0b3Nz
ZWQgdG8KdGhlIGtlcm5lbCBvbiBsZ3Vlc3QgaXMgbm90IHplcm9yZWQgb3V0LCBzbyBlbnN1cmUg
bGd1ZXN0IGZvcmNlCmRpc2FibGVzIHRib290IGFuZCBhcG0ganVzdCBpbiBjYXNlIHRoZSBrZXJu
ZWwgZmlsZSBiZWluZyByZWFkIG1pZ2h0CmhhdmUgdGhpcyBzZXQgZm9yIHdoYXRldmVyIHJlYXNv
bi4KClNpZ25lZC1vZmYtYnk6IEx1aXMgUi4gUm9kcmlndWV6IDxtY2dyb2ZAa2VybmVsLm9yZz4K
LS0tCiB0b29scy9sZ3Vlc3QvbGd1ZXN0LmMgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL2xndWVzdC9sZ3Vlc3QuYyBiL3Rvb2xz
L2xndWVzdC9sZ3Vlc3QuYwppbmRleCBmZjBhYTU4MGM2ZTEuLjBhYTc1YWY2ZTg2MiAxMDA2NDQK
LS0tIGEvdG9vbHMvbGd1ZXN0L2xndWVzdC5jCisrKyBiL3Rvb2xzL2xndWVzdC9sZ3Vlc3QuYwpA
QCAtMzM1Nyw2ICszMzU3LDEyIEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAJ
LyogVGVsbCB0aGUgZW50cnkgcGF0aCBub3QgdG8gdHJ5IHRvIHJlbG9hZCBzZWdtZW50IHJlZ2lz
dGVycy4gKi8KIAlib290LT5oZHIubG9hZGZsYWdzIHw9IEtFRVBfU0VHTUVOVFM7CiAKKwkvKiBX
ZSBkb24ndCBzdXBwb3J0IHRib290ICovCisJYm9vdC0+dGJvb3RfYWRkciA9IDA7CisKKwkvKiBF
bnN1cmUgdGhpcyBpcyAwIHRvIHByZXZlbnQgYXBtIGZyb20gbG9hZGluZyAqLworCWJvb3QtPmFw
bV9iaW9zX2luZm8udmVyc2lvbiA9IDA7CisKIAkvKiBXZSB0ZWxsIHRoZSBrZXJuZWwgdG8gaW5p
dGlhbGl6ZSB0aGUgR3Vlc3QuICovCiAJdGVsbF9rZXJuZWwoc3RhcnQpOwogCi0tIAoyLjcuMgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZl
bCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbi5vcmcKaHR0cDovL2xpc3RzLnhlbi5v
cmcveGVuLWRldmVsCg==
