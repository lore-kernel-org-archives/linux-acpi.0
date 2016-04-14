From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 13/16] x86/init: rename ebda code file
Date: Wed, 13 Apr 2016 17:04:43 -0700
Message-ID: <1460592286-300-14-git-send-email-mcgrof@kernel.org>
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

VGhpcyBtYWtlcyBpdCBjbGVhcmVyIHdoYXQgdGhpcyBpcy4KClNpZ25lZC1vZmYtYnk6IEx1aXMg
Ui4gUm9kcmlndWV6IDxtY2dyb2ZAa2VybmVsLm9yZz4KLS0tCiBhcmNoL3g4Ni9NYWtlZmlsZSAg
ICAgICAgICAgICAgICAgIHwgMiArLQogYXJjaC94ODYva2VybmVsL01ha2VmaWxlICAgICAgICAg
ICB8IDIgKy0KIGFyY2gveDg2L2tlcm5lbC97aGVhZC5jID0+IGViZGEuY30gfCAwCiAzIGZpbGVz
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKIHJlbmFtZSBhcmNoL3g4
Ni9rZXJuZWwve2hlYWQuYyA9PiBlYmRhLmN9ICgxMDAlKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2
L01ha2VmaWxlIGIvYXJjaC94ODYvTWFrZWZpbGUKaW5kZXggZjllZDhhN2NlMmI2Li42ZmNlN2Yw
OTZiODggMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L01ha2VmaWxlCisrKyBiL2FyY2gveDg2L01ha2Vm
aWxlCkBAIC0yMDgsNyArMjA4LDcgQEAgZW5kaWYKIAogaGVhZC15IDo9IGFyY2gveDg2L2tlcm5l
bC9oZWFkXyQoQklUUykubwogaGVhZC15ICs9IGFyY2gveDg2L2tlcm5lbC9oZWFkJChCSVRTKS5v
Ci1oZWFkLXkgKz0gYXJjaC94ODYva2VybmVsL2hlYWQubworaGVhZC15ICs9IGFyY2gveDg2L2tl
cm5lbC9lYmRhLm8KIGhlYWQteSArPSBhcmNoL3g4Ni9rZXJuZWwvcGxhdGZvcm0tcXVpcmtzLm8K
IAogbGlicy15ICArPSBhcmNoL3g4Ni9saWIvCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwv
TWFrZWZpbGUgYi9hcmNoL3g4Ni9rZXJuZWwvTWFrZWZpbGUKaW5kZXggN2E5ZTQ0ZDkzNWRlLi4w
NTAzZjViZmIxOGQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9NYWtlZmlsZQorKysgYi9h
cmNoL3g4Ni9rZXJuZWwvTWFrZWZpbGUKQEAgLTQsNyArNCw3IEBACiAKIGV4dHJhLXkJOj0gaGVh
ZF8kKEJJVFMpLm8KIGV4dHJhLXkJKz0gaGVhZCQoQklUUykubwotZXh0cmEteQkrPSBoZWFkLm8K
K2V4dHJhLXkJKz0gZWJkYS5vCiBleHRyYS15CSs9IHBsYXRmb3JtLXF1aXJrcy5vCiBleHRyYS15
CSs9IHZtbGludXgubGRzCiAKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9oZWFkLmMgYi9h
cmNoL3g4Ni9rZXJuZWwvZWJkYS5jCnNpbWlsYXJpdHkgaW5kZXggMTAwJQpyZW5hbWUgZnJvbSBh
cmNoL3g4Ni9rZXJuZWwvaGVhZC5jCnJlbmFtZSB0byBhcmNoL3g4Ni9rZXJuZWwvZWJkYS5jCi0t
IAoyLjcuMgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Clhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbi5vcmcKaHR0cDovL2xp
c3RzLnhlbi5vcmcveGVuLWRldmVsCg==
