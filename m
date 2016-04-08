From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 09/14] x86/tboot: remove paravirt_enabled()
Date: Fri,  8 Apr 2016 16:40:20 -0700
Message-ID: <1460158825-13117-10-git-send-email-mcgrof@kernel.org>
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

VGhlcmUgaXMgYWxyZWFkeSBhIGNoZWNrIGZvciBib290X3BhcmFtcy50Ym9vdF9hZGRyIHByaW9y
CnRvIHBhcmF2aXJ0X2VuYWJsZWQoKS4gQm90aCBYZW4gYW5kIGxndWVzdCwgd2hpY2ggYXJlIGFs
c28gdGhlCm9ubHkgb25lcyB0aGF0IHNldCBwYXJhdmlydF9lbmFibGVkIHRvIHRydWUsIG5ldmVy
IHNldCB0aGUKYm9vdF9wYXJhbXMudGJvb3RfYWRkci4gVGhlIFhlbiBmb2xrcyBhcmUgc3VyZSBh
IGZvcmNlIGRpc2FibGUKdG8gMCBpcyBub3QgbmVlZGVkLCB3ZSByZWNlbnRseSBmb3JjZWQgZGlz
YWJsZWQgdGhpcyBvbiBsZ3Vlc3QuCldpdGggdGhpcyBpbiBwbGFjZSB0aGlzIGNoZWNrIGlzIG5v
IGxvbmdlciBuZWVkZWQuCgpYZW4gZm9sa3MgYXJlIHN1cmUgZm9yY2UgZGlzYWJsZSB0byAwIGlz
IG5vdCBuZWVkZWQgYmVjYXVzZQphcG1faW5mbyBsaXZlcyBpbiAuYnNzLCB3ZSByZWNlbnRseSBm
b3JjZWQgZGlzYWJsZWQgdGhpcyBvbgpsZ3Vlc3QsIGFuZCBvbiB0aGUgWGVuIHNpZGUganVzdCB0
byBiZSBzdXJlIEJvcmlzIHplcm9lZCBvdXQKdGhlIC5ic3MgZm9yIFBWIGd1ZXN0cyB0aHJvdWdo
IGNvbW1pdCAwNGI2YjRhNTY4ODQzMjdjMTY0OAooInhlbi94ODY6IFplcm8gb3V0IC5ic3MgZm9y
IFBWIGd1ZXN0cyIpLiBXaXRoIHRoaXMgY2FyZSB0YWtlbgppbnRvIGNvbnNpZGVyYXRpb24gdGhl
IHBhcmF2aXJ0X2VuYWJsZWQoKSBjaGVjayBpcyBzaW1wbHkgbm90Cm5lZWRlZCBhbnltb3JlLgoK
U2lnbmVkLW9mZi1ieTogTHVpcyBSLiBSb2RyaWd1ZXogPG1jZ3JvZkBrZXJuZWwub3JnPgotLS0K
IGFyY2gveDg2L2tlcm5lbC90Ym9vdC5jIHwgNiAtLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC90Ym9vdC5jIGIvYXJjaC94
ODYva2VybmVsL3Rib290LmMKaW5kZXggZTcyYTA3ZjIwYjA1Li45YjAxODVmYmUzZWIgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC90Ym9vdC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC90Ym9v
dC5jCkBAIC03NCwxMiArNzQsNiBAQCB2b2lkIF9faW5pdCB0Ym9vdF9wcm9iZSh2b2lkKQogCQly
ZXR1cm47CiAJfQogCi0JLyogb25seSBhIG5hdGl2ZWx5IGJvb3RlZCBrZXJuZWwgc2hvdWxkIGJl
IHVzaW5nIFRYVCAqLwotCWlmIChwYXJhdmlydF9lbmFibGVkKCkpIHsKLQkJcHJfd2FybmluZygi
bm9uLTAgdGJvb3RfYWRkciBidXQgcHZfb3BzIGlzIGVuYWJsZWRcbiIpOwotCQlyZXR1cm47Ci0J
fQotCiAJLyogTWFwIGFuZCBjaGVjayBmb3IgdGJvb3QgVVVJRC4gKi8KIAlzZXRfZml4bWFwKEZJ
WF9UQk9PVF9CQVNFLCBib290X3BhcmFtcy50Ym9vdF9hZGRyKTsKIAl0Ym9vdCA9IChzdHJ1Y3Qg
dGJvb3QgKilmaXhfdG9fdmlydChGSVhfVEJPT1RfQkFTRSk7Ci0tIAoyLjcuMgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5n
IGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbi5vcmcKaHR0cDovL2xpc3RzLnhlbi5vcmcveGVuLWRl
dmVsCg==
