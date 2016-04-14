From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 12/16] x86,
	ACPI: parse ACPI_FADT_LEGACY_DEVICES
Date: Wed, 13 Apr 2016 17:04:42 -0700
Message-ID: <1460592286-300-13-git-send-email-mcgrof@kernel.org>
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

QUNQSSA1LjIuOS4zIElBLVBDIEJvb3QgQXJjaGl0ZWN0dXJlIGZsYWcgQUNQSV9GQURUX0xFR0FD
WV9ERVZJQ0VTCmNhbiBiZSB1c2VkIHRvIGRldGVybWluZSBpZiBhIHN5c3RlbSBoYXMgbGVnYWN5
IGRldmljZXMgTFBDIG9yCklTQSBkZXZpY2VzLiBUaGUgeDg2IHBsYXRmb3JtIGFscmVhZHkgaGFz
IGEgc3RydWN0IHdoaWNoIGxpc3RzCmtub3duIGFzc29jaWF0ZWQgbGVnYWN5IGRldmljZXMsIHdl
IHN0YXJ0IG9mZiBjYXJlZnVsIG9ubHkKYnkgZGlzYWJsaW5nIHJvb3QgZGV2aWNlcyB3ZSBzaG91
bGQgbm90IHJlZ3Jlc3Mgd2l0aC4gVGhlIHN0cnVjdAphbmQgZGV2aWNlIGxpc3QgY2FuIGJlIGV4
cGFuZGVkIHdpdGggdGltZSB0byBjb3ZlciBtb3JlIHJvb3QKbGVnYWN5IGNvbXBvbmVudHMuCgpT
aWduZWQtb2ZmLWJ5OiBMdWlzIFIuIFJvZHJpZ3VleiA8bWNncm9mQGtlcm5lbC5vcmc+Ci0tLQog
YXJjaC94ODYva2VybmVsL2FjcGkvYm9vdC5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hY3BpL2Jvb3QuYyBi
L2FyY2gveDg2L2tlcm5lbC9hY3BpL2Jvb3QuYwppbmRleCA4YzljMmJkYmEwOTIuLmM5YTA2ZTU3
M2ZhNSAxMDA2NDQKLS0tIGEvYXJjaC94ODYva2VybmVsL2FjcGkvYm9vdC5jCisrKyBiL2FyY2gv
eDg2L2tlcm5lbC9hY3BpL2Jvb3QuYwpAQCAtOTEzLDYgKzkxMywxMSBAQCBsYXRlX2luaXRjYWxs
KGhwZXRfaW5zZXJ0X3Jlc291cmNlKTsKIAogc3RhdGljIGludCBfX2luaXQgYWNwaV9wYXJzZV9m
YWR0KHN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlciAqdGFibGUpCiB7CisJaWYgKCEoYWNwaV9nYmxf
RkFEVC5ib290X2ZsYWdzICYgQUNQSV9GQURUX0xFR0FDWV9ERVZJQ0VTKSkgeworCQlwcl9kZWJ1
ZygiQUNQSTogbm8gbGVnYWN5IGRldmljZXMgcHJlc2VudFxuIik7CisJCXg4Nl9wbGF0Zm9ybS5s
ZWdhY3kuZGV2aWNlcy5wbnBiaW9zID0gMDsKKwl9CisKIAlpZiAoYWNwaV9nYmxfRkFEVC5ib290
X2ZsYWdzICYgQUNQSV9GQURUX05PX0NNT1NfUlRDKSB7CiAJCXByX2RlYnVnKCJBQ1BJOiBub3Qg
cmVnaXN0ZXJpbmcgUlRDIHBsYXRmb3JtIGRldmljZVxuIik7CiAJCXg4Nl9wbGF0Zm9ybS5sZWdh
Y3kucnRjID0gMDsKLS0gCjIuNy4yCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KWGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVu
Lm9yZwpodHRwOi8vbGlzdHMueGVuLm9yZy94ZW4tZGV2ZWwK
