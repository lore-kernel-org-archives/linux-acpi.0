From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 02/16] x86/xen: use X86_SUBARCH_XEN for PV
	guest boots
Date: Wed, 13 Apr 2016 17:04:32 -0700
Message-ID: <1460592286-300-3-git-send-email-mcgrof@kernel.org>
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

VGhlIHVzZSBvZiBzdWJhcmNoIHNob3VsZCBoYXZlIG5vIGN1cnJlbnQgZWZmZWN0IG9uIFhlbgpQ
ViBndWVzdHMsIGFzIHN1Y2ggdGhpcyBzaG91bGQgaGF2ZSBubyBjdXJyZW50IGZ1bmN0aW9uYWwK
ZWZmZWN0cy4KClJldmlld2VkLWJ5OiBEYXZpZCBWcmFiZWwgPGRhdmlkLnZyYWJlbEBjaXRyaXgu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBMdWlzIFIuIFJvZHJpZ3VleiA8bWNncm9mQGtlcm5lbC5vcmc+
Ci0tLQogYXJjaC94ODYveGVuL2VubGlnaHRlbi5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni94ZW4vZW5saWdodGVuLmMgYi9hcmNo
L3g4Ni94ZW4vZW5saWdodGVuLmMKaW5kZXggOWI4ZjFlYWNjMTEwLi40MDQ4N2YxZWNiNGMgMTAw
NjQ0Ci0tLSBhL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW4uYworKysgYi9hcmNoL3g4Ni94ZW4vZW5s
aWdodGVuLmMKQEAgLTE2NjEsNiArMTY2MSw3IEBAIGFzbWxpbmthZ2UgX192aXNpYmxlIHZvaWQg
X19pbml0IHhlbl9zdGFydF9rZXJuZWwodm9pZCkKIAlib290X3BhcmFtcy5oZHIucmFtZGlza19p
bWFnZSA9IGluaXRyZF9zdGFydDsKIAlib290X3BhcmFtcy5oZHIucmFtZGlza19zaXplID0geGVu
X3N0YXJ0X2luZm8tPm1vZF9sZW47CiAJYm9vdF9wYXJhbXMuaGRyLmNtZF9saW5lX3B0ciA9IF9f
cGEoeGVuX3N0YXJ0X2luZm8tPmNtZF9saW5lKTsKKwlib290X3BhcmFtcy5oZHIuaGFyZHdhcmVf
c3ViYXJjaCA9IFg4Nl9TVUJBUkNIX1hFTjsKIAogCWlmICgheGVuX2luaXRpYWxfZG9tYWluKCkp
IHsKIAkJYWRkX3ByZWZlcnJlZF9jb25zb2xlKCJ4ZW5ib290IiwgMCwgTlVMTCk7Ci0tIAoyLjcu
MgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1k
ZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbi5vcmcKaHR0cDovL2xpc3RzLnhl
bi5vcmcveGVuLWRldmVsCg==
