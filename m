From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 03/14] tools/lguest: make lguest launcher use
	X86_SUBARCH_LGUEST explicitly
Date: Fri,  8 Apr 2016 16:40:14 -0700
Message-ID: <1460158825-13117-4-git-send-email-mcgrof@kernel.org>
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

QmUgZXhwbGljaXQgYW5kIG1ha2UgdXNlIG9mIFg4Nl9TVUJBUkNIX0xHVUVTVCBkaXJlY3RseS4K
ClNpZ25lZC1vZmYtYnk6IEx1aXMgUi4gUm9kcmlndWV6IDxtY2dyb2ZAa2VybmVsLm9yZz4KLS0t
CiB0b29scy9sZ3Vlc3QvbGd1ZXN0LmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdG9vbHMvbGd1ZXN0L2xndWVz
dC5jIGIvdG9vbHMvbGd1ZXN0L2xndWVzdC5jCmluZGV4IDgwMTU5ZTY4MTFjMi4uZmYwYWE1ODBj
NmUxIDEwMDY0NAotLS0gYS90b29scy9sZ3Vlc3QvbGd1ZXN0LmMKKysrIGIvdG9vbHMvbGd1ZXN0
L2xndWVzdC5jCkBAIC0zMzUxLDggKzMzNTEsOCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
YXJndltdKQogCS8qIEJvb3QgcHJvdG9jb2wgdmVyc2lvbjogMi4wNyBzdXBwb3J0cyB0aGUgZmll
bGRzIGZvciBsZ3Vlc3QuICovCiAJYm9vdC0+aGRyLnZlcnNpb24gPSAweDIwNzsKIAotCS8qIFRo
ZSBoYXJkd2FyZV9zdWJhcmNoIHZhbHVlIG9mICIxIiB0ZWxscyB0aGUgR3Vlc3QgaXQncyBhbiBs
Z3Vlc3QuICovCi0JYm9vdC0+aGRyLmhhcmR3YXJlX3N1YmFyY2ggPSAxOworCS8qIFg4Nl9TVUJB
UkNIX0xHVUVTVCB0ZWxscyB0aGUgR3Vlc3QgaXQncyBhbiBsZ3Vlc3QuICovCisJYm9vdC0+aGRy
LmhhcmR3YXJlX3N1YmFyY2ggPSBYODZfU1VCQVJDSF9MR1VFU1Q7CiAKIAkvKiBUZWxsIHRoZSBl
bnRyeSBwYXRoIG5vdCB0byB0cnkgdG8gcmVsb2FkIHNlZ21lbnQgcmVnaXN0ZXJzLiAqLwogCWJv
b3QtPmhkci5sb2FkZmxhZ3MgfD0gS0VFUF9TRUdNRU5UUzsKLS0gCjIuNy4yCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVsIG1haWxpbmcg
bGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwOi8vbGlzdHMueGVuLm9yZy94ZW4tZGV2
ZWwK
