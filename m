From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 08/16] apm32: remove paravirt_enabled() use
Date: Wed, 13 Apr 2016 17:04:38 -0700
Message-ID: <1460592286-300-9-git-send-email-mcgrof@kernel.org>
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

VGhlcmUgaXMgYWxyZWFkeSBhIGNoZWNrIGZvciBhcG1faW5mby5iaW9zID09IDAsIHRoZQphcG1f
aW5mby5iaW9zIGlzIHNldCBmcm9tIHRoZSBib290X3BhcmFtcy5hcG1fYmlvc19pbmZvLgpCb3Ro
IFhlbiBhbmQgbGd1ZXN0LCB3aGljaCBhcmUgYWxzbyB0aGUgb25seSBvbmVzIHRoYXQgc2V0CnBh
cmF2aXJ0X2VuYWJsZWQgdG8gdHJ1ZSwgbmV2ZXIgc2V0IHRoZSBhcG1fYmlvcy5pbmZvLiBUaGUK
ClhlbiBmb2xrcyBhcmUgc3VyZSBmb3JjZSBkaXNhYmxlIHRvIDAgaXMgbm90IG5lZWRlZCBiZWNh
dXNlCmFwbV9pbmZvIGxpdmVzIGluIC5ic3MsIHdlIHJlY2VudGx5IGZvcmNlZCBkaXNhYmxlZCB0
aGlzIG9uCmxndWVzdCwgYW5kIG9uIHRoZSBYZW4gc2lkZSBqdXN0IHRvIGJlIHN1cmUgQm9yaXMg
emVyb2VkIG91dAp0aGUgLmJzcyBmb3IgUFYgZ3Vlc3RzIHRocm91Z2ggY29tbWl0IDA0YjZiNGE1
Njg4NDMyN2MxNjQ4CigieGVuL3g4NjogWmVybyBvdXQgLmJzcyBmb3IgUFYgZ3Vlc3RzIikuIFdp
dGggdGhpcyBjYXJlIHRha2VuCmludG8gY29uc2lkZXJhdGlvbiB0aGUgcGFyYXZpcnRfZW5hYmxl
ZCgpIGNoZWNrIGlzIHNpbXBseSBub3QKbmVlZGVkIGFueW1vcmUuCgpTaWduZWQtb2ZmLWJ5OiBM
dWlzIFIuIFJvZHJpZ3VleiA8bWNncm9mQGtlcm5lbC5vcmc+Ci0tLQogYXJjaC94ODYva2VybmVs
L2FwbV8zMi5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2FwbV8zMi5jIGIvYXJjaC94ODYv
a2VybmVsL2FwbV8zMi5jCmluZGV4IDkzMDdmMTgyZmUzMC4uYzczNjRiZDYzM2UxIDEwMDY0NAot
LS0gYS9hcmNoL3g4Ni9rZXJuZWwvYXBtXzMyLmMKKysrIGIvYXJjaC94ODYva2VybmVsL2FwbV8z
Mi5jCkBAIC0yMjY3LDcgKzIyNjcsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBhcG1faW5pdCh2b2lk
KQogCiAJZG1pX2NoZWNrX3N5c3RlbShhcG1fZG1pX3RhYmxlKTsKIAotCWlmIChhcG1faW5mby5i
aW9zLnZlcnNpb24gPT0gMCB8fCBwYXJhdmlydF9lbmFibGVkKCkgfHwgbWFjaGluZV9pc19vbHBj
KCkpIHsKKwlpZiAoYXBtX2luZm8uYmlvcy52ZXJzaW9uID09IDAgfHwgbWFjaGluZV9pc19vbHBj
KCkpIHsKIAkJcHJpbnRrKEtFUk5fSU5GTyAiYXBtOiBCSU9TIG5vdCBmb3VuZC5cbiIpOwogCQly
ZXR1cm4gLUVOT0RFVjsKIAl9Ci0tIAoyLjcuMgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxp
c3RzLnhlbi5vcmcKaHR0cDovL2xpc3RzLnhlbi5vcmcveGVuLWRldmVsCg==
